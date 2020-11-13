Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981A72B2446
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 20:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgKMTJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 14:09:30 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35272 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgKMTJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 14:09:29 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ADJ9O9w065948;
        Fri, 13 Nov 2020 13:09:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605294564;
        bh=vTFMOQepr1ENT3zHa621HEf1PPDSTxsDdGqDVMrAaUI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hXjVDeVj3T7VCKveabDwoP3NgcVJaPriytdVahjauefig62wCQKQJkDRLtn/WMOEc
         c/QwPQqJj6/i7lkGfOSoLN8T5lPvk6aJLJoxKcf8T5CcNVc5oQEJ7+BnKWuH5G66av
         Yf8TQVeRnGy6aF6KdVrbomq55fZvZlWCHJNspavU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ADJ9OUc060020
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 13:09:24 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 13
 Nov 2020 13:09:24 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 13 Nov 2020 13:09:24 -0600
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ADJ9Jlg077626;
        Fri, 13 Nov 2020 13:09:20 -0600
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j7200-main: Add gpio nodes in main
 domain
To:     Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
CC:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <t-kristo@ti.com>,
        <robh+dt@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>,
        "Vutla, Lokesh" <lokeshvutla@ti.com>
References: <20201102191120.20380-1-faiz_abbas@ti.com>
 <20201102191120.20380-2-faiz_abbas@ti.com>
 <20201112163953.soia5cje4ry42ujf@kahuna>
 <6ce6de4b-6e4d-1d2d-aa7a-570d1796d668@ti.com>
 <20201113184020.drntugqsnj7dzsnh@ultimatum>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <c6267288-581e-3b34-cec5-d5879f3d1283@ti.com>
Date:   Sat, 14 Nov 2020 00:39:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201113184020.drntugqsnj7dzsnh@ultimatum>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/20 12:10 AM, Nishanth Menon wrote:
> On 23:59-20201113, Sekhar Nori wrote:
> [..]
>>> dtbs_check: we added:
>>> arch/arm64/boot/dts/ti/k3-j7200-main.dtsi: /bus@100000/gpio@600000: Missing #address-cells in interrupt provider
>>> arch/arm64/boot/dts/ti/k3-j7200-main.dtsi: /bus@100000/gpio@610000: Missing #address-cells in interrupt provider
>>> arch/arm64/boot/dts/ti/k3-j7200-main.dtsi: /bus@100000/gpio@620000: Missing #address-cells in interrupt provider
>>> arch/arm64/boot/dts/ti/k3-j7200-main.dtsi: /bus@100000/gpio@630000: Missing #address-cells in interrupt provider
>>
>> Hmm, running dtbs_check, I did not really see this. These are all the
>> warnings I see for TI platforms: https://pastebin.ubuntu.com/p/m2my62mjQq/
> 
> Here is the full list of checks I ran through with kernel_patch_verify
> (docker)
> 	https://pastebin.ubuntu.com/p/tcnWw89CMD/
> 
> See lines 128 onwards for this series. kernel_patch_verify does'nt
> complain on existing warnings, but just prints when there are additional
> ones added in. Also make sure we have the right dtc as well
> dtc 1.6.0 and dt_schema 2020.8.1 was used.

I was using the latest schema from master. But I changed to 2020.08.1
also, and still don't see the warning.

$ dt-doc-validate --version
2020.12.dev1+gab5a73fcef26

I dont have a system-wide dtc installed. One in kernel tree is updated.

$ scripts/dtc/dtc --version
Version: DTC 1.6.0-gcbca977e

Looking at your logs, it looks like you have more patches than just this
applied. I wonder if thats making a difference. Can you check with just
these patches applied to linux-next or share your tree which includes
other patches?

In your logs, you have such error for other interrupt controller nodes
as well. For example:

 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi:
/bus@100000/bus@30000000/interrupt-controller1: Missing #address-cells
in interrupt provider

Which I don't see in my logs. My guess is some other patch(es) in your
patch stack either uncovers this warning or causes it.

> 
>>
>> The tree I am testing is linux-next of 12th Nov + these three patches
>> applied.
>>
>> Also, #address-cells for interrupt provider being compulsory does not
>> make full sense to me. Nothing in
>> Documentation/devicetree/bindings/interrupt-controller/interrupts.txt or
>> Documentation/devicetree/bindings/gpio/gpio-davinci.txt suggests that as
>> well.
>>
>> Existing GPIO nodes for AM654 or J721E does not have #address-cells as well.
>>
>> Adding Grygorii as well, in case he knows more about this.
> 
> 
> Yes - we need to have this conversation in the community :) I had
> tagged this internally already during the 5.10 merge cycle that we
> need to clean up the #address-cells warning and in some cases, maybe
> the bindings are probably not accurate to attempt an enforcement.
> I'd really like a conclusion on the topic as I recollect Lokesh and
> Grygorii had a debate internally, but reached no conclusion, lets get
> the wisdom of the community to help us here.

Adding Lokesh to cc as well.

Thanks,
Sekhar
