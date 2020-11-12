Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5972B05BF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgKLNB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:01:59 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38834 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgKLNB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:01:58 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACD1nEc068789;
        Thu, 12 Nov 2020 07:01:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605186109;
        bh=J5YXf8AeZiT1UgWE/Ust7BqXpiisWKt5rEDoeDzRI2g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KkCCdAbXzJmj4QFat4DACGOj/6xb6gwb9RkqYTh4Z7bMfLmaLVJk0qdyRTQsSIhoz
         DU3NG6QqZ10P1v8lP4xp27202XqCNqM+IB3aNKjmFOJlGYzQg7+U2RuQ5HbD04OVj5
         tJb8Q6aMJ0fLtJmfFiqsoXeVV5qaiQFpVZqMxtf0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACD1nNj128392
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 07:01:49 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 07:01:48 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 07:01:48 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACD1j5T059667;
        Thu, 12 Nov 2020 07:01:46 -0600
Subject: Re: [PATCH V2 4/5] arm64: dts: ti: k3-am654-base-board: Fix up
 un-necessary status set to "okay" for USB
To:     Nishanth Menon <nm@ti.com>, Keerthy <j-keerthy@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201112014929.25227-1-nm@ti.com>
 <20201112014929.25227-5-nm@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <ff878520-4939-0f51-dabf-7f7b5ff54311@ti.com>
Date:   Thu, 12 Nov 2020 15:01:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201112014929.25227-5-nm@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2020 03:49, Nishanth Menon wrote:
> The default state of a device tree node is "okay". There is no specific
> use of explicitly adding status = "okay" in the board dts.
> 
> Fixes: 7e7e7dd51d06 ("arm64: dts: ti: k3-am654-base-board: enable USB1")
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Cc: Roger Quadros <rogerq@ti.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger
> ---
> Changes since v1:
> - no change.
> 
> v1: https://lore.kernel.org/linux-arm-kernel/20201104224356.18040-5-nm@ti.com/
> 
>   arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index 199c4d4e7539..744efcbb4f7f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -325,14 +325,6 @@ &sdhci1 {
>   	disable-wp;
>   };
>   
> -&dwc3_1 {
> -	status = "okay";
> -};
> -
> -&usb1_phy {
> -	status = "okay";
> -};
> -
>   &usb1 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&usb1_pins_default>;
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
