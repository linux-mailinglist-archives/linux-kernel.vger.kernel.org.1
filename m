Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4223045EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403775AbhAZSE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:04:56 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:37324 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731859AbhAZJRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611652664; x=1643188664;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OH2dq4QjZrtTsSwEVA0B0d10Au9NQwZtMDAzMeLqlJI=;
  b=avdtXgy2Qu8Z3dT99BTAuND+1I2rIFd4p/3oUZOuwXRJ6soQYAD8MGC/
   fDw3Jc9BqY69sdA5A/4yDwXxIWFgPBMBep4xK3coGh7EeQqpSvXg1KkJe
   /v66uEcTnKjW2MA37yWG8lF1a658ffSnu7W+oHUEnlSlJuaBheoATTVRQ
   cHFEP3+CFhoHmJf3/CoWNXZx7PFPritywUNtzczwE4v+jlXksXKZIQ1+k
   tnDQwZmim+cilfIymdtrSKASpKsu0LmgBNzGNY3ZDLFlv58qUYqaFijgk
   jyBMZWODD2YSzTsdnjQK3H+NtKtQSO8HFuwGqhDdYCDsb509ALlhfZXCW
   w==;
IronPort-SDR: 52QEk1qPl5PR1Iqmbn77pFv6Gq8jTdIcEj0BwfSI5+MHhvedDWzjM2sgg70nWAdjUoDYNSFDYA
 hmRtwMDDYKZpWh0TIIwjEF3a728qKb+muuNSlIfjuMn78xyIYzHZBzfFwmVR7i21P9LVeGC9uS
 dmh7Qx1EZkoetOPU+1kpfuj48b5/s5DtxZ6TNM4folcJd6Nqrj4u0qWTxouv8PYssrMXlUDPUI
 L+e/AFnoFtm6ILQuSNkgEiPSsyeSPfWdbqzOXcZncL0ywbDo5yFM6pE0xc7vKjb5jYyk5FJMTJ
 nQI=
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="106799457"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jan 2021 02:16:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 Jan 2021 02:16:11 -0700
Received: from [10.171.246.120] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 26 Jan 2021 02:16:08 -0700
Subject: Re: [PATCH 0/7] drivers: soc: atmel: add support for sama7g5
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1611318097-8970-1-git-send-email-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <dc9a7739-791f-7f5f-e6bb-009d0e6dfcab@microchip.com>
Date:   Tue, 26 Jan 2021 10:16:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1611318097-8970-1-git-send-email-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2021 at 13:21, Claudiu Beznea wrote:
> Hi,
> 
> This series adds support for SAMA7G5 identification. Along with this
> included also some fixes.
> 
> Thank you,
> Claudiu Beznea
> 
> Claudiu Beznea (7):
>    drivers: soc: atmel: add spdx licence identifier

I leave this one aside for now.

>    drivers: soc: atmel: use GENMASK
>    drivers: soc: atmel: fix "__initconst should be placed after socs[]"
>        warning
>    drivers: soc: atmel: add null entry at the end of

This one was taken by Arnd in arm-soc/arm/fixes branch.

>      at91_soc_allowed_list[]
>    drivers: soc: atmel: add per soc id and version match masks
>    dt-bindings: atmel-sysreg: add "microchip,sama7g5-chipid"
>    drivers: soc: atmel: add support for sama7g5

For the rest:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

I take the rest in at91-soc branch. It appears in at91-next right now.

Once the license patch is done, I can integrate it easily.

Best regards,
   Nicolas

> 
>   .../devicetree/bindings/arm/atmel-sysregs.txt      |   2 +-
>   drivers/soc/atmel/soc.c                            | 225 ++++++++++++++-------
>   drivers/soc/atmel/soc.h                            |  14 +-
>   3 files changed, 171 insertions(+), 70 deletions(-)
> 


-- 
Nicolas Ferre
