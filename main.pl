% Taken and modified from https://gist.github.com/MuffinTheMan/7806903
% Get an element from a 2-dimensional list at (Row,Column)
% using 1-based indexing.
nth1_2d(Row, Column, List, Element) :-
    nth1(Row, List, SubList),
    nth1(Column, SubList, Element).


% Top-level predicate
alive(Row, Column, BoardFileName):-
    see(BoardFileName),     % Loads the input-file
    read(Board),            % Reads the first Prolog-term from the file
    seen,                   % Closes the io-stream
    nth1_2d(Row, Column, Board, Stone),
    (Stone = w; Stone = b),
    check_alive(Row, Column, Board, Stone, []).

% Checks whether the group of stones connected to
% the stone located at (Row, Column) is alive or dead.
check_alive(Row, Column, Board, Firststone, Checked):-
    % Get stone
    nth1_2d(Row, Column, Board, Stone),
    
    % If empty square
    (
        Stone = e;

        (
            % If in same group as first stone
            Stone = Firststone,

            % Stone has not already been checked
            \+ (already_checked((Row,Column), Checked)),

            % Set coordinates for neigbours
            (
                Up is (Row-1),
                Right is (Column+1),
                Down is (Row+1),
                Left is (Column-1),
                % Recursively check neigbours
                (
                    check_alive(Up, Column, Board, Firststone, [(Row, Column) | Checked]);
                    check_alive(Row, Right, Board, Firststone, [(Row, Column) | Checked]);
                    check_alive(Down, Column, Board, Firststone, [(Row, Column) | Checked]);
                    check_alive(Row, Left, Board, Firststone, [(Row, Column) | Checked])
                )
            )
        )
    ).

already_checked(Coordinate, [Head | Tail]):-
    Coordinate = Head;
    already_checked(Coordinate, Tail).