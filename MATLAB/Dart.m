classdef Dart
    properties
        xpos % X position of the dart
        ypos % Y position of the dart
        zpos % Z position of the dart
    end
    
    methods
        % Constructor
        function obj = Dart(xpos, ypos, zpos)
            if nargin == 3
                obj.xpos = xpos;
                obj.ypos = ypos;
                obj.zpos = zpos;
            end
        end
        
        % Getter method for xpos
        function x = get.xpos(obj)
            x = obj.xpos;
        end
        
        % Setter method for xpos
        function obj = set.xpos(obj, x)
            validateattributes(x, {'numeric'}, {'scalar'});
            obj.xpos = x;
        end
        
        % Getter method for ypos
        function y = get.ypos(obj)
            y = obj.ypos;
        end
        
        % Setter method for ypos
        function obj = set.ypos(obj, y)
            validateattributes(y, {'numeric'}, {'scalar'});
            obj.ypos = y;
        end
        
        % Getter method for zpos
        function z = get.zpos(obj)
            z = obj.zpos;
        end
        
        % Setter method for zpos
        function obj = set.zpos(obj, z)
            validateattributes(z, {'numeric'}, {'scalar'});
            obj.zpos = z;
        end
    end
end
