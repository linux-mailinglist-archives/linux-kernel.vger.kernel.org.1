Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F040827B43B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgI1SPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:15:15 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39039 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgI1SPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:15:14 -0400
Received: by mail-ot1-f65.google.com with SMTP id u25so1866952otq.6;
        Mon, 28 Sep 2020 11:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2wQp8t3YNIyIbKEee4NCXPzTr3hi1dqie+V4L6phigw=;
        b=aJhaZhYNrzZ/mFUmqwqAASJrojTZSodcGZK04UYuFyX6VoIMl/lDHvtPPdzJnKb8Uy
         xjMzi/vY89LQ8rBfDuhOF181+Skotii9SOxm+6gjPT4PpryvOMwZq9NYpCP7y0p/fzQv
         eAQ6qWzfgxwFbrgONnO12UzWgTaRVLocMvlziMLTvu4vlerU61I5TUpwGD5qbYLvJn43
         mPwSRT3aQR7jkrMed3lpynuNBa6+llSb1j37FkeqVlB991boUcyQblNqHojy4Ygjz8HZ
         rHeKjZ3N4YtxZgXb8rwjRGzEIqvoEcT7hxBBJVvHWVHPu6A21PSrOuvrOP5ocf77473/
         bQlg==
X-Gm-Message-State: AOAM532juFoc6vI2bZecu8H+p3DjSaEAjtgmaqTeIhO3oPZ0UYrI2DMi
        hIERN6WolMtIoJQtNCHdTw==
X-Google-Smtp-Source: ABdhPJxxUCzi8Tigr9BtMQaJW/gur4AsGw7urQaLMR6YgD9D3ll85gdy7dwrvQYeYbJWO0oEd0Mz0Q==
X-Received: by 2002:a05:6830:1e39:: with SMTP id t25mr200918otr.8.1601316912395;
        Mon, 28 Sep 2020 11:15:12 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u15sm397655otg.78.2020.09.28.11.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:15:11 -0700 (PDT)
Received: (nullmailer pid 3015156 invoked by uid 1000);
        Mon, 28 Sep 2020 18:15:11 -0000
Date:   Mon, 28 Sep 2020 13:15:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rtanwar@maxlinear.com
Subject: Re: [PATCH v2 1/2] Add DT bindings schema for PVT controller
Message-ID: <20200928181511.GB3012847@bogus>
References: <cover.1601285307.git.rahul.tanwar@linux.intel.com>
 <f3f977389f74f416a70b7f5276243cf722ba6fee.1601285307.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3f977389f74f416a70b7f5276243cf722ba6fee.1601285307.git.rahul.tanwar@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 05:44:18PM +0800, Rahul Tanwar wrote:
> PVT controller (MR75203) is used to configure & control
> Moortec embedded analog IP which contains temprature sensor(TS),
> voltage monitor(VM) & process detector(PD) modules.
> 
> Add DT bindings schema for PVT controller.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> new file mode 100644
> index 000000000000..858888461bfe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/moortec,mr75203.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Moortec Semiconductor MR75203 PVT Controller bindings
> +
> +maintainers:
> +  - Rahul Tanwar <rtanwar@maxlinear.com>
> +
> +properties:
> +  compatible:
> +    const: moortec,mr75203
> +
> +  reg:
> +    items:
> +      - description: PVT common registers
> +      - description: PVT temprature sensor registers
> +      - description: PVT process detector registers
> +      - description: PVT voltage monitor registers
> +
> +  reg-names:
> +    items:
> +      - const: common
> +      - const: ts
> +      - const: pd
> +      - const: vm
> +
> +  vm-map:

Needs a vendor prefix and type reference.

> +    description:
> +      PVT controller has 5 VM (voltage monitor) sensors.
> +      vm-map defines CPU core to VM instance mapping. A
> +      value of 0xff means that VM sensor is unused.
> +    maxItems: 5
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - vm-map
> +  - clocks
> +  - resets
> +  - "#thermal-sensor-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pvt: pvt@e0680000 {
> +        compatible = "moortec,mr75203";
> +        reg = <0xe0680000 0x80
> +               0xe0680080 0x180
> +               0xe0680200 0x200
> +               0xe0680400 0xc00>;
> +        reg-names = "common", "ts", "pd", "vm";
> +        vm-map = [03 01 04 ff ff];
> +        clocks = <&osc0>;
> +        resets = <&rcu0 0x40 7>;
> +        #thermal-sensor-cells = <1>;
> +    };
> -- 
> 2.11.0
> 
