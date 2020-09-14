Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70B5268C51
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgINNhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:37:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42140 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgINN0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:26:35 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200914132633euoutp010b7d3f50f747b81f5828dc629c79a5f3~0qV8w8XRd1168011680euoutp01M
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 13:26:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200914132633euoutp010b7d3f50f747b81f5828dc629c79a5f3~0qV8w8XRd1168011680euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600089993;
        bh=LazJEHqWr5JHZhH4YnfcycNbNEHWm3sDL3AOXvPu7Rw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=taH7j5SIP2dDbkAEYB7Aik7wvbeQwXPihXC8fSCUFH6k80Vo6u0XcCHlUB01Fqqxq
         5JMaKhtQTy1L2M4EhHaKeVfkvhPO9L35lljQo0oQhJh0GXOkXqbabHhVI5pMfoPHlf
         VeQbcHAJszTP2u+MLkbN6/Qslgagbp72yzLUN7kM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200914132633eucas1p2bbf2ba14b5279b77bbb218522d446d67~0qV8YXj0Y2229022290eucas1p2i;
        Mon, 14 Sep 2020 13:26:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 71.F6.05997.98F6F5F5; Mon, 14
        Sep 2020 14:26:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200914132633eucas1p23dba9f6ffe292478a1997a2a2a3f765b~0qV76WUQP2826028260eucas1p2V;
        Mon, 14 Sep 2020 13:26:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200914132633eusmtrp18437b6f6da63a7d8aa913a349cf9058b~0qV75ebfM0668806688eusmtrp19;
        Mon, 14 Sep 2020 13:26:33 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-f2-5f5f6f894faa
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 91.90.06017.88F6F5F5; Mon, 14
        Sep 2020 14:26:32 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200914132632eusmtip1900ac21e625f37b027b95ac0fe7f44fd~0qV7A2_3n0268302683eusmtip1H;
        Mon, 14 Sep 2020 13:26:32 +0000 (GMT)
Subject: Re: [PATCH v3 08/16] irqchip/gic: Configure SGIs as standard
 interrupts
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <65565f85-d932-37f3-a8cd-dbd13d7dbfad@samsung.com>
Date:   Mon, 14 Sep 2020 15:26:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8642847d83ef5bb15663d0246d6af668@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOzo7m5Dgve7CoXBkklF3hzUoyDM+3RKgPQdrKg13mhR21
        rCBNS11D8kY2zaldFDPLaXNTkTqVMq3N1MR0fqgkSLxEKmVm1Ha6+O33fy7v8/wfXppQ5FOB
        9KmkVE6bpNaoKE/S3LXg2JSfHBe3ZfhRIHaMCQRuKnsoxTP39Ah/n34uwxV1GTjrzgCJLa1+
        2OF4JMOmD0NSPNBWQeEyR6cEjw7IsbXCJsU6YYnCjZ0FFG42lRK41bhA4Bznzn0K1txulrIN
        lQ2IzcnWU2xlwwXWahiTsVWmNNZUn0+xmU8cJOsc6qDYabtdxjbfucRaLbMStqClHrGzptXR
        3kc898RzmlPpnDY0/JjnyQetXUSKVX7OOFlNZCL9Ch3yoIHZAT/f2Egd8qQVTB2C4aW7SBRz
        CHon+2WimEVgceb9LqPdLa3fgsV4LYKemUGJKGYQjOZNE653fZkYGLtWiFzsxwTBlz6b+1mC
        MUtBEAR3gmK2gm5KR7lYzoRD5dtGN5NMMLwuuk262J+Jha6e96RY4wO2m+Nu9mDCYKi2xz2M
        YNZA9uPyP6yEkXGjeyNgOmgY13VKRKeR0FRVSonsCxPdLTKRV0FvsZ4UG7IRvLM/kIlCj2Dg
        chkSq3aD0/6dch2AYDbCw7ZQMRwBE3l3peJdvGF4ykdcwhuKzDcIMSyHvKsKsXoDGLob/419
        2tdPXEcqwzJrhmV2DMvsGP7PrUJkPVJyaXxiAsdvS+LObubViXxaUsLmE8mJJvT7g/b+7J6z
        oLYfxwXE0EjlJY/eGxunkKrT+YxEAQFNqPzk+1/1xirk8eqM85w2OU6bpuF4Aa2kSZVSvr3m
        01EFk6BO5c5wXAqn/ZuV0B6BmWhtyKjy68Wd65pSA1403Hp+qKX44+yBKaP9/tD6uuzTeyT8
        SExnScrnmqiO4YMlbK4m1+4f4TzH9SvLHVcWTRaN45ktzFhoDVBerciM4oOMCfciq6v84l8s
        ztcc/XztcPqVjbvmheD2vsGs+YstXo83HO425ttezq8+dkYILMWvclUkf1K9NYTQ8upflBDf
        IZwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsVy+t/xu7od+fHxBud2Wlmcv3uI2WLjjPWs
        Fu+X9TBa/Hp3hN1izopKi8Yll1ksdmwXsTh/fgO7xabH11gtLu+aw2Yx4/w+Jovbl3ktds45
        yWrRdegvm8W6fX1sFps3TWW22D7/J7NFyx1TByGPbbu3sXqsmbeG0aOluYfNY96aao+ds+6y
        eyzYVOqxaVUnm0fDgfMsHneu7WHzeHfuHLvH5iX1Hjt3fGby6NuyitHj8ya5AL4oPZui/NKS
        VIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYy1248xF+zkrZj/
        ZiFzA2MPdxcjB4eEgInE9h+qXYxcHEICSxkl3sxoYuxi5ASKy0icnNbACmELS/y51sUGUfSW
        UWJPyzQWkISwQJDE3e6JYA0iAooSny6cZAQpYhbYwSoxc8MhFoiOWUwSLzu/gI1iEzCU6HoL
        MoqTg1fATmLezXVgNouAqsTFSYvBpooKxEmc6XkBVSMocXLmE7A4p4CVxLXlp5hBbGYBM4l5
        mx9C2fISzVtnQ9niEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGRXnFibnFp
        Xrpecn7uJkZgwth27OeWHYxd74IPMQpwMCrx8AbYxsULsSaWFVfmHmKU4GBWEuF1Ons6Tog3
        JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgcksryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpi
        SWp2ampBahFMHxMHp1QDow37JcflR/kbPqyZHlXv5TCv1LF7q82PQiuewLmW707k3wtgeCfu
        /tdJ6saxHruDEX3Ry4oLu+5mf24SEA2+eulr+WKdLvXJJlMZFxmq55u6XlqmfNEixOaL/trj
        nac4Flmwan99ER/lU9JgLPUy53x0Y+w5iVldNy88WV2oqtd11a9lQRyXEktxRqKhFnNRcSIA
        eu0FSS4DAAA=
X-CMS-MailID: 20200914132633eucas1p23dba9f6ffe292478a1997a2a2a3f765b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200914130601eucas1p23ce276d168dee37909b22c75499e68da
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200914130601eucas1p23ce276d168dee37909b22c75499e68da
References: <20200901144324.1071694-1-maz@kernel.org>
        <20200901144324.1071694-9-maz@kernel.org>
        <CGME20200914130601eucas1p23ce276d168dee37909b22c75499e68da@eucas1p2.samsung.com>
        <a917082d-4bfd-a6fd-db88-36e75f5f5921@samsung.com>
        <8642847d83ef5bb15663d0246d6af668@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 14.09.2020 15:13, Marc Zyngier wrote:
> On 2020-09-14 14:06, Marek Szyprowski wrote:
>> On 01.09.2020 16:43, Marc Zyngier wrote:
>>> Change the way we deal with GIC SGIs by turning them into proper
>>> IRQs, and calling into the arch code to register the interrupt range
>>> instead of a callback.
>>>
>>> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> This patch landed in linux next-20200914 as commit ac063232d4b0
>> ("irqchip/gic: Configure SGIs as standard interrupts"). Sadly it breaks
>> booting of all Samsung Exynos 4210/4412 based boards (dual/quad ARM
>> Cortex A9 based). Here are the last lines from the bootlog:
>>
>> [    0.106322] CPU: Testing write buffer coherency: ok
>> [    0.109895] CPU0: Spectre v2: using BPIALL workaround
>> [    0.116057] CPU0: thread -1, cpu 0, socket 9, mpidr 80000900
>> [    0.123885] Setting up static identity map for 0x40100000 - 
>> 0x40100060
>> [    0.130191] rcu: Hierarchical SRCU implementation.
>> [    0.137195] soc soc0: Exynos: CPU[EXYNOS4210] PRO_ID[0x43210211]
>> REV[0x11] Detected
>> [    0.145129] smp: Bringing up secondary CPUs ...
>> [    0.156279] CPU1: thread -1, cpu 1, socket 9, mpidr 80000901
>> [    0.156291] CPU1: Spectre v2: using BPIALL workaround
>> [    2.716379] random: fast init done
>
> Thanks for the report. Is this the funky non-banked GIC?

Both Exynos 4210 and 4412 use non-zero cpu-offset in GIC node in 
device-tree: arch/arm/boot/dts/exynos{4210,4412}.dtsi, so I assume that 
the GIC registers are not banked.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

