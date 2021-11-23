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
    check_alive(Row, Column, Board).

% Checks whether the group of stones connected to
% the stone located at (Row, Column) is alive or dead.
check_alive(Row, Column, Board):-
    nth1_2d(Row, Column, Board, Stone),
    (Stone = b; Stone = w),
    check_adjacent(Row, Column, Board, Stone).

% Checks whether adjacent places are empty or in same group
check_adjacent(Row, Column, Board, Stone):-
    Left is Row-1,
    Down is Column+1,
    Right is Row+1,
    Up is Column-1,
    (nth1_2d(Left, Column, Board, Stoney), (Stoney = e; Stoney = Stone -> check_alive(Left, Column, Board)));
    (nth1_2d(Row, Up, Board, Stoney), (Stoney = e; Stoney = Stone -> check_alive(Row, Up, Board)));
    (nth1_2d(Right, Column, Board, Stoney), (Stoney = e; Stoney = Stone -> check_alive(Right, Column, Board)));
    (nth1_2d(Row, Down, Board, Stoney), (Stoney = e; Stoney = Stone -> check_alive(Row, Down, Board))).