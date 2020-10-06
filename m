Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68546285324
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgJFUdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgJFUdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:33:32 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCC5C061755;
        Tue,  6 Oct 2020 13:33:31 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 26so14055565ois.5;
        Tue, 06 Oct 2020 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bhskjfc6rgpl9vwk2YVo7imLhGl4XbuHpG3whzZRHVA=;
        b=rtwyCj1J7EeXg91riJb9pzLYK+1jhmUTQ9xawwpezqZWU2wjBSvEfgII2IOAwa/iow
         NLiDfOFfxPvU2FESZCEwqixPHXp+kZlakFNap9b+wrOEsBDvxtsPT63CfW5FPnoJ36g5
         0IPS+S3dZ9dIlO3z8geELkhiAjWjgKqESIh49Wl057GnABWWULdmfBVvnx+ys8nIaeCU
         ChjgFbCPbMkCp9pzXcEkHbzoXw85oQNk/gElyitQSZA5Um4vuW7xvVC0JJTNO0qsMLEy
         dbQBJ6Gxoc8RaweT/D5wVTurc0x+DljmD6Ywe4AfkdUsrwsNFpiy1zr/WMw8BPMZZcOp
         7+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bhskjfc6rgpl9vwk2YVo7imLhGl4XbuHpG3whzZRHVA=;
        b=eBCMNKXb0JoclnfKJKKt0ys38wcrTwz7dpqu3Xqp9f9KYNKlzEnWtvHDiCSuFjwxqX
         vqLxfAQZxCqtqqwY6r+m60CA/WOTyglMDVuXGi8/eX/UkiJMwqlIZVQ8tSveA16hrWcq
         uGCOcmm1KsQVnvHNoSfZSIp6+zEtg0YL0IciKiFKlEg5v2khUNlVdqOysmjnW4eouGtu
         +Pem1WESAmgGYsT3gGh7VVMyCWWia1SkNSCwt5JIdgm4seWPHCowtBtaoXx6mupeM/Xv
         5xtHVIt1IFxw7UZi/AHQ93awAHtcSgq9YJl857Z+UvbYJXc8qzL8ok08ecrdemVsIq6B
         y1yw==
X-Gm-Message-State: AOAM530s6+YvZx0txKCtFxb2ke/sKD7ddqOyccmtQVculLMn3+Mge0kN
        76/kMgkO+oh5dUp9PDY7N0E=
X-Google-Smtp-Source: ABdhPJwpskpF9DrRoGsNl7RCi4iEgWpecehP2HWrecWMgFkkkQfoNieqCzVfNeTSCqdDMpHWqevLGg==
X-Received: by 2002:aca:4007:: with SMTP id n7mr35133oia.160.1602016411128;
        Tue, 06 Oct 2020 13:33:31 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n10sm10873ooo.23.2020.10.06.13.33.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 13:33:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 6 Oct 2020 13:33:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alban Bedel <alban.bedel@aerq.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: Convert lm75 bindings to yaml
Message-ID: <20201006203329.GA88702@roeck-us.net>
References: <20201001145738.17326-1-alban.bedel@aerq.com>
 <20201001145738.17326-2-alban.bedel@aerq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001145738.17326-2-alban.bedel@aerq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 04:57:36PM +0200, Alban Bedel wrote:
> In order to automate the verification of DT nodes convert lm75.txt to
> lm75.yaml.
> 
> Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to hwmon-next.

Thanks,
Guenter

> v2: Fix the example to pass `make dt_binding_check`
> v4: Add the missing additionalProperties: false
> ---
>  .../devicetree/bindings/hwmon/lm75.txt        | 39 ------------
>  .../devicetree/bindings/hwmon/lm75.yaml       | 62 +++++++++++++++++++
>  2 files changed, 62 insertions(+), 39 deletions(-)
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
> index 000000000000..c9a001627945
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> @@ -0,0 +1,62 @@
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
> +
> +additionalProperties: false
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
