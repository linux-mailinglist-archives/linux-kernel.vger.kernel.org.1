Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143482CBA8E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgLBK2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 05:28:18 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:20176 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbgLBK2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 05:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606904897; x=1638440897;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jxdnCjS8YjbH63ycdYQzCmhpMkyLHpoYyNpwt16oaKI=;
  b=Ie9ySNcG3/8SC8apQ0oPydvUjgeyOHWGGRDUeTfsqM4dlNxFN9gQKgMB
   2O5xQgo/K0xU8ImicPTxQM4kV7ou5a1FXHOcKLiGMsNAqp7d0rSs6zHuX
   uAmf86JZ0P6llMI2zwDG47nV9pMjQvpnJ/BvqtJvtw0KGSGpYIZy9rENx
   oWZwQFw6CzDtEd9QwPjsrmU9XaXDQDelQ2QVYam1KvWakMC66wUxsMSRV
   Eg4LHa/SRpJFe7M+o8Hdc+O/lWT7BwXoxiDjFnkkWPEENn4QbT9Ha8QCL
   RF2THeA099lIsp51l8kniabuLm9DlLbSG6XDE+IuESjKc8NqN60Mgr4I4
   w==;
IronPort-SDR: VHvdFdaRkJnE530gv/JzIWnCEwzaBbHgaduL4ZugLOaa4/lfni6aQFdfiw0dIOCrhS/j9LY379
 H2ZrMQkShtzXDEnEAYuLgxmFWHM5ID6JY3O5WWje7Z7cdm+400wrkn9wHM2JKQVXypizOV01Yu
 x/yIxLBLRb8OyvqkZ+Kv8zC7XKxxDnoEljbKzGMi8Pc1DwZL9gWTNugW/K/TqF/grr0ehQs9Oq
 1QfVuSxIOzHhfNy9GvGjAyJwrqG+eSXk3meIdZhCsTh2Xq8qBslqiDmyASbL0V9VMfIigrheWI
 4VA=
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="35774317"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Dec 2020 03:27:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 03:27:11 -0700
Received: from [10.171.246.74] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 2 Dec 2020 03:27:08 -0700
Subject: Re: [PATCH 1/2] ARM: dts: at91: sam9x60ek: remove bypass property
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <sandeepsheriker.mallikarjun@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Marco Cardellini" <marco.cardellini@microchip.com>
References: <1606903025-14197-1-git-send-email-claudiu.beznea@microchip.com>
 <1606903025-14197-2-git-send-email-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <366ac1f3-d18a-d9e2-75c4-9f8bdd1890a6@microchip.com>
Date:   Wed, 2 Dec 2020 11:27:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1606903025-14197-2-git-send-email-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2020 at 10:57, Claudiu Beznea wrote:
> atmel,osc-bypass property sets the bit 1 at main oscillator register.
> On SAM9X60 this bit is not valid according to datasheet (chapter
> 28.16.9 PMC Clock Generator Main Oscillator Register).
> 
> Fixes: 720329e86a463 ("ARM: dts: at91: sam9x60: add device tree for soc and board")
> Cc: Marco Cardellini <marco.cardellini@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   arch/arm/boot/dts/at91-sam9x60ek.dts | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
> index 0e3b6147069f..73b6b1f89de9 100644
> --- a/arch/arm/boot/dts/at91-sam9x60ek.dts
> +++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
> @@ -578,10 +578,6 @@
>   	};
>   }; /* pinctrl */
>   
> -&pmc {
> -	atmel,osc-bypass;
> -};
> -
>   &pwm0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_pwm0_0 &pinctrl_pwm0_1 &pinctrl_pwm0_2 &pinctrl_pwm0_3>;
> 


-- 
Nicolas Ferre
