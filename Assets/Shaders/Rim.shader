Shader "Salinger/Rim" 
{
	Properties{
		_RimColor("Rim Color", Color) = (1,1,1,1)
		_RimColor2("Rim Color", Color) = (1,1,1,1)
		_RimPower("Rim Power", Range(0.5, 8.0)) = 3.0
		_RimPoint("Rim Point", Range(0.0, 1.0)) = 0.5
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert
        
		float4 _RimColor;
		float4 _RimColor2;
		float _RimPower;
		float _RimPoint;

        struct Input {
			float3 viewDir;
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
			half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
			//o.Emission = _RimColor.rgb * pow(rim, _RimPower);
			//o.Emission = rim > 0.5 ? _RimColor : _RimColor2;
			o.Emission = rim > _RimPoint ? _RimColor : _RimColor2;
        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }
