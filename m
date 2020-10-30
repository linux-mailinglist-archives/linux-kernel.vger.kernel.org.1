Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D498E2A069B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgJ3Nio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:38:44 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:10707 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgJ3Nio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604065123; x=1635601123;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IxdkBu5jTcomoURsb4SHx7WCHZYkGuK7HHSOhFB2S+k=;
  b=jsJDtX/KuFlLITPXNtIkStNoVoUuchiqkRA0HGu1NlQGCMJMsPwJraFS
   IDlkJNXsXJLNxrlPVaTgrvQLqcJqHrHVca7Io7s62QfFQrv52fO20bHNG
   PbVL82gsQ+g0EINR2wMxY6xMmEtldh840VAio7c/ONsHOv+oV67971Jh2
   sM2t+YlrGYf/DbhM4Lei3JEjOQN4hOo6wKgorqSsxcU2FPxCHc1EBr2ek
   J3i8TTtCQxVyBtnjdoipJUa1L/nM2NpauW2hQGke9149wcXSiNAESes6U
   8KHc+dU7Q9yRBTUYojlHAFu1rqBFzCX0Lt2Iqo9njVuHX06hkvbS0p+fA
   A==;
IronPort-SDR: s+AKAcN1E+8pi9hSSUAyTTlkP3JlkDBwTBEBHAD9LFR6gBmJ8nPNFfpZpt7IMY0ZjnjiDvEzrm
 y4lTIKDarunsvcXTv0qUjwc5UkoDGFCl5LZrLt78O8vwsXbp/r82j4Nwz5HOmwOyfqeNYwGIQW
 ljYm0iWVB/STo8AsNRI+NuKoUeD/TlX67CM/6qAYzvU4u7N8uXauqdzOHC+iPzKqreQZtJSYxv
 gTHU1xTQff9lmU+JCO6npgzyMukNwberoURQddUqNQwPQT/rxGyz/JlXENPNKztK5Z5lwhdzgN
 O/0=
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="97200776"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Oct 2020 06:38:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 30 Oct 2020 06:38:42 -0700
Received: from [10.171.246.60] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 30 Oct 2020 06:38:39 -0700
Subject: Re: [PATCH] ARM: dts: at91: add serial MFD sub-node for usart
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
References: <20201030110702.886638-1-codrin.ciubotariu@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <b054ce5c-58fd-dd86-2cb6-1e1f06a0899e@microchip.com>
Date:   Fri, 30 Oct 2020 14:38:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030110702.886638-1-codrin.ciubotariu@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2020 at 12:07, Codrin Ciubotariu wrote:
> The "atmel,at91sam9260-usart" driver is a MFD driver, so it needs sub-nodes
> to match the registered platform device. For this reason, we add a serial
> subnode to all the "atmel,at91sam9260-usart" serial compatible nods. This
> will also remove the boot warning:
> "atmel_usart_serial: Failed to locate of_node [id: -2]"

I don't remember this warning was raised previously even if the MFD 
driver was added a while ago (Sept. 2018).

I would say it's due to 466a62d7642f ("mfd: core: Make a best effort 
attempt to match devices with the correct of_nodes") which was added on 
mid August and corrected with 22380b65dc70 ("mfd: mfd-core: Ensure 
disabled devices are ignored without error") but maybe not covering our 
case.

So, well, I don't know what's the best option to this change. Moreover, 
I would say that all other USART related properties go into the child 
not if there is a need for one.

Lee, I suspect that we're not the only ones experiencing this ugly 
warning during the boot log: can you point us out how to deal with it 
for our existing atmel_serial.c users?

Best regards,
   Nicolas

> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
>   arch/arm/boot/dts/at91-sam9x60ek.dts     |  3 +++
>   arch/arm/boot/dts/at91rm9200.dtsi        | 15 ++++++++++++
>   arch/arm/boot/dts/at91sam9261.dtsi       | 12 ++++++++++
>   arch/arm/boot/dts/at91sam9261ek.dts      |  3 +++
>   arch/arm/boot/dts/at91sam9263.dtsi       | 12 ++++++++++
>   arch/arm/boot/dts/at91sam9g45.dtsi       | 15 ++++++++++++
>   arch/arm/boot/dts/at91sam9n12.dtsi       | 15 ++++++++++++
>   arch/arm/boot/dts/at91sam9rl.dtsi        | 15 ++++++++++++
>   arch/arm/boot/dts/at91sam9x5.dtsi        | 18 ++++++++++++++
>   arch/arm/boot/dts/at91sam9x5_usart3.dtsi |  3 +++
>   arch/arm/boot/dts/sam9x60.dtsi           |  3 +++
>   arch/arm/boot/dts/sama5d2.dtsi           | 30 ++++++++++++++++++++++++
>   arch/arm/boot/dts/sama5d3.dtsi           | 18 ++++++++++++++
>   arch/arm/boot/dts/sama5d3_uart.dtsi      |  6 +++++
>   arch/arm/boot/dts/sama5d4.dtsi           | 30 ++++++++++++++++++++++++
>   15 files changed, 198 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
> index eae28b82c7fd..e317531f7363 100644
> --- a/arch/arm/boot/dts/at91-sam9x60ek.dts
> +++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
> @@ -280,6 +280,9 @@ AT91_XDMAC_DT_PERID(10))>,
>   		atmel,use-dma-rx;
>   		atmel,use-dma-tx;
>   		status = "okay";
> +		serial {
> +			compatible = "atmel,at91rm9200-usart-serial";
> +		};
>   	};
>   };
>   
> diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
> index d1181ead18e5..2abb646f6b68 100644
> --- a/arch/arm/boot/dts/at91rm9200.dtsi
> +++ b/arch/arm/boot/dts/at91rm9200.dtsi
> @@ -602,6 +602,9 @@ dbgu: serial@fffff200 {
>   				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart0: serial@fffc0000 {
> @@ -615,6 +618,9 @@ usart0: serial@fffc0000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart1: serial@fffc4000 {
> @@ -628,6 +634,9 @@ usart1: serial@fffc4000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart2: serial@fffc8000 {
> @@ -641,6 +650,9 @@ usart2: serial@fffc8000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart3: serial@fffcc000 {
> @@ -654,6 +666,9 @@ usart3: serial@fffcc000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usb1: gadget@fffb0000 {
> diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
> index 7adc36ca8a46..e9602378f92c 100644
> --- a/arch/arm/boot/dts/at91sam9261.dtsi
> +++ b/arch/arm/boot/dts/at91sam9261.dtsi
> @@ -187,6 +187,9 @@ usart0: serial@fffb0000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart1: serial@fffb4000 {
> @@ -200,6 +203,9 @@ usart1: serial@fffb4000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart2: serial@fffb8000{
> @@ -213,6 +219,9 @@ usart2: serial@fffb8000{
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			ssc0: ssc@fffbc000 {
> @@ -307,6 +316,9 @@ dbgu: serial@fffff200 {
>   				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			pinctrl@fffff400 {
> diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
> index beed819609e8..fae5d408268d 100644
> --- a/arch/arm/boot/dts/at91sam9261ek.dts
> +++ b/arch/arm/boot/dts/at91sam9261ek.dts
> @@ -176,6 +176,9 @@ tsc2046@2 {
>   
>   			dbgu: serial@fffff200 {
>   				status = "okay";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			watchdog@fffffd40 {
> diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
> index fe45d96239c9..e4d370b582c8 100644
> --- a/arch/arm/boot/dts/at91sam9263.dtsi
> +++ b/arch/arm/boot/dts/at91sam9263.dtsi
> @@ -546,6 +546,9 @@ dbgu: serial@ffffee00 {
>   				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart0: serial@fff8c000 {
> @@ -559,6 +562,9 @@ usart0: serial@fff8c000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart1: serial@fff90000 {
> @@ -572,6 +578,9 @@ usart1: serial@fff90000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart2: serial@fff94000 {
> @@ -585,6 +594,9 @@ usart2: serial@fff94000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			ssc0: ssc@fff98000 {
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index 19fc748a87c5..8aad026f10ec 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -682,6 +682,9 @@ dbgu: serial@ffffee00 {
>   				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart0: serial@fff8c000 {
> @@ -695,6 +698,9 @@ usart0: serial@fff8c000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart1: serial@fff90000 {
> @@ -708,6 +714,9 @@ usart1: serial@fff90000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart2: serial@fff94000 {
> @@ -721,6 +730,9 @@ usart2: serial@fff94000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart3: serial@fff98000 {
> @@ -734,6 +746,9 @@ usart3: serial@fff98000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			macb0: ethernet@fffbc000 {
> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
> index 0785389f5507..f83d1a313edf 100644
> --- a/arch/arm/boot/dts/at91sam9n12.dtsi
> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> @@ -599,6 +599,9 @@ dbgu: serial@fffff200 {
>   				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			ssc0: ssc@f0010000 {
> @@ -624,6 +627,9 @@ usart0: serial@f801c000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart1: serial@f8020000 {
> @@ -635,6 +641,9 @@ usart1: serial@f8020000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart2: serial@f8024000 {
> @@ -646,6 +655,9 @@ usart2: serial@f8024000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart3: serial@f8028000 {
> @@ -657,6 +669,9 @@ usart3: serial@f8028000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			i2c0: i2c@f8010000 {
> diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
> index 5653e70c84b4..5480b6542c6a 100644
> --- a/arch/arm/boot/dts/at91sam9rl.dtsi
> +++ b/arch/arm/boot/dts/at91sam9rl.dtsi
> @@ -183,6 +183,9 @@ usart0: serial@fffb0000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart1: serial@fffb4000 {
> @@ -196,6 +199,9 @@ usart1: serial@fffb4000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart2: serial@fffb8000 {
> @@ -209,6 +215,9 @@ usart2: serial@fffb8000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart3: serial@fffbc000 {
> @@ -222,6 +231,9 @@ usart3: serial@fffbc000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			ssc0: ssc@fffc0000 {
> @@ -353,6 +365,9 @@ dbgu: serial@fffff200 {
>   				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			pinctrl@fffff400 {
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index 4cdb05079cc7..52aa49b007d1 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -683,6 +683,9 @@ dbgu: serial@fffff200 {
>   				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart0: serial@f801c000 {
> @@ -697,6 +700,9 @@ usart0: serial@f801c000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart1: serial@f8020000 {
> @@ -711,6 +717,9 @@ usart1: serial@f8020000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart2: serial@f8024000 {
> @@ -725,6 +734,9 @@ usart2: serial@f8024000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			i2c0: i2c@f8010000 {
> @@ -781,6 +793,9 @@ uart0: serial@f8040000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			uart1: serial@f8044000 {
> @@ -792,6 +807,9 @@ uart1: serial@f8044000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			adc0: adc@f804c000 {
> diff --git a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
> index 098d3fef5c37..a80593188ac1 100644
> --- a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
> @@ -53,6 +53,9 @@ usart3: serial@f8028000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   		};
>   	};
> diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
> index 84066c1298df..ab4d80134d86 100644
> --- a/arch/arm/boot/dts/sam9x60.dtsi
> +++ b/arch/arm/boot/dts/sam9x60.dtsi
> @@ -598,6 +598,9 @@ AT91_XDMAC_DT_PERID(28))>,
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 47>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			pinctrl: pinctrl@fffff400 {
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 2ddc85dff8ce..26f231147d21 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -444,6 +444,9 @@ AT91_XDMAC_DT_PERID(35))>,
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 24>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			uart1: serial@f8020000 {
> @@ -460,6 +463,9 @@ AT91_XDMAC_DT_PERID(37))>,
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 25>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			uart2: serial@f8024000 {
> @@ -476,6 +482,9 @@ AT91_XDMAC_DT_PERID(39))>,
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 26>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			i2c0: i2c@f8028000 {
> @@ -536,6 +545,9 @@ AT91_XDMAC_DT_PER_IF(1) |
>   					dma-names = "tx", "rx";
>   					atmel,fifo-size = <32>;
>   					status = "disabled";
> +					serial {
> +						compatible = "atmel,at91rm9200-usart-serial";
> +					};
>   				};
>   
>   				spi2: spi@400 {
> @@ -606,6 +618,9 @@ AT91_XDMAC_DT_PER_IF(1) |
>   					dma-names = "tx", "rx";
>   					atmel,fifo-size = <32>;
>   					status = "disabled";
> +					serial {
> +						compatible = "atmel,at91rm9200-usart-serial";
> +					};
>   				};
>   
>   				spi3: spi@400 {
> @@ -771,6 +786,9 @@ AT91_XDMAC_DT_PERID(41))>,
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 27>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			uart4: serial@fc00c000 {
> @@ -787,6 +805,9 @@ AT91_XDMAC_DT_PERID(43))>,
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 28>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			flx2: flexcom@fc010000 {
> @@ -815,6 +836,9 @@ AT91_XDMAC_DT_PER_IF(1) |
>   					dma-names = "tx", "rx";
>   					atmel,fifo-size = <32>;
>   					status = "disabled";
> +					serial {
> +						compatible = "atmel,at91rm9200-usart-serial";
> +					};
>   				};
>   
>   				spi4: spi@400 {
> @@ -885,6 +909,9 @@ AT91_XDMAC_DT_PER_IF(1) |
>   					dma-names = "tx", "rx";
>   					atmel,fifo-size = <32>;
>   					status = "disabled";
> +					serial {
> +						compatible = "atmel,at91rm9200-usart-serial";
> +					};
>   				};
>   
>   				spi5: spi@400 {
> @@ -956,6 +983,9 @@ AT91_XDMAC_DT_PER_IF(1) |
>   					dma-names = "tx", "rx";
>   					atmel,fifo-size = <32>;
>   					status = "disabled";
> +					serial {
> +						compatible = "atmel,at91rm9200-usart-serial";
> +					};
>   				};
>   
>   				spi6: spi@400 {
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index 86137f8d2b45..1791de52d1c3 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -203,6 +203,9 @@ usart0: serial@f001c000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 12>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart1: serial@f0020000 {
> @@ -217,6 +220,9 @@ usart1: serial@f0020000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			uart0: serial@f0024000 {
> @@ -228,6 +234,9 @@ uart0: serial@f0024000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			pwm0: pwm@f002c000 {
> @@ -389,6 +398,9 @@ usart2: serial@f8020000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart3: serial@f8024000 {
> @@ -403,6 +415,9 @@ usart3: serial@f8024000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			sha@f8034000 {
> @@ -497,6 +512,9 @@ dbgu: serial@ffffee00 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 2>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			aic: interrupt-controller@fffff000 {
> diff --git a/arch/arm/boot/dts/sama5d3_uart.dtsi b/arch/arm/boot/dts/sama5d3_uart.dtsi
> index a3eaba995cf4..b9f83b771a09 100644
> --- a/arch/arm/boot/dts/sama5d3_uart.dtsi
> +++ b/arch/arm/boot/dts/sama5d3_uart.dtsi
> @@ -45,6 +45,9 @@ uart0: serial@f0024000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			uart1: serial@f8028000 {
> @@ -56,6 +59,9 @@ uart1: serial@f8028000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   		};
>   	};
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index 04f24cf752d3..0627fa8cdaf4 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -284,6 +284,9 @@ uart0: serial@f8004000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 27>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			ssc0: ssc@f8008000 {
> @@ -443,6 +446,9 @@ usart0: serial@f802c000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart1: serial@f8030000 {
> @@ -461,6 +467,9 @@ usart1: serial@f8030000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			mmc1: mmc@fc000000 {
> @@ -496,6 +505,9 @@ uart1: serial@fc004000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 28>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart2: serial@fc008000 {
> @@ -514,6 +526,9 @@ usart2: serial@fc008000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 29>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart3: serial@fc00c000 {
> @@ -532,6 +547,9 @@ usart3: serial@fc00c000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 30>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			usart4: serial@fc010000 {
> @@ -550,6 +568,9 @@ usart4: serial@fc010000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 31>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			ssc1: ssc@fc014000 {
> @@ -568,6 +589,9 @@ ssc1: ssc@fc014000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 49>;
>   				clock-names = "pclk";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			spi1: spi@fc018000 {
> @@ -588,6 +612,9 @@ spi1: spi@fc018000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 38>;
>   				clock-names = "spi_clk";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   			spi2: spi@fc01c000 {
> @@ -794,6 +821,9 @@ dbgu: serial@fc069000 {
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 45>;
>   				clock-names = "usart";
>   				status = "disabled";
> +				serial {
> +					compatible = "atmel,at91rm9200-usart-serial";
> +				};
>   			};
>   
>   
> 


-- 
Nicolas Ferre
