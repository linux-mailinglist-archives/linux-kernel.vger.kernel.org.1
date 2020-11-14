Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FD92B2BB3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 06:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgKNF5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 00:57:09 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46208 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgKNF5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 00:57:09 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AE5uw3r013450;
        Fri, 13 Nov 2020 23:56:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605333418;
        bh=i/b4QqbFJbheUDWrx4qaD3FufsjZM6A9vQlxEtV8pNk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YzwkqY6cGeKrn5lfJMEELO8P4VLB8m+B2TCW6UV0a8pr208Nk1ZSAmxw2TGl3wT73
         dpTt7n+y8WM7BR6q4etR3L9XiS5kL4PL/H5BGRXC7xeVmOK293Pv+wmWAcTy9StQBv
         O2d8rPSi2zEglCViLmlos8TUiVXYVT0qCxPX3UV4=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AE5uwPN039082
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 23:56:58 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 13
 Nov 2020 23:56:58 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 13 Nov 2020 23:56:58 -0600
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AE5up5f052202;
        Fri, 13 Nov 2020 23:56:55 -0600
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j7200-main: Add gpio nodes in main
 domain
To:     Nishanth Menon <nm@ti.com>, <robh+dt@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
CC:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <t-kristo@ti.com>
References: <20201102191120.20380-1-faiz_abbas@ti.com>
 <20201102191120.20380-2-faiz_abbas@ti.com>
 <20201112163953.soia5cje4ry42ujf@kahuna>
 <6ce6de4b-6e4d-1d2d-aa7a-570d1796d668@ti.com>
 <20201113184020.drntugqsnj7dzsnh@ultimatum>
 <c6267288-581e-3b34-cec5-d5879f3d1283@ti.com>
 <20201113205552.p63u2gxgw4pfxil5@stunning>
 <7ee0261c-c6c7-96f2-a15c-587becb28b06@ti.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <a51d1d23-c5f7-da53-1ecb-87803fb3fdb1@ti.com>
Date:   Sat, 14 Nov 2020 11:26:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7ee0261c-c6c7-96f2-a15c-587becb28b06@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/20 9:45 AM, Grygorii Strashko wrote:
> Hi
> 
> On 13/11/2020 22:55, Nishanth Menon wrote:
>> On 00:39-20201114, Sekhar Nori wrote:
>>>
>>> I was using the latest schema from master. But I changed to 2020.08.1
>>> also, and still don't see the warning.
>>>
>>> $ dt-doc-validate --version
>>> 2020.12.dev1+gab5a73fcef26
>>>
>>> I dont have a system-wide dtc installed. One in kernel tree is updated.
>>>
>>> $ scripts/dtc/dtc --version
>>> Version: DTC 1.6.0-gcbca977e
>>>
>>> Looking at your logs, it looks like you have more patches than just this
>>> applied. I wonder if thats making a difference. Can you check with just
>>> these patches applied to linux-next or share your tree which includes
>>> other patches?
>>>
>>> In your logs, you have such error for other interrupt controller nodes
>>> as well. For example:
>>>
>>>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi:
>>> /bus@100000/bus@30000000/interrupt-controller1: Missing #address-cells
>>> in interrupt provider
>>>
>>> Which I don't see in my logs. My guess is some other patch(es) in your
>>> patch stack either uncovers this warning or causes it.
>>
>> Oh boy! I sent you and myself on wild goose chase! Really sorry about
>> messing up in the report of bug.
>>
>> It is not dtbs_check, it is building dtbs with W=2 that generates this
>> warning. dtc 1.6.0 is sufficient to reproduce this behavior.
>>
>> Using v5.10-rc1 as baseline (happens the same with next-20201113 as
>>         well.
>>
>> v5.10-rc1: https://pastebin.ubuntu.com/p/Pn9HDqRjQ4/ (recording:
>>      https://asciinema.org/a/55YVpql9Bq8rh8fePTxI2xObO)
>>
>> v5.10-rc1 + 1st patch in the series(since we are testing):
>>     https://pastebin.ubuntu.com/p/QWQRMSv565/ (recording:
>> https://asciinema.org/a/ZSKZkOY13l4lmZ2xWH34jMlM1)
>>
>> Diff: https://pastebin.ubuntu.com/p/239sYYT2QY/
>>
> 
> This warning come from scripts/dtc/checks.c
> and was introduced by commit 3eb619b2f7d8 ("scripts/dtc: Update to
> upstream version v1.6.0-11-g9d7888cbf19c").
> 
> In my opinion it's false warning as there is no requirement to have 
> #address-cells in interrupt provider node.
> by the way, above commit description says: "The interrupt_provider check
> is noisy, so turn it off for now."

Adding Andre who adding this check in upstream dtc for guidance.

It looks like address-cells makes sense only if there is an
interrupt-map specified as well. Since we don't use it, I can add

#address-cells = <0>;

to silence the warning. Let me know if there is a better way to deal
with this.

Thanks,
Sekhar
