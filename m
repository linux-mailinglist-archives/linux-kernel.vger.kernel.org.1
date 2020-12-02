Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7C82CBA95
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbgLBK24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 05:28:56 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:10129 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388076AbgLBK24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 05:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606904935; x=1638440935;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ksleKb1avugjW4oKaHVFOB5HE573CXp6zC8n/FP+po4=;
  b=m4bxf1zvG/1QxGEKKCzE8lYcXjzjfCumvpe60DGW2LW2ZpSCkXHIVtbw
   tI++LuVtGibXqMuPrTC5itZ/T1zlVCak24sXMv4Hw+2vrLjr/L7BFMnPc
   oRz0rp5xKp0eqhaa37IKJAZK5j5lhjZXNqVHYWnyw61ct3c89lC3kI06h
   cQjHUu2zL4RftUqS0haVuLOuJP+/80WEkAa6GbYS+vQ2DF9YZ7Z8zpJqZ
   NWlvVQCXgXbml2FmsjSkBfocHmEfkQnxZ5M2ogb5V5WTKxHFVYula2vzk
   Zno+E1L/d8eWKw6eCMHeJ0/IwEx6xmmNGjRRb04NrPlmRFQOD7+fMIs35
   w==;
IronPort-SDR: l53MgwORql/xWR6jYqLcu8d/dtPfsPaCpd0bcIWfhP5FaL3KCsLWQczW7Z9BfVpyydrvhrR3FG
 2PyQLzcN/vikE4k+FU4wpe3s6+H5kq3ratEVnI22IPSl4ak9Pr0Q3SPxhsg6Rzk+aAa4MQTlND
 +lw5pYxZzviPcFMVYqgbFGBOC9AwEe3AvUrw+bHUYIsNDdxU0j9Az9MVrGcoZp0lSaR9jNZfZZ
 LksqNJxiTns3YDgGi8GtIYJJXC+N6EvKgc4Ldb9v0TOvS1sZZzSi/Z9miYmZSI8qm3pRzROG+v
 VXg=
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="101103057"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Dec 2020 03:27:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 03:27:50 -0700
Received: from [10.171.246.74] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 2 Dec 2020 03:27:47 -0700
Subject: Re: [PATCH 2/2] ARM: dts: at91: sama5d2: map securam as device
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <sandeepsheriker.mallikarjun@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1606903025-14197-1-git-send-email-claudiu.beznea@microchip.com>
 <1606903025-14197-3-git-send-email-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <c27ce6d6-ee64-af8b-7cd7-2f263653b5f9@microchip.com>
Date:   Wed, 2 Dec 2020 11:27:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1606903025-14197-3-git-send-email-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2020 at 10:57, Claudiu Beznea wrote:
> Due to strobe signal not being propagated from CPU to securam
> the securam needs to be mapped as device or strongly ordered memory
> to work properly. Otherwise, updating to one offset may affect
> the adjacent locations in securam.
> 
> Fixes: d4ce5f44d4409 ("ARM: dts: at91: sama5d2: Add securam node")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   arch/arm/boot/dts/sama5d2.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 2ddc85dff8ce..6d399ac0385d 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -656,6 +656,7 @@
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 51>;
>   				#address-cells = <1>;
>   				#size-cells = <1>;
> +				no-memory-wc;
>   				ranges = <0 0xf8044000 0x1420>;
>   			};
>   
> 


-- 
Nicolas Ferre
