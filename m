Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837AD303D18
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404019AbhAZMgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:36:21 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:24085 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403894AbhAZKaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611657016; x=1643193016;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=7DPQRXFrlX+u7KxDE5WzIgzALAuas9XxehDfgOsVGl0=;
  b=tjj/sE56Mmo9+XOLPMSEgr0UrG9bXwg2KNnbqIcrqB3a4xEdGURzl+r8
   kONwrGjuSOA6C2yXc2fTnJ98pEIQGd1VJWGeSd3vim0U1p+Kly9Y8Dbgw
   3UTMK6oNvTldzoOT4ZvKKiu5PQL3K7x9YqimeBzmENRfx4PKjKBOMM4pg
   iHJdtKLlsAUAEkoMgo4tvlyI/ueAoIrine2xJuYqDLXtKYN/C0VTzqt65
   WWo0+c17IXOevNnzNflgY8E8aENoFVx46H7wyq8vn62ETOmyCP/bCwDHb
   +Z2oIM6nPfYKpIRwF+c0d72IhMPLTNxiFB8SKVTWEqXGKgJL3khfEKdXF
   g==;
IronPort-SDR: gAcIQArD9brbJfyyN2rRrkQ8Eu3w7MDn7HSG5V+u7d34L3xANwU676dEUVRrL0PtF5kLfjmTkT
 TlRnz/Oj1Gn6yHa9M52QUuiH4rvYcshZuUcgZqXm+aA/dF5EpOqgZ5IJesloeuLHclaSSAR8GV
 hCb2wUiMj+aSyyR22BnR9q6kO05TFKxe8Zs1mBAKEk6mTbV8lml4JZqD6LwN42SXijfuqgCEQl
 /fANdCrBUbX/zkFV0XE490nU9Lp5DG42kwbKyZRxDkGutzSi8puSuCZwEQGhjiq9/R33YP1AQI
 dmU=
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="41786281"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jan 2021 03:29:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 Jan 2021 03:29:00 -0700
Received: from [10.171.246.120] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 26 Jan 2021 03:28:57 -0700
Subject: Re: [PATCH v2 1/7] drivers: soc: atmel: add spdx license identifier
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <sudeep.holla@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1611653376-24168-1-git-send-email-claudiu.beznea@microchip.com>
 <1611653376-24168-2-git-send-email-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <436dfb02-cab0-fffe-d0c3-5b34476a05f6@microchip.com>
Date:   Tue, 26 Jan 2021 11:28:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1611653376-24168-2-git-send-email-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2021 at 10:29, Claudiu Beznea wrote:
> Add SPDX-License-Identifier.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

I remove license boilerplate text now that it's useless and queue this 
one on top of at91-soc.

Thanks, best regards,
   Nicolas

> ---
>   drivers/soc/atmel/soc.c | 1 +
>   drivers/soc/atmel/soc.h | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
> index 2dc86728b132..755a82502ef4 100644
> --- a/drivers/soc/atmel/soc.c
> +++ b/drivers/soc/atmel/soc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Copyright (C) 2015 Atmel
>    *
> diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
> index ee652e4841a5..77b27124362c 100644
> --- a/drivers/soc/atmel/soc.h
> +++ b/drivers/soc/atmel/soc.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
>   /*
>    * Copyright (C) 2015 Atmel
>    *
> 


-- 
Nicolas Ferre
