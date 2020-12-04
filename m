Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F342CF208
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbgLDQjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgLDQjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:39:05 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6BAC0613D1;
        Fri,  4 Dec 2020 08:38:25 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id y24so5772018otk.3;
        Fri, 04 Dec 2020 08:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rt88NXuMyzgDnVezMj+kUL6MwTIwAsyb4NhsQeMi4pc=;
        b=N5g1VDeQHd+52QPb2IJyzkIO+Z8ioyLFpNACm+aVpYW8RVg+tgwDEIlKxPXrGAR0zU
         MtBsmybZ7xsjxBNEs3nY/U3t0J4QPtEJTL280b5T2367Tb0/DBfBmtNDtB81pAxVu6wI
         sczGYd/kv73X4+QPlzbSbCMh0ZHKgHkJXKoq4ZLb3SPP/YAvsVhupNkh9isw1QmvXa8W
         wuYXM6yn+Msf/Tgl0QKKvt7WSbnNgWq3R0OpqZ743dwcDK1jWa0NiqB4tIj7iuUCP19g
         yXA+DEogzhcpHeK4mDGnLXhVwM8bJZjGHogbFwSzc82fVzsfIeb/CFIrPX/r1btWv1hS
         lKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rt88NXuMyzgDnVezMj+kUL6MwTIwAsyb4NhsQeMi4pc=;
        b=U/jrxcHIMteqKL1X8NdA7N9FLVJuz+ALMY1iDhM3dLli4c7tLFzeQnYAFsx2IQ6D0A
         BjYxHeZz2RyojSvnVk9rlFpw4Ov/8veBtvSjwTTaDIEVybc85ToCMQ9DzZ07nM244YSv
         FqLIYPBEEaUMuIAN9JWgUhFdvP9sWv5ZkpYX8YYkrwL333aUJB4TrDyvhR3YTp788an3
         RKryx/1l6YdGJ3mOraEHhgvXdPOfnzR0HD9fDJl/NqHWrLnhfb4pG1mSVVZ2pmyUfSo2
         SyJC02A0wWxMNmVyL3G6uNptATsKtQAe4fbE9Y5ByvrP6v6YnJYDd1ECPByCOPCLzoxk
         POog==
X-Gm-Message-State: AOAM532PyjcWvHZeyga7bz98U/xU/YEXeR7PfoO39bRtEu4K+YiWzJ8h
        g5KnOPQgn0+XQF3y+7fQumE=
X-Google-Smtp-Source: ABdhPJyMawr+OLuTlosEvpqTn8dFKm2BfPnm2ZbvRMzfwSdm5PcHS8YRIhvdAn0Jh3ZV+JDCp2JZaw==
X-Received: by 2002:a9d:614f:: with SMTP id c15mr1375749otk.362.1607099905007;
        Fri, 04 Dec 2020 08:38:25 -0800 (PST)
Received: from ?IPv6:2600:1700:dfe0:49f0:2100:4bbd:f066:27d? ([2600:1700:dfe0:49f0:2100:4bbd:f066:27d])
        by smtp.gmail.com with ESMTPSA id r12sm734818ooo.25.2020.12.04.08.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 08:38:24 -0800 (PST)
Subject: Re: [PATCH 2/2] reset: bcm4908-usb: add driver for BCM4908 USB reset
 controller
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Al Cooper <al.cooper@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201204093704.11359-1-zajec5@gmail.com>
 <20201204093704.11359-2-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5abf5ac5-0d4b-cfd2-7ade-dc66fcc5edde@gmail.com>
Date:   Fri, 4 Dec 2020 08:38:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201204093704.11359-2-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/2020 1:37 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This controller is responsible for OHCI, EHCI, XHCI and PHYs setup that
> has to be handled in the proper order.
> 
> One unusual thing about this controller is that is provides access to
> the MDIO bus. There are two registers (in the middle of block space)
> responsible for that. For that reason this driver initializes regmap so
> a proper MDIO driver can use them.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---

[snip]

> +
> +#define BCM4908_USB_RESET_SETUP						0x0000
> +#define  BCM4908_USBH_IPP						(1<<5)
> +#define  BCM4908_USBH_IOC						(1<<4)
> +#define  BCM4908_USB2_OC_DISABLE_PORT0					(1<<28)
> +#define  BCM4908_USB2_OC_DISABLE_PORT1					(1<<29)
> +#define  BCM4908_USB3_OC_DISABLE_PORT0					(1<<30)
> +#define  BCM4908_USB3_OC_DISABLE_PORT1					(1<<31)
> +#define BCM4908_USB_RESET_PLL_CTL					0x0004
> +#define BCM4908_USB_RESET_FLADJ_VALUE					0x0008
> +#define BCM4908_USB_RESET_BRIDGE_CTL					0x000c
> +#define BCM4908_USB_RESET_SPARE1					0x0010
> +#define BCM4908_USB_RESET_MDIO						0x0014
> +#define BCM4908_USB_RESET_MDIO2						0x0018
> +#define BCM4908_USB_RESET_TEST_PORT_CONTROL				0x001c
> +#define BCM4908_USB_RESET_USB_SIMCTL					0x0020
> +#define  BCM4908_USBH_OHCI_MEM_REQ_DIS					(1<<1)
> +#define BCM4908_USB_RESET_USB_TESTCTL					0x0024
> +#define BCM4908_USB_RESET_USB_TESTMON					0x0028
> +#define BCM4908_USB_RESET_UTMI_CTL_1					0x002c
> +#define BCM4908_USB_RESET_SPARE2					0x0030
> +#define BCM4908_USB_RESET_USB_PM					0x0034
> +#define  BCM4908_XHC_SOFT_RESETB					(1<<22)
> +#define  BCM4908_USB_PWRDWN						(1<<31)
> +#define BCM4908_USB_RESET_USB_PM_STATUS					0x0038
> +#define BCM4908_USB_RESET_SPARE3					0x003c
> +#define BCM4908_USB_RESET_PLL_LDO_CTL					0x0040
> +#define BCM4908_USB_RESET_PLL_LDO_PLLBIAS				0x0044
> +#define BCM4908_USB_RESET_PLL_AFE_BG_CNTL				0x0048
> +#define BCM4908_USB_RESET_AFE_USBIO_TST					0x004c
> +#define BCM4908_USB_RESET_PLL_NDIV_FRAC					0x0050
> +#define BCM4908_USB_RESET_TP_DIAG					0x0054
> +#define BCM4908_USB_RESET_AHB_CAPTURE_FIFO				0x0058
> +#define BCM4908_USB_RESET_SPARE4					0x005c
> +#define BCM4908_USB_RESET_USB30_CTL1					0x0060
> +#define  BCM4908_PHY3_PLL_SEQ_START					(1<<4)
> +#define BCM4908_USB_RESET_USB30_CTL2					0x0064
> +#define BCM4908_USB_RESET_USB30_CTL3					0x0068
> +#define BCM4908_USB_RESET_USB30_CTL4					0x006c
> +#define BCM4908_USB_RESET_USB30_PCTL					0x0070
> +#define BCM4908_USB_RESET_USB30_CTL5					0x0074
> +#define BCM4908_USB_RESET_SPARE5					0x0078
> +#define BCM4908_USB_RESET_SPARE6					0x007c
> +#define BCM4908_USB_RESET_SPARE7					0x0080
> +#define BCM4908_USB_RESET_USB_DEVICE_CTL1				0x0090
> +#define BCM4908_USB_RESET_USB_DEVICE_CTL2				0x0094
> +#define BCM4908_USB_RESET_USB20_ID					0x0150
> +#define BCM4908_USB_RESET_USB30_ID					0x0154
> +#define BCM4908_USB_RESET_BDC_COREID					0x0158
> +#define BCM4908_USB_RESET_USB_REVID					0x015c

This register layout is nearly identical to the one described under
drivers/phy/broadcom/phy-brcm-usb-init.c and this is because within
Broadcom the same design group has been supplying the USB PHY and host
controllers to the DSL and STB product lines.

I would model this the same way we have done it for the Broadcom STB HCI
drivers and add a separate compatible string along with an optional
reset line.

As far as MDIO goes as you can see the USB PHY driver uses a mix of
memory mapped and MDIO accesses (eye fix, etc.) so it was deemed cleaner
to not use the MDIO subsystem for the very few accesses that are required.

This is different from the Northstar platform you have been working on
where the USB PHYs are not memory maapped at all and only accessible
over MDIO.

Let me know if you think the existing driver would not be extensible to
support 4908.
-- 
Florian
