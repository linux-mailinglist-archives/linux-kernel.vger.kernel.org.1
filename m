Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BB02DC55F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 18:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgLPR37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 12:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgLPR36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 12:29:58 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B130C06179C;
        Wed, 16 Dec 2020 09:29:18 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id q22so17011629pfk.12;
        Wed, 16 Dec 2020 09:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UT1B9nUbmAhqtCJn38dlsaMuP8mrnsdDVCBDzR6A/4Y=;
        b=Y7nSdaiwoNtRlOlJWltUpQHABvcC/d0Mt3kVqhsJCbVZIJ9VS95lvGSS1JcRR4i7qa
         GbmVJOlyPmWGzG50CIO8qYCk/YnULiBfev6nCnHyFxRBqQ01hmXAthbUnNBoqn00Yv3Q
         VVfmJi7vGVe2yxwYa/IxVtRW0ADRXVhhd1thvnaCIK6tAlxBk7Z5i+gu1mSwD1uiV68H
         CcPswJZrpmzBJvCHDArLp0Bw7KSzYM7BrHgAKy7sASJ81F8h3lIP6PdysMUS3SQ5q4Bd
         LuFqygzX0gyy+Z/r4VChxDQeQI0/MfJVeMyi+T9QwE2oP0jtidD7WmitaD3aP+TO+0Mw
         mwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UT1B9nUbmAhqtCJn38dlsaMuP8mrnsdDVCBDzR6A/4Y=;
        b=g0o69fqz4E+BDuNHwCmuKPlHo9e2jauiR/oWbgQlrMcldnDNVgjnGWffZMYnMSGge1
         BkPgsIhDq/WGGS/kjFqj2413dIXBlqFRwWuFz5MJNUSiiiCMyaey2NQ5n3Et1Sfb2iwH
         +fKFLSkHf9BWbGZuzATSzVlK0KGlBWqEDsgk3th6D7i3c0P3fXkPa0R8BNDJ5V6ZnY+V
         l4OL5AdkEvoYVOqIJdleguRHx+pxzfwZHj7G6UY0CMslo2hU0kQ6rJeyhZlgW3PLuGPV
         oGb9WylE1jUtwWm8GT7+5xmGvnMPjZeGkbdoVpOpeYhRsKvDGfZwLCx7xeWbfARyGAVP
         Dv6Q==
X-Gm-Message-State: AOAM530UMIvBEWWMqfTVtzxpGeP0cEGvm2o615bTFWaia64ro89zMQv/
        NrrYTkg2vbKG2u54D7HmTyM=
X-Google-Smtp-Source: ABdhPJwbFGmPOY6hKSfNWyhOyKqzwidIZcPqICoHd75vsJEsReiyVE89Gj2c//XGXGYjtFbJG/4rMw==
X-Received: by 2002:a62:7651:0:b029:1a5:929b:1681 with SMTP id r78-20020a6276510000b02901a5929b1681mr14282973pfc.27.1608139757816;
        Wed, 16 Dec 2020 09:29:17 -0800 (PST)
Received: from [10.67.48.230] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ft19sm2676892pjb.44.2020.12.16.09.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 09:29:16 -0800 (PST)
Subject: Re: [PATCH 1/3] dt-bindings: phy: brcm,brcmstb-usb-phy: convert to
 the json-schema
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201216131451.16900-1-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <c311e512-0d14-56b7-7b86-9d09322fa704@gmail.com>
Date:   Wed, 16 Dec 2020 09:29:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201216131451.16900-1-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/20 5:14 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Changes that require mentioning:
> 1. interrupt-names
>    Name "wakeup" was changed to the "wake". It matches example and what
>    Linux driver looks for in the first place
> 2. brcm,ipp and brcm,ioc
>    Both were described as booleans with 0 / 1 values. In examples they
>    were integers and Linux driver checks for int as well.
>    I made both uint32 but that probably should be refactored later.
> 3. Added minimal description
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bindings/phy/brcm,brcmstb-usb-phy.txt     |  86 --------
>  .../bindings/phy/brcm,brcmstb-usb-phy.yaml    | 195 ++++++++++++++++++
>  2 files changed, 195 insertions(+), 86 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
> deleted file mode 100644
> index 698aacbdcfc4..000000000000
> --- a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
> +++ /dev/null
> @@ -1,86 +0,0 @@
> -Broadcom STB USB PHY
> -
> -Required properties:
> -- compatible: should be one of
> -	"brcm,brcmstb-usb-phy"
> -	"brcm,bcm7216-usb-phy"
> -	"brcm,bcm7211-usb-phy"
> -
> -- reg and reg-names properties requirements are specific to the
> -  compatible string.
> -  "brcm,brcmstb-usb-phy":
> -    - reg: 1 or 2 offset and length pairs. One for the base CTRL registers
> -           and an optional pair for systems with USB 3.x support
> -    - reg-names: not specified
> -  "brcm,bcm7216-usb-phy":
> -    - reg: 3 offset and length pairs for CTRL, XHCI_EC and XHCI_GBL
> -           registers
> -    - reg-names: "ctrl", "xhci_ec", "xhci_gbl"
> -  "brcm,bcm7211-usb-phy":
> -    - reg: 5 offset and length pairs for CTRL, XHCI_EC, XHCI_GBL,
> -           USB_PHY and USB_MDIO registers and an optional pair
> -	   for the BDC registers
> -    - reg-names: "ctrl", "xhci_ec", "xhci_gbl", "usb_phy", "usb_mdio", "bdc_ec"
> -
> -- #phy-cells: Shall be 1 as it expects one argument for setting
> -	      the type of the PHY. Possible values are:
> -	      - PHY_TYPE_USB2 for USB1.1/2.0 PHY
> -	      - PHY_TYPE_USB3 for USB3.x PHY
> -
> -Optional Properties:
> -- clocks : clock phandles.
> -- clock-names: String, clock name.
> -- interrupts: wakeup interrupt
> -- interrupt-names: "wakeup"
> -- brcm,ipp: Boolean, Invert Port Power.
> -  Possible values are: 0 (Don't invert), 1 (Invert)
> -- brcm,ioc: Boolean, Invert Over Current detection.
> -  Possible values are: 0 (Don't invert), 1 (Invert)
> -- dr_mode: String, PHY Device mode.
> -  Possible values are: "host", "peripheral ", "drd" or "typec-pd"
> -  If this property is not defined, the phy will default to "host" mode.
> -- brcm,syscon-piarbctl: phandle to syscon for handling config registers
> -NOTE: one or both of the following two properties must be set
> -- brcm,has-xhci: Boolean indicating the phy has an XHCI phy.
> -- brcm,has-eohci: Boolean indicating the phy has an EHCI/OHCI phy.
> -
> -
> -Example:
> -
> -usbphy_0: usb-phy@f0470200 {
> -	reg = <0xf0470200 0xb8>,
> -		<0xf0471940 0x6c0>;
> -	compatible = "brcm,brcmstb-usb-phy";
> -	#phy-cells = <1>;
> -	dr_mode = "host"
> -	brcm,ioc = <1>;
> -	brcm,ipp = <1>;
> -	brcm,has-xhci;
> -	brcm,has-eohci;
> -	clocks = <&usb20>, <&usb30>;
> -	clock-names = "sw_usb", "sw_usb3";
> -};
> -
> -usb-phy@29f0200 {
> -	reg = <0x29f0200 0x200>,
> -		<0x29c0880 0x30>,
> -		<0x29cc100 0x534>,
> -		<0x2808000 0x24>,
> -		<0x2980080 0x8>;
> -	reg-names = "ctrl",
> -		"xhci_ec",
> -		"xhci_gbl",
> -		"usb_phy",
> -		"usb_mdio";
> -	brcm,ioc = <0x0>;
> -	brcm,ipp = <0x0>;
> -	compatible = "brcm,bcm7211-usb-phy";
> -	interrupts = <0x30>;
> -	interrupt-parent = <&vpu_intr1_nosec_intc>;
> -	interrupt-names = "wake";
> -	#phy-cells = <0x1>;
> -	brcm,has-xhci;
> -	syscon-piarbctl = <&syscon_piarbctl>;
> -	clocks = <&scmi_clk 256>;
> -	clock-names = "sw_usb";
> -};
> diff --git a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
> new file mode 100644
> index 000000000000..34664bdfa4be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
> @@ -0,0 +1,195 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/brcm,brcmstb-usb-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom STB USB PHY
> +
> +description: Broadcom's PHY that handles EHCI/OHCI and/or XHCI
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>

You would probably want to have Al Cooper be listed as a maintainer as
well of this binding.

Have not tried to validate the binding, but LGTM!
-- 
Florian
