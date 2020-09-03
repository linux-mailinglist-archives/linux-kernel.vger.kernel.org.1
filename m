Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEE125C2BE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 16:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgICOeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 10:34:11 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36038 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbgICOd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:33:59 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 083DKlfr025250;
        Thu, 3 Sep 2020 08:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599139247;
        bh=4GrWfo0x9VaoTlHZ4MXy0UbyWsGLrveedBvC8mQZtsM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BPgR5+66VnJ5ylJ5c9OnQ2nwCKazBoquhfXAYiH3QVObLetpMwNlfUstG2gfcgKUr
         CK4VYRimnhRQ02hEIef3WlHZAErQwFyNbWv1VKOiu73VmsgSkxwp0gJM0MgdBju8Au
         Ep2ZBeqXHsVt0F0/Wi+3FWYuehjQQqvYOdsY0rzk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 083DKlZM062073
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Sep 2020 08:20:47 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 3 Sep
 2020 08:20:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 3 Sep 2020 08:20:46 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 083DKg6V128723;
        Thu, 3 Sep 2020 08:20:43 -0500
Subject: Re: [PATCH V2 7/8] arm64: dts: ti: k3-am65-wakeup: Use generic
 temperature-sensor for node name
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        <lokeshvutla@ti.com>, <grygorii.strashko@ti.com>, <nsekhar@ti.com>
References: <20200901223059.14801-1-nm@ti.com>
 <20200903130015.21361-8-nm@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <340f59bf-f7f3-866d-ad61-74a1143c5f5b@ti.com>
Date:   Thu, 3 Sep 2020 18:50:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903130015.21361-8-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/20 6:30 PM, Nishanth Menon wrote:
> Use temperature-sensor@ naming for nodes following standard conventions of device
> tree (section 2.2.2 Generic Names recommendation in [1]).
> 
> [1] https://github.com/devicetree-org/devicetree-specification/tree/v0.3
> 
> Suggested-by: Suman Anna <s-anna@ti.com>
> Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
> Reviewed-by: Suman Anna <s-anna@ti.com>

Acked-by: Vignesh Raghavendra <vigneshr@ti.com>

> ---
> Changes:
> v2: None (picked acks/reviews)
> v1: https://lore.kernel.org/linux-arm-kernel/20200901223059.14801-6-nm@ti.com/
> 
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> index bb498be2f0a4..ed42f13e7663 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> @@ -95,7 +95,7 @@
>  		clock-names = "gpio";
>  	};
>  
> -	wkup_vtm0: thermal@42050000 {
> +	wkup_vtm0: temperature-sensor@42050000 {
>  		compatible = "ti,am654-vtm";
>  		reg = <0x42050000 0x25c>;
>  		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
> 
