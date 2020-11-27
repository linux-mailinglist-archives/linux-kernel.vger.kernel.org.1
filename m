Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8435D2C60EA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgK0IdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbgK0IdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:33:18 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462C0C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 00:33:17 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id j10so5046252lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 00:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I+H3fJkSgBlTxVS9rYGiWqkCeTc902bQ8DxJtfiOThs=;
        b=JaNyx2iexljpy6hvd6XlycFhYx1R1ajuk05YStvrMMnQP/z0iRfim4o+y5JA83ZvQU
         oPtXdVDvKiErUG4esJL8MT/OHrL8CJVZE8/CuuXCdm58viyAu4FN3JgBerHXJufYCNS6
         WEZadT+mgedJBTHaQur/O+/qcmt3pwoQ8uO6Iv+mCexAdSfnDe1/h8naM9AF+RCBhTSo
         H0uumXW9QK1vuJMOyAF5pwlmQOdySf1g+i6R1IB50y7LqPuGZiGhW9JqgEb5s13fC+jC
         7XvDJ9wNH70gBzi5HivLV3Jr4UGcPOR/0s8rzeXKBIf7Xz5eV/gz91tzjUvf+s5CMGIv
         hUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I+H3fJkSgBlTxVS9rYGiWqkCeTc902bQ8DxJtfiOThs=;
        b=U3Fw2aNRrwjvqHwcJwtWc7uNlrpFvctC9TrI5oHPcUEHIICeFBxUYHlnTCVvTQdDNb
         i1ANxzaZp90Pev/eYrhMFYPAz5ku5di59j56YJUzFSuMgdEylFImWzf45RtbmYFIEqqZ
         ALUM49sYQpBwaIn9xpNsy64wA9dQtc6hvfBuYHu7wfvLNqMQXsLut54VhsbIEbjUGCti
         OTfqVePRXZ1ljZQz0ZUyzoHb6ko8eeqTXVRMnwJQN8bWwA4EEp70UZwxEMsDnJ1Lv1QK
         tpxltMCGK13Omg5ochsavn2eAVvIlRl+IhHHnfic1fYvdEVT/t51UjcETQpR5AldmzdU
         eFoA==
X-Gm-Message-State: AOAM532sSHBYd2xzrImmacq63rjYbCHLiNcImcLfRX8LPWzIcXhPozWa
        694U33y7S8CKdigHDHbCYZeImQ==
X-Google-Smtp-Source: ABdhPJySdztVzZF4ZsyqH58OsuTk1YILpaMSPVYlTJztjSDF9Ypk6ZiDca43rxm3cE4op+/Xg1sMJA==
X-Received: by 2002:a2e:9550:: with SMTP id t16mr2735829ljh.117.1606465995753;
        Fri, 27 Nov 2020 00:33:15 -0800 (PST)
Received: from [192.168.118.216] ([85.249.45.205])
        by smtp.gmail.com with ESMTPSA id w72sm606592lff.89.2020.11.27.00.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 00:33:15 -0800 (PST)
Subject: Re: [PATCH v2 2/2] media: dt-bindings: media: i2c: Add IMX300 CMOS
 sensor binding
To:     kholk11@gmail.com, mchehab@kernel.org
Cc:     robh+dt@kernel.org, marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201029172947.34315-1-kholk11@gmail.com>
 <20201029172947.34315-3-kholk11@gmail.com>
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
Message-ID: <8d3f5fb3-802d-0e54-3854-9c119dbd0ed4@linaro.org>
Date:   Fri, 27 Nov 2020 11:33:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029172947.34315-3-kholk11@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

On 29.10.2020 20:29, kholk11@gmail.com wrote:
> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> 
> Add YAML device tree binding for IMX300 CMOS image sensor, and
> the relevant MAINTAINERS entries.
> 
> Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> ---
>   .../bindings/media/i2c/sony,imx300.yaml       | 112 ++++++++++++++++++
>   MAINTAINERS                                   |   7 ++
>   2 files changed, 119 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx300.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx300.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx300.yaml
> new file mode 100644
> index 000000000000..8f1d795f8072
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx300.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/sony,imx300.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sony 1/2.3-Inch 8Mpixel Stacked CMOS Digital Image Sensor

You said this is an 8 MP sensor,

> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <kholk11@gmail.com>
> +
> +description: |-
> +  The Sony IMX300 is a 1/2.3-inch Stacked CMOS (Exmor-RS) digital image
> +  sensor with a pixel size of 1.08um and an active array size of
> +  5948H x 4140V. It is programmable through I2C interface at address 0x10.

- but 5948H x 4140V is more than 8 MP.

Thanks,
Andrey

> +  Image data is sent through MIPI CSI-2, which is configured as either 2 or
> +  4 data lanes.
> +
> +properties:
> +  compatible:
> +    const: sony,imx300
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  vdig-supply:
> +    description:
> +      Digital I/O voltage supply, 1.15-1.20 volts
> +
> +  vana-supply:
> +    description:
> +      Analog voltage supply, 2.2 volts
> +
> +  vddl-supply:
> +    description:
> +      Digital core voltage supply, 1.8 volts
> +
> +  reset-gpios:
> +    description: |-
> +      Reference to the GPIO connected to the xclr pin, if any.
> +      Must be released (set high) after all supplies are applied.
> +
> +  # See ../video-interfaces.txt for more details
> +  port:
> +    type: object
> +    properties:
> +      endpoint:
> +        type: object
> +
> +        properties:
> +          data-lanes:
> +            description: |-
> +              The sensor supports either two-lane, or four-lane operation,
> +              but the driver currently supports only four-lane.
> +            items:
> +              - const: 0
> +              - const: 1
> +              - const: 2
> +              - const: 3
> +
> +          clock-noncontinuous: true
> +
> +          link-frequencies:
> +            $ref: /schemas/types.yaml#/definitions/uint64-array
> +            description:
> +              Allowed data bus frequencies. The driver currently needs
> +              to switch between 780000000 and 480000000 Hz in order to
> +              guarantee functionality of all modes.
> +
> +        required:
> +          - link-frequencies
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - vana-supply
> +  - vdig-supply
> +  - vddl-supply
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        imx300: sensor@10 {
> +            compatible = "sony,imx300";
> +            reg = <0x10>;
> +            clocks = <&imx300_xclk>;
> +            vana-supply = <&imx300_vana>;   /* 2.2v */
> +            vdig-supply = <&imx300_vdig>;   /* 1.2v */
> +            vddl-supply = <&imx300_vddl>;   /* 1.8v */
> +
> +            port {
> +                imx300_0: endpoint {
> +                    remote-endpoint = <&csi1_ep>;
> +                    data-lanes = <0 1 2 3>;
> +                    clock-noncontinuous;
> +                    link-frequencies = /bits/ 64 <780000000 480000000>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c66710dd7e0a..21ba41db0063 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16279,6 +16279,13 @@ T:	git git://linuxtv.org/media_tree.git
>   F:	Documentation/devicetree/bindings/media/i2c/imx290.txt
>   F:	drivers/media/i2c/imx290.c
>   
> +SONY IMX300 SENSOR DRIVER
> +M:	AngeloGioacchino Del Regno <kholk11@gmail.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/media/i2c/sony,imx300.yaml
> +F:	drivers/media/i2c/imx300.c
> +
>   SONY IMX319 SENSOR DRIVER
>   M:	Bingbu Cao <bingbu.cao@intel.com>
>   L:	linux-media@vger.kernel.org
> 
