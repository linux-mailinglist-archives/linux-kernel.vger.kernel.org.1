Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37862DF7F7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 04:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgLUDQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 22:16:26 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47716 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgLUDQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 22:16:24 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BL3FbR1119185;
        Sun, 20 Dec 2020 21:15:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608520537;
        bh=0znWD3/lSmLC6vIv5o1Bd7i8k0iN0W05/EsbpDjis4A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mmhhFiwFGHBwgklsAU8qejspWEjibQTb7TRBTxu2/k/dVvg7AFh2mUVWjBG/I1blv
         U4rRGPVyKOv4CJLA3bVmWsQEzlhUDv1cvIeoxIlIWx5weXJpY43ARdT7ty4x4E0cJJ
         cBj7sWGHROAmfziCPS+1VQ/UA5Lahahiq9YfNpQI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BL3FaRn114529
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 20 Dec 2020 21:15:37 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 20
 Dec 2020 21:15:36 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 20 Dec 2020 21:15:36 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BL3FXe6013113;
        Sun, 20 Dec 2020 21:15:34 -0600
Subject: Re: Correct ordering of phy_init and phy_power_on
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        <linux-usb@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jules Maselbas <jmaselbas@kalray.eu>
References: <6cd01e79-fdc0-3bd4-32b5-a85142533f8a@pengutronix.de>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <014e75a5-ab7b-55be-e554-14ef7550b360@ti.com>
Date:   Mon, 21 Dec 2020 08:45:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6cd01e79-fdc0-3bd4-32b5-a85142533f8a@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/12/20 4:36 am, Ahmad Fatoum wrote:
> Hello,
> 
> I just noticed that USB controller drivers differ in the order in which they
> do phy_init and phy_power_on. For example:
> 
> __dwc2_lowlevel_hw_enable():
> 
> 	ret = phy_power_on(hsotg->phy);    
> 	if (ret == 0)                      
>         	ret = phy_init(hsotg->phy);
> 
> dwc3_core_init():
> 
> 	ret = dwc3_core_soft_reset(dwc); // internally does phy_init(dwc->usb2_generic_phy);
> 	/* [snip] */
> 	ret = phy_power_on(dwc->usb2_generic_phy);
> 
> 
> My initial assumption has been init -> power_on, but at least the phy-stm32-usbphyc
> (used with dwc2) is written with the assumption that exit -> power_off (and therefore
> power_on -> init). If they are swapped, disabling fails.
> 
> So how was it meant to be?

It is intended to be ->init() and then ->power_on(). So ideally it
should be the way dwc3 is.

Thanks,
Kishon
