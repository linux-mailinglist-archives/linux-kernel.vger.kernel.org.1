Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7F02FEDAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbhAUO4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:56:03 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:26731 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732045AbhAUNap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611235844; x=1642771844;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0yTZx0wQopVIgiWGJr/uBeip6jEWgesrNICw7waSjrg=;
  b=kUgc8a/ewFAwtxurea9I4dv6QvjQlcNSsPwQ/FrNKEw7LBL8eI/p0GGu
   zt3uS6t6V1tyIt0t1njpRtUZ1fgqJXVQVDcgosLlYdgP3bzQe10qbdMhh
   6VL/lAErG/wCmJ72Afv8sKcyeDz150Am1sd2o4uKqsD3UKqk3xLRXcGJy
   CiVCQ8b2+Tlrtas4jtz237aLviVJFo1swC6eE7fOoMrZHRL3cajbRjaLj
   naW0vdmHHYShY+XeLrrwiLg5sehE89doq89vdGaMgZc38p3xwGmqO8W0l
   /yb+HNHxIUaGtgmKhOOUPizVnD+ySoZjLPfZ8qx0in4SOSfIW3zoQ94c2
   A==;
IronPort-SDR: Fgy9blzTIwv3gqHbtbwppXlRkbuxgR1ruleRa0IAtwrl6NFqYXcgx4/lGgTJF0zzDadN5kQyNJ
 SLy7lLv1nOhNi+XJi0LJfhxj5NDhtPX8arRYz9l4eEttA1o0GvA7gtih6tv61DTBgyJLb42Ckb
 t+J2zZjZMIaiwjkdWksloc3l0qIzxfzQAMdHZyfGihVWsgaOdcwnR+qHTg/56vGBP6ii0wHze8
 qouZ0FUeg67AXjp90jbct/nhLUcSzFvLqU5uUmxe2GIfGJjgp0++x+R3/8mLKnRM0h5cgUt7zh
 rrI=
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="103692970"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2021 06:29:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 21 Jan 2021 06:29:18 -0700
Received: from [10.205.29.84] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 21 Jan 2021 06:29:15 -0700
Subject: Re: [PATCH] ARM: dts: at91: sama5d2: remove atmel,wakeup-type
 references
To:     <robh+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1609845525-10766-1-git-send-email-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <db4a3af3-c198-16fc-205f-ad7421739131@microchip.com>
Date:   Thu, 21 Jan 2021 14:29:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1609845525-10766-1-git-send-email-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2021 at 12:18, Claudiu Beznea wrote:
> atmel,wakeup-type DT property is not referenced anywhere in the current
> and previous version of the code thus remove it.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

It's even not documented in any binding document. I take it now, even 
without Rob's tag.

Best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/at91-kizbox3_common.dtsi    | 1 -
>   arch/arm/boot/dts/at91-sama5d27_som1_ek.dts   | 1 -
>   arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts | 1 -
>   arch/arm/boot/dts/at91-sama5d2_icp.dts        | 1 -
>   arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts     | 1 -
>   arch/arm/boot/dts/at91-sama5d2_xplained.dts   | 1 -
>   6 files changed, 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-kizbox3_common.dtsi b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
> index 9ce513dd514b..c4b3750495da 100644
> --- a/arch/arm/boot/dts/at91-kizbox3_common.dtsi
> +++ b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
> @@ -341,7 +341,6 @@
>   
>   	input@0 {
>   		reg = <0>;
> -		atmel,wakeup-type = "low";
>   	};
>   };
>   
> diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> index 0e159f879c15..84e1180f3e89 100644
> --- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> +++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> @@ -142,7 +142,6 @@
>   
>   				input@0 {
>   					reg = <0>;
> -					atmel,wakeup-type = "low";
>   				};
>   			};
>   
> diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
> index 6b38fa3f5568..180a08765cb8 100644
> --- a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
> +++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
> @@ -209,7 +209,6 @@
>   
>   	input@0 {
>   		reg = <0>;
> -		atmel,wakeup-type = "low";
>   	};
>   };
>   
> diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at91-sama5d2_icp.dts
> index 6783cf16ff81..46722a163184 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
> @@ -697,7 +697,6 @@
>   
>   	input@0 {
>   		reg = <0>;
> -		atmel,wakeup-type = "low";
>   	};
>   };
>   
> diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
> index c894c7c788a9..8de57d164acd 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
> @@ -206,7 +206,6 @@
>   
>   				input@0 {
>   					reg = <0>;
> -					atmel,wakeup-type = "low";
>   				};
>   			};
>   
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index 058fae1b4a76..4e7cf21f124c 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -351,7 +351,6 @@
>   
>   				input@0 {
>   					reg = <0>;
> -					atmel,wakeup-type = "low";
>   				};
>   			};
>   
> 


-- 
Nicolas Ferre
