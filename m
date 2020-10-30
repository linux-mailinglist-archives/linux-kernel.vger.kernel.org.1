Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404032A0E23
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgJ3SzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:55:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36607 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgJ3SzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:55:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id 32so6496876otm.3;
        Fri, 30 Oct 2020 11:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VEJSrrlWi4nGgCuwCiPdo92Bvw6wzA2qRIk7ryIipEQ=;
        b=AJh3T0unAZ+aq0lng7FbzrXsjsEePl/lmsTibS6VOGzhHXKenUc1UrXcnL5uSd3piU
         GLr45TQiYRhaDtVARjxCECvHF+1E8HCBaXnHIDWSEi6stSsX8aI8jnhn34RM5HsJQZsD
         mvU9YVGMViNyA62VMAJ7crcsDpsulHAZGO8DVmLY1wramcQgRb/phU+HhqspONHDLEgy
         QkrfZ1NlQn6kwroxa85eOulAvdFMMzQ2wwL5I8deauNiWdgovBDkOBHfTmKc3KCNZEZA
         M5MRknk8crR78m9bdxzQhPMBoLqhChdj6CpMBhhNx9gxnOOzPqFMpnXxaovYuPQx0kbu
         i4uA==
X-Gm-Message-State: AOAM531rD2olXaPqgHWSp5S5uSF+nD4jMa8TYBFbRCKPNuvZQYu6apTO
        w81qhLNaAYTLtTkmPjo5nA==
X-Google-Smtp-Source: ABdhPJzt5b9EvIvjswnpcPiateFic+Ourf33V0RDiFsTxROsokE5KAZ93O78JglWQuUFJFlYkwo0HQ==
X-Received: by 2002:a9d:39e1:: with SMTP id y88mr2834129otb.39.1604084116226;
        Fri, 30 Oct 2020 11:55:16 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h15sm1529750ots.31.2020.10.30.11.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 11:55:15 -0700 (PDT)
Received: (nullmailer pid 4142058 invoked by uid 1000);
        Fri, 30 Oct 2020 18:55:14 -0000
Date:   Fri, 30 Oct 2020 13:55:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, sudeep.holla@arm.com,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, broonie@kernel.org,
        satyakim@qti.qualcomm.com, etienne.carriere@linaro.org,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH v3 4/4] dt-bindings: arm: add support for SCMI Regulators
Message-ID: <20201030185514.GA4129214@bogus>
References: <20201026203148.47416-1-cristian.marussi@arm.com>
 <20201026203148.47416-5-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026203148.47416-5-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 08:31:48PM +0000, Cristian Marussi wrote:
> Add devicetree bindings to support regulators based on SCMI Voltage
> Domain Protocol.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v2 --> v3
> - avoid awkard examples based on _cpu/_gpu regulators
> v1 --> v2
> - removed any reference to negative voltages
> ---
>  .../devicetree/bindings/arm/arm,scmi.txt      | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> index 55deb68230eb..0cef83a60f03 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> @@ -62,6 +62,28 @@ Required properties:
>   - #power-domain-cells : Should be 1. Contains the device or the power
>  			 domain ID value used by SCMI commands.
>  
> +Regulator bindings for the SCMI Regulator based on SCMI Message Protocol
> +------------------------------------------------------------
> +
> +An SCMI Regulator is permanently bound to a well defined SCMI Voltage Domain,
> +and should be always positioned as a root regulator.
> +It does not support any current operation.
> +
> +This binding uses the common regulator binding[6].
> +
> +SCMI Regulators are grouped under a 'regulators' node which in turn is a child
> +of the SCMI Voltage protocol node inside the desired SCMI instance node.
> +
> +Required properties:
> + - reg : shall identify an existent SCMI Voltage Domain.
> +
> +Optional properties:
> + - all of the other standard regulator bindings as in [6]: note that, since
> +   the SCMI Protocol itself aims in fact to hide away many of the operational
> +   capabilities usually exposed by the properties of a standard regulator,
> +   most of the usual regulator bindings could have just no effect in the
> +   context of this SCMI regulator.

You can't have it both ways... You should list out which ones apply.

I'm a bit worried that now we're changing CPUs (at least?) from clocks 
to 'performance domains' while at the same time here we're adding 
low level, virtual regulators. Are we going to end up wanting something 
more abstract here too?

> +
>  Sensor bindings for the sensors based on SCMI Message Protocol
>  --------------------------------------------------------------
>  SCMI provides an API to access the various sensors on the SoC.
> @@ -105,6 +127,7 @@ Required sub-node properties:
>  [3] Documentation/devicetree/bindings/thermal/thermal*.yaml
>  [4] Documentation/devicetree/bindings/sram/sram.yaml
>  [5] Documentation/devicetree/bindings/reset/reset.txt
> +[6] Documentation/devicetree/bindings/regulator/regulator.yaml
>  
>  Example:
>  
> @@ -169,6 +192,25 @@ firmware {
>  			reg = <0x16>;
>  			#reset-cells = <1>;
>  		};
> +
> +		scmi_voltage: protocol@17 {
> +			reg = <0x17>;
> +
> +			regulators {
> +				regulator_devX: regulator_scmi_devX@0 {

Node names should be generic:

regulator@0

> +					reg = <0x0>;
> +					regulator-max-microvolt = <3300000>;
> +				};
> +
> +				regulator_devY: regulator_scmi_devY@9 {
> +					reg = <0x9>;
> +					regulator-min-microvolt = <500000>;
> +					regulator-max-microvolt = <4200000>;
> +				};
> +
> +				...
> +			};
> +		};
>  	};
>  };
>  
> -- 
> 2.17.1
> 
