Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73E82B2B4B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 05:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgKNEQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 23:16:08 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58486 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgKNEQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 23:16:08 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AE4Fx1q117260;
        Fri, 13 Nov 2020 22:15:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605327359;
        bh=MEcIuiLefxnDfFM03IZ6KtnSfpToThng1+Csig20+Lg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EmR3NKILOxJD6w7Kqmr2UF2WA6Bsb824waEhjd9DffoYt4dt4LZrAHG+efT5uxzgi
         hw31wwbdwc9+spzF52s2NqtegxjveGFFDmBxsDR9Jd3c7oypn4Od/UMKhMURLTGzfY
         E1VgohmqmHTzr8EDAjKYR4k61t1/n9UrV0lUsfMM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AE4Fxxd062998
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 22:15:59 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 13
 Nov 2020 22:15:59 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 13 Nov 2020 22:15:59 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AE4Fuwq122450;
        Fri, 13 Nov 2020 22:15:57 -0600
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j7200-main: Add gpio nodes in main
 domain
To:     Nishanth Menon <nm@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        <robh+dt@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <t-kristo@ti.com>
References: <20201102191120.20380-1-faiz_abbas@ti.com>
 <20201102191120.20380-2-faiz_abbas@ti.com>
 <20201112163953.soia5cje4ry42ujf@kahuna>
 <6ce6de4b-6e4d-1d2d-aa7a-570d1796d668@ti.com>
 <20201113184020.drntugqsnj7dzsnh@ultimatum>
 <c6267288-581e-3b34-cec5-d5879f3d1283@ti.com>
 <20201113205552.p63u2gxgw4pfxil5@stunning>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <7ee0261c-c6c7-96f2-a15c-587becb28b06@ti.com>
Date:   Sat, 14 Nov 2020 06:15:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113205552.p63u2gxgw4pfxil5@stunning>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 13/11/2020 22:55, Nishanth Menon wrote:
> On 00:39-20201114, Sekhar Nori wrote:
>>
>> I was using the latest schema from master. But I changed to 2020.08.1
>> also, and still don't see the warning.
>>
>> $ dt-doc-validate --version
>> 2020.12.dev1+gab5a73fcef26
>>
>> I dont have a system-wide dtc installed. One in kernel tree is updated.
>>
>> $ scripts/dtc/dtc --version
>> Version: DTC 1.6.0-gcbca977e
>>
>> Looking at your logs, it looks like you have more patches than just this
>> applied. I wonder if thats making a difference. Can you check with just
>> these patches applied to linux-next or share your tree which includes
>> other patches?
>>
>> In your logs, you have such error for other interrupt controller nodes
>> as well. For example:
>>
>>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi:
>> /bus@100000/bus@30000000/interrupt-controller1: Missing #address-cells
>> in interrupt provider
>>
>> Which I don't see in my logs. My guess is some other patch(es) in your
>> patch stack either uncovers this warning or causes it.
> 
> Oh boy! I sent you and myself on wild goose chase! Really sorry about
> messing up in the report of bug.
> 
> It is not dtbs_check, it is building dtbs with W=2 that generates this
> warning. dtc 1.6.0 is sufficient to reproduce this behavior.
> 
> Using v5.10-rc1 as baseline (happens the same with next-20201113 as
> 		well.
> 
> v5.10-rc1: https://pastebin.ubuntu.com/p/Pn9HDqRjQ4/ (recording:
>      https://asciinema.org/a/55YVpql9Bq8rh8fePTxI2xObO)
> 
> v5.10-rc1 + 1st patch in the series(since we are testing):
> 	https://pastebin.ubuntu.com/p/QWQRMSv565/ (recording:
> https://asciinema.org/a/ZSKZkOY13l4lmZ2xWH34jMlM1)
> 
> Diff: https://pastebin.ubuntu.com/p/239sYYT2QY/
> 

This warning come from scripts/dtc/checks.c
and was introduced by commit 3eb619b2f7d8 ("scripts/dtc: Update to upstream version v1.6.0-11-g9d7888cbf19c").

In my opinion it's false warning as there is no requirement to have  #address-cells in interrupt provider node.
by the way, above commit description says: "The interrupt_provider check is noisy, so turn it off for now."

-- 
Best regards,
grygorii
