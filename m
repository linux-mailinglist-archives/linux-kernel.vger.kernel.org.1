Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817652B90C9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgKSLRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:17:47 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49768 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgKSLRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:17:47 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AJBHd3w126102;
        Thu, 19 Nov 2020 05:17:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605784659;
        bh=QbbwgyAqM/69VBC4+TYRSR7wdrvDwDDwNcKhIoBITgs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=E9MDxgBfl6aAtX89MVQy5FxO8msncsWLhAI93nu6ZYCRRkWIljUA0n8WDjJbuUorJ
         W3i/Ar1BGjp2TUSJ1EW4Y326wTte4L04hwVWUvd3XFa1d7HeoH5yp6Wjsk2+G2tt7N
         bKv6WYUseoUs3PYxq4JSKvq9QYebEAiB4IeqvRgE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AJBHdqw081549
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 05:17:39 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 19
 Nov 2020 05:17:38 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 19 Nov 2020 05:17:39 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AJBHa5E116124;
        Thu, 19 Nov 2020 05:17:37 -0600
Subject: Re: [PATCH v2 2/4] arm64: dts: ti: k3: squelch warnings regarding no
 #address-cells for interrupt-controller
To:     Nishanth Menon <nm@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Faiz Abbas <faiz_abbas@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Andre Przywara <andre.przywara@arm.com>
References: <20201117161942.38754-1-nsekhar@ti.com>
 <20201117161942.38754-3-nsekhar@ti.com>
 <ab9658ef-c8a7-155b-acb1-effa872132ca@ti.com>
 <20201118151259.kpag44djji4ssiup@eldest>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <18e41dba-a3dd-308a-605e-63b76ca638e5@ti.com>
Date:   Thu, 19 Nov 2020 13:17:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118151259.kpag44djji4ssiup@eldest>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/11/2020 17:12, Nishanth Menon wrote:
> On 13:38-20201118, Grygorii Strashko wrote:
>> Hi Rob,
>>
>> On 17/11/2020 18:19, Sekhar Nori wrote:
>>> With dtc 1.6.0, building TI device-tree files with W=2 results in warnings
>>> like below for all interrupt controllers.
>>>
>>> /bus@100000/bus@30000000/interrupt-controller1: Missing #address-cells in interrupt provider
>>>
>>> Fix these by adding #address-cells = <0>; for all interrupt controllers in
>>> TI device-tree files. Any other #address-cells value is really only needed
>>> if interrupt-map property is being used (which is not the case for existing
>>> TI device-tree files)
>>>
>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>> ---
>>>    arch/arm64/boot/dts/ti/k3-am65-main.dtsi              |  5 +++++
>>>    arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi            |  2 ++
>>>    arch/arm64/boot/dts/ti/k3-am654-base-board.dts        |  1 +
>>>    arch/arm64/boot/dts/ti/k3-j7200-main.dtsi             |  3 +++
>>>    arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi       |  1 +
>>>    arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts |  1 +
>>>    arch/arm64/boot/dts/ti/k3-j721e-main.dtsi             | 11 +++++++++++
>>>    arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi       |  3 +++
>>>    8 files changed, 27 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> index aa8725db0187..55aaa1404d7d 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> @@ -440,6 +440,7 @@
>>>    		interrupt-controller;
>>>    		interrupt-parent = <&gic500>;
>>>    		#interrupt-cells = <1>;
>>> +		#address-cells = <0>;
>> Does it really required or mandatory to have #address-cells = <0>; defined for interrupt-controller DT nodes which
>> do not have child nodes and no "interrupt-map"?
> 
> Just to help clarify (I could be mistaken as well): is'nt the
> interrupt map for user interrupt map nodes that refer to this
> interrupt controller node to state they dont need a parent address
> specifier - so are we claiming none of the users will have an
> interrupt-map (now and never in the future as well) - we we might want
> to explain why we think that is the case, and if we are expecting dtc
> to deduce that (if so how?)?
> 

The main reason I commented - is hope to get some clarification from DT maintainers.
90% of interrupt-controller nodes do not have #address-cells and I never seen in in GPIO nodes
(most often is present in PCI and GIC nodes).
and nobody seems fixing it. So, if we are going to move this direction it's reasonable to get clarification to be sure.

And there is no "never" here - #address-cells always can be added if really required.

-- 
Best regards,
grygorii
