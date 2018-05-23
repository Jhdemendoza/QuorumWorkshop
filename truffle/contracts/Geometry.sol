pragma solidity ^0.4.21;

contract Geometry {

    event NewPoint(uint256 x, uint256 y, uint256 id);
    event XChanged(uint256 x, uint256 y, uint256 id);
    event YChanged(uint256 x, uint256 y, uint256 id);
    
    struct Point {
        uint256 x;
        uint256 y;
    }

    Point[] public points;

    function createPoint(uint256 _x, uint256 _y) public {
        uint256 pointId = points.push(Point(_x, _y))-1;
        emit NewPoint(_x, _y, pointId);
    }

    function updateX(uint256 _pointId, uint256 _x) public {
        Point memory auxPoint = points[_pointId];
        auxPoint.x = _x;
        points[_pointId] = auxPoint;
        emit XChanged(auxPoint.x, auxPoint.y, _pointId);
    }

    function updateY(uint256 _pointId, uint256 _y) public {
        Point memory auxPoint = points[_pointId];
        auxPoint.y = _y;
        points[_pointId] = auxPoint;
        emit YChanged(auxPoint.x, auxPoint.y, _pointId);
    }

}