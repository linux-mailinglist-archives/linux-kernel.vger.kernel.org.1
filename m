Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6608D27D79B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgI2UHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:07:48 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36292 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgI2UHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:07:48 -0400
Received: by mail-oi1-f196.google.com with SMTP id v20so6913366oiv.3;
        Tue, 29 Sep 2020 13:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rjkRMKe2YFWGkYpg82cZxc6ivkbTaietiB+dssBlI/A=;
        b=dKUSWQJMCgf0lTQeoYTMISsQ8xq0nhGqnMcV+xziechlrJdr3rF/jvrTT1IkMD4Ks0
         Lrhw9CeOiJxm6UA9+2qJz05ijSyTR6IIg2iChY8eRwFzc9dINauNCocnNWkpSr/T4vIA
         ixtdwwes2PmH3rZzC0WNqmD3qec3hf/TeBkGTvhpXFOuB4yxY6yf5jrRcpArVEhkqyOk
         4YgfcvQx5Prx64cyNoUQqCbhJfMTjMTBU01oAlOMQN1/JCQBujcLva2QBFMlK3BAU0t6
         Fbxx9uJEvR+/d/1rEhMdOkyG4PjQWp374RfK74qcKDtMxC5dWpj6lBerveFMdCvgtjpl
         KgKA==
X-Gm-Message-State: AOAM531l2oRb+BXj9LVIeoLT43Ft0Mon0mDPYOlP4rP5sU4/Os2J1JNH
        jdj1lQKOnTiEnZF1rWu2yQ==
X-Google-Smtp-Source: ABdhPJx3FcZ2tsScqfp6APqUDY97Si2ZCBWog9qq1syqCg8AyXPaV4ThfvJKbHxWTX4096GWrJ9AHA==
X-Received: by 2002:aca:dcd7:: with SMTP id t206mr3496802oig.134.1601410067108;
        Tue, 29 Sep 2020 13:07:47 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t22sm1236619otq.44.2020.09.29.13.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:07:46 -0700 (PDT)
Received: (nullmailer pid 1077040 invoked by uid 1000);
        Tue, 29 Sep 2020 20:07:45 -0000
Date:   Tue, 29 Sep 2020 15:07:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alban Bedel <alban.bedel@aerq.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: hwmon: Convert lm75 bindings to yaml
Message-ID: <20200929200745.GA1074828@bogus>
References: <20200928153923.134151-1-alban.bedel@aerq.com>
 <20200928153923.134151-2-alban.bedel@aerq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928153923.134151-2-alban.bedel@aerq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 05:39:21PM +0200, Alban Bedel wrote:
> In order to automate the verification of DT nodes convert lm75.txt to
> lm75.yaml.
> 
> Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
> ---
> v2: Fix the example to pass `make dt_binding_check`
> ---
>  .../devicetree/bindings/hwmon/lm75.txt        | 39 ------------
>  .../devicetree/bindings/hwmon/lm75.yaml       | 60 +++++++++++++++++++
>  2 files changed, 60 insertions(+), 39 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/lm75.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/lm75.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/lm75.txt b/Documentation/devicetree/bindings/hwmon/lm75.txt
> deleted file mode 100644
> index 273616702c51..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/lm75.txt
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -*LM75 hwmon sensor.
> -
> -Required properties:
> -- compatible: manufacturer and chip name, one of
> -		"adi,adt75",
> -		"dallas,ds1775",
> -		"dallas,ds75",
> -		"dallas,ds7505",
> -		"gmt,g751",
> -		"national,lm75",
> -		"national,lm75a",
> -		"national,lm75b",
> -		"maxim,max6625",
> -		"maxim,max6626",
> -		"maxim,max31725",
> -		"maxim,max31726",
> -		"maxim,mcp980x",
> -		"nxp,pct2075",
> -		"st,stds75",
> -		"st,stlm75",
> -		"microchip,tcn75",
> -		"ti,tmp100",
> -		"ti,tmp101",
> -		"ti,tmp105",
> -		"ti,tmp112",
> -		"ti,tmp175",
> -		"ti,tmp275",
> -		"ti,tmp75",
> -		"ti,tmp75b",
> -		"ti,tmp75c",
> -
> -- reg: I2C bus address of the device
> -
> -Example:
> -
> -sensor@48 {
> -	compatible = "st,stlm75";
> -	reg = <0x48>;
> -};
> diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> new file mode 100644
> index 000000000000..203829c6ba6f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/lm75.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LM75 hwmon sensor
> +
> +maintainers:
> +  - Jean Delvare <jdelvare@suse.com>
> +  - Guenter Roeck <linux@roeck-us.net>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adt75
> +      - dallas,ds1775
> +      - dallas,ds75
> +      - dallas,ds7505
> +      - gmt,g751
> +      - national,lm75
> +      - national,lm75a
> +      - national,lm75b
> +      - maxim,max6625
> +      - maxim,max6626
> +      - maxim,max31725
> +      - maxim,max31726
> +      - maxim,mcp980x
> +      - nxp,pct2075
> +      - st,stds75
> +      - st,stlm75
> +      - microchip,tcn75
> +      - ti,tmp100
> +      - ti,tmp101
> +      - ti,tmp105
> +      - ti,tmp112
> +      - ti,tmp175
> +      - ti,tmp275
> +      - ti,tmp75
> +      - ti,tmp75b
> +      - ti,tmp75c
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

additionalProperties: false

> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      sensor@48 {
> +        compatible = "st,stlm75";
> +        reg = <0x48>;
> +      };
> +    };
> -- 
> 2.25.1
> 
