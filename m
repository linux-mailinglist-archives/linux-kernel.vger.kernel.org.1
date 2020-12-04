Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54082CF1F8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgLDQdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgLDQdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:33:02 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B527BC0613D1;
        Fri,  4 Dec 2020 08:32:21 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 11so5725069oty.9;
        Fri, 04 Dec 2020 08:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AD99ZGGRsumcqS0lZM3Y0Ohp8183Fl7U+XsVF8JOnOQ=;
        b=MqEGVb78K7WNXKBLa6GIzZTsIUR2Zt680jFL0POMYQPclWnqJqn/pEqkv4MoFZUGXT
         HBagJadooU79ZyVkr1AhGvYhoUi7cEDfBJO4/zHWtaG6gkXrUhrUHglLsV3zhc/3YPdN
         pX2bZir/L8zgKZkF82V8bj6+AK3crSIeXeDwPOWlt0J+WilSHLbSoNNr7667AQJ2afz0
         8lupTSH1iqeHynStvQS+UQER3HWD/4awZZiSb9UvIWHc36LBHPgnCbARbmefWRPYHEHe
         KeZBVrSMScDBryIk7W7xz4T1eZ2TKH/qSxTKSNtmPk1gp2lS0lFxkrLO3kft69iEoy45
         q10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AD99ZGGRsumcqS0lZM3Y0Ohp8183Fl7U+XsVF8JOnOQ=;
        b=n/wDJ+C0lewU+HzpCW0DaOxUi0eJgYj2XyNoQqecRKaxOZ3hsXMZ6EAfrkBxkkC1LF
         Vxc3FnBvj3MUXgEBmz84TBjwc6o7guVVIpnwfK/rIZf/yIMPiajC1Zsgji46/1ZPTZ/L
         etmDAyytDn6tXwixqXtkWKzpSnOyz/bN033csyz3zFdEijBmh02Zf/vJuGKhC+vsgCO4
         M6wZzB6LYHRKpCDq9CJL5g8uyr4R9zlF3EdJGeB1TFYyyMtQ+UWz4O7dM5jiRm6os0Tt
         RSAGvfbCAp/t90+XDbJ5oLgWeQGdcUjnUPsOp3lpTEhZeXsENVaH5nAsHUqpZ3ZXU/yr
         4K1w==
X-Gm-Message-State: AOAM532ZdBUqipCyEvLSSUG2Q46q3K50ZZIJF9QxwjA/DJhfpscB9tJQ
        asV6xKT4vHKKHm6TtBqugbs=
X-Google-Smtp-Source: ABdhPJyFpTq6srSuWjVD/CcItrEnq+TWo99Jpkl6oNIUsrRL9Xzhoj4d8hxb8jR6LsYsXOotBRo47Q==
X-Received: by 2002:a05:6830:4d6:: with SMTP id s22mr4369164otd.30.1607099541112;
        Fri, 04 Dec 2020 08:32:21 -0800 (PST)
Received: from ?IPv6:2600:1700:dfe0:49f0:2100:4bbd:f066:27d? ([2600:1700:dfe0:49f0:2100:4bbd:f066:27d])
        by smtp.gmail.com with ESMTPSA id s28sm718969otd.2.2020.12.04.08.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 08:32:20 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: reset: document Broadcom's BCM4908 USB
 reset binding
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201204093704.11359-1-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0cc54a35-7d70-8a2f-0c1f-da124136a66d@gmail.com>
Date:   Fri, 4 Dec 2020 08:32:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201204093704.11359-1-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/2020 1:37 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Document binding of block responsible for initializing USB controllers
> (OHCI, EHCI, XHCI).
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../reset/brcm,bcm4908-usb-reset.yaml         | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml b/Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml
> new file mode 100644
> index 000000000000..31beb1c8f3cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/brcm,bcm4908-usb-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM4908 USB host controller reset
> +
> +description: >
> +  BCM4908 has a separated block controlling all USB controllers. It handles the
> +  whole setup process and takes care of initializing PHYs at the right time
> +  (state).
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm4908-usb-reset
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  phys:
> +    minItems: 2
> +    maxItems: 2
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  phy-names:
> +    items:
> +      - const: usb2
> +      - const: usb3
> +
> +  "#reset-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - phys
> +  - phy-names
> +  - "#reset-cells"
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    reset-controller@8000c200 {
> +        compatible = "brcm,bcm4908-usb-reset";
> +        reg = <0x8000c200 0x100>;
> +
> +        phys = <&usb2_phy>, <&usb3_phy>;
> +        phy-names = "usb2", "usb3";

This looks quite unusual, usually the *HCI controllers would be
consumers of the PHY and the PHY may be a consumer of the reset controller.

(still going through my emails have not fully read your separate email
on the topic, so pardon me if this is being discussed twice).
-- 
Florian
