Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE2F289C35
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 01:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgJIXqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 19:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgJIXka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 19:40:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DDFC0613D2;
        Fri,  9 Oct 2020 16:40:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f19so8131848pfj.11;
        Fri, 09 Oct 2020 16:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MQ0KpWnDNeVxw8ddnKLR7x7PrOHy9mrx1gHHEVR4YTk=;
        b=hDmBTJvLU+MIdtrIERvGrZtc+8C0P9oZrj1hYTssasKwOlKfF6VIa9dbL0mgxWU9w9
         1+b5srOqfK9+VBMHs+kNLk3kQP8fhH/xwuJohUlgZF4iKjas0F8Mdam3nDoIk5i8Wts7
         6Ney0/ge19sTB785apk8kXZpnEHrUyXocc6qIXmhJN6ZHN6xPXAPq2AY2PcW5rg+H2tj
         d827grvw4cHpteJ9p0wKAaFYYvLIAtHTlETEK4Tc8JcH8FAyzhcWDRJwyCEY0p8VeuDj
         JOa+o+Dg5+/hq+bcq4JNCjgzVcPUfEBaLy53AZXyougFBlMb8p7V7hhFRDvg2hcVGyuO
         UWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MQ0KpWnDNeVxw8ddnKLR7x7PrOHy9mrx1gHHEVR4YTk=;
        b=ND92xUal7cUl2sBMtQowEWWyhwr0L3H+CK7pOfMtZlMpjKt5p1EQTBfGSdMhJ41ewy
         8DbbMoeIrJ4IZBoqaRKGSBpXn54UhJCSQ7tfc+ulbtUPayC0QRMUALgqzeHyg8CnG/ku
         4nDD48o7tO19oVal7cnp6O4IGoOCE92w337V+qv7ca8W53bS7yWsTUnt8IBVaUnJTENp
         Aymxz0yGq9YS5dUpcok7WRcWpXAk9toSy+I0+Wfxwjg4Kis9ues/bb1I6ifeEGNFSbLE
         b8Kw8lJEp6sWsLrmqaEiZvEAtTdnNIukmT6o0SSJZqDjDvM3kCc/RnttCjzBWx3wCzd7
         AsvA==
X-Gm-Message-State: AOAM531cdNreXd8LUmKpQ8Q7r2PvXVwlGkFAeL8W6pDL2ujFo/LKwFrx
        p8hgKsiwabYfi7rD5wzdbIw=
X-Google-Smtp-Source: ABdhPJwFQIBy/uYMt1NSfSfYgTEXiSJCzmSoTmkhClRQ3AbICj+NmlbuQ/4Npd8rPY1ODaGP3HOLnw==
X-Received: by 2002:a17:90a:a394:: with SMTP id x20mr7043686pjp.213.1602286811513;
        Fri, 09 Oct 2020 16:40:11 -0700 (PDT)
Received: from [10.230.29.112] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id jx17sm12684399pjb.10.2020.10.09.16.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 16:40:10 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] usb: Add driver to allow any GPIO to be used for
 7211 USB signals
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <20201009190839.12612-1-alcooperx@gmail.com>
 <20201009190839.12612-3-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <134cbb66-6d46-bef5-fa4c-eeae78ec1b53@gmail.com>
Date:   Fri, 9 Oct 2020 16:40:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201009190839.12612-3-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/2020 12:08 PM, Al Cooper wrote:
> The Broadcom 7211 has new functionality that allows some USB low
> speed side band signals, that go from the XHCI host controller to
> pins on the chip, to be remapped to use any GPIO pin instead of the
> limited set selectable by hardware. This can be done without changing
> the standard driver for the host controller. There is currently
> support for three USB signals, PWRON, VBUS_PRESENT and PWRFLT. This
> driver will allow the remapping of any of these three signals based
> on settings in the Device Tree node for the driver. The driver was
> written so that it could handle additional signals added in the
> future by just adding the correct properties to the DT node.
> 
> Below is an example of a DT node that would remap all three
> signals:
> 
> usb_pinmap: usb-pinmap@22000d0 {
> 	compatible = "brcm,usb-pinmap";
> 	reg = <0x22000d0 0x4>;
> 	in-gpios = <&gpio 18 0>, <&gpio 19 0>;
> 	brcm,in-functions = "VBUS", "PWRFLT";
> 	brcm,in-masks = <0x8000 0x40000 0x10000 0x80000>;
> 	out-gpios = <&gpio 20 0>;
> 	brcm,out-functions = "PWRON";
> 	brcm,out-masks = <0x20000 0x800000 0x400000 0x200000>;
> 	interrupts = <0x0 0xb2 0x4>;
> };
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---

[snip]

> +config BRCM_USB_PINMAP
> +	tristate "Broadcom pinmap driver support"
> +	depends on (ARCH_BRCMSTB && PHY_BRCM_USB) || COMPILE_TEST
> +	default y if (ARCH_BRCMSTB && PHY_BRCM_USB)

default ARCH_BRCMSTB && PHY_BRCM_USB should work as well.


> +static int __init brcmstb_usb_pinmap_init(void)
> +{
> +	return platform_driver_probe(&brcmstb_usb_pinmap_driver,
> +				     brcmstb_usb_pinmap_probe);
> +}
> +
> +module_init(brcmstb_usb_pinmap_init);

You would need MODULE_AUTHOR(), LICENSE and DESCRIPTION() in case you 
make this modular.

-- 
Florian
