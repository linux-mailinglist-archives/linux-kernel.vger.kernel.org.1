Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC442A64E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 14:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbgKDNOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 08:14:00 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40705 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgKDNN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 08:13:59 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201104131347euoutp01b433d98cb2e328f5173cee7a5c82c624~EUEW-LRSK3207432074euoutp01K
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 13:13:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201104131347euoutp01b433d98cb2e328f5173cee7a5c82c624~EUEW-LRSK3207432074euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604495627;
        bh=NbIVnxajU8EYdGW5iH7ylmOONcmhv3fFkvI4IyiM7wM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=u84IPc5vEiZbAZJpQsiPQzDzxLrBY2WZmAlEjB7Eca54j23278eoQzyOVuFOS8Igr
         /EcF73sAOaszgzXeKOoRObcpG5h1mCxHh4LryGj9/nn1ugJzt8m2HEK1ppP5OYZgco
         /SSCYIJU3oVZJX8GRIbA2VgloQEdMFZghGXs+y3k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201104131342eucas1p1b2a372094105cc014dbf9a9d55e34b89~EUESOVUw-1883618836eucas1p1c;
        Wed,  4 Nov 2020 13:13:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 05.84.06318.609A2AF5; Wed,  4
        Nov 2020 13:13:42 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201104131342eucas1p188d8ac778646ced5c594b1159e1a2410~EUER5xrYI2568225682eucas1p1w;
        Wed,  4 Nov 2020 13:13:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201104131342eusmtrp276a515908cf1fc0f95ff16415b279249~EUER5A6fs2909529095eusmtrp2M;
        Wed,  4 Nov 2020 13:13:42 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-72-5fa2a90675ba
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 79.0A.06314.609A2AF5; Wed,  4
        Nov 2020 13:13:42 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201104131341eusmtip2a57623d30c59583881d4c0f1c5486d7f~EUERdC4-f1290612906eusmtip2t;
        Wed,  4 Nov 2020 13:13:41 +0000 (GMT)
Subject: Re: [PATCH] ARM: dts: exynos: Assign a fixed index to mmc devices
 on exynos4412 based ODROID boards
To:     Markus Reichl <m.reichl@fivetechno.de>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <c1040872-0ae1-3988-29d0-60c8a711cdb1@samsung.com>
Date:   Wed, 4 Nov 2020 14:13:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <5800260a-5332-f627-eb36-32df4fbf05e3@fivetechno.de>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0hTYRTGeXd3t+ty8no1fLV/cBVhQZpYMFIky3TgF/1QkFR21csU3ZRN
        Z/bFkZQ6Lcsi5xSWS2pKms1cZmRp5tLVJoolYkEo4RoauSw1V+16s/z2O+c873nOAy+BkWY8
        jMhTFjMqJV1ACUR86/Cqc5+gzZS5/8UrSmoccuDSulk3JnU6u4RSy+xbXDrR1yyQ6p39PKlr
        aAVILz4dEh4mZNMz5TJLe7VA1t1aLvNYdqfxM0TxOUxBnoZRRSecFeXOGm140Xv/c6s/f2Ba
        MCLSAT8CwQNoxO0S6oCIIKEZIMP1JzhXfAPo9rM7Aq7wAGRsHRBuPnFXLfFYJuFdn8qVwYm+
        ANQ+uYizgyCoRF0Nqxg7CIY3Aeq59npjLwYrARptntpYJYAxSLeg83kQhBgmoLmqUhb5MALp
        V7JZxXaYhbyedYxlMQxEI41zfJb9YCJ6+b1LwDIG96CKniaM4xA0PWfkcYdahejy+i6Ok9C9
        +lqc4yD02fbwb5id6PdjVi/ycQVAHx0dQq6oBWjigh5wqjg041jbuBODEnS/L5prJyKvqVLI
        thEMQFMLgdwNAaje2oBxbTGqukRy6khksHX+sx0YG8euAsqwJZlhSxrDljSG/763AL8dhDAl
        aoWcUccqmdIoNa1QlyjlUdmFCgvw/R/7L9tyL+hfzxoEkACUv/i5tSWTxGmNukwxCBCBUcHi
        I2/sZ0hxDl12nlEVZqpKChj1INhB8KkQcazJdZqEcrqYyWeYIka1OeURfmFaoK2xNFJXPtCV
        N5Jj09uMxNoofjCVZx8Lx8n4cbHp1NGUyXAvdUzTDCW16WlyrfPEo0alxKiQaGZOnjQnzC+/
        C3VDa83EUvZyvqguIiOVSEqJC/Uep8eqOxcPmR8k9w5/IrodfXrPwjZlpFDSYnco5l1f40xL
        TeEpHfFTFF+dS8fsxVRq+g/uiwQnOwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xe7psKxfFG/xt57eYf+Qcq0X/49fM
        FufPb2C32PT4GqvF5V1z2CxmnN/HZPHyyA9Gi9a9R9gdODxu3an32LSqk81j85J6j8+b5AJY
        ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyHs8/
        zlpwl6fi5+/vzA2MJ7m6GDk5JARMJF53fGLqYuTiEBJYyiixYs0aVoiEjMTJaQ1QtrDEn2td
        bBBFbxklVj5bzQ6SEBbIk/g39xgLSEJEYAqjxJmJzxlBHGaBdkaJO29nQ7X8ZpQ4f3oSG0gL
        m4ChRNdbkFkcHLwCdhJPOspBTBYBFYkZP5JBKkQFkiReXpjKBGLzCghKnJz5hAXE5hRwlDj6
        bQPYFGYBM4l5mx8yQ9jyEs1bZ0PZ4hK3nsxnmsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFu
        em6xoV5xYm5xaV66XnJ+7iZGYMxtO/Zz8w7GSxuDDzEKcDAq8fAe2LYwXog1say4MvcQowQH
        s5IIr9PZ03FCvCmJlVWpRfnxRaU5qcWHGE2BfpvILCWanA9MB3kl8YamhuYWlobmxubGZhZK
        4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhjNBItE57tJZ9xulpdWFXK8MKH89oHCNRLnOd6J
        5ni4iiRUivkdV60xjZ/G/P7TySQ16Y/TvS/NTPWoSDBLdUg+fXLLOl8x9WeJ5lK7Ge4KHUrX
        qbHqnzKvZfFVdfM/DfePZ7tOMTLjSyv1ujOz3ub57Vmv9XQvz1s+/Wfl7bLn7PNv5u+TyFZi
        Kc5INNRiLipOBABGhyHUzwIAAA==
X-CMS-MailID: 20201104131342eucas1p188d8ac778646ced5c594b1159e1a2410
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201104102634eucas1p2ec7b705dd5092afa25d9877d1014f46a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201104102634eucas1p2ec7b705dd5092afa25d9877d1014f46a
References: <CGME20201104102634eucas1p2ec7b705dd5092afa25d9877d1014f46a@eucas1p2.samsung.com>
        <20201104102558.11070-1-m.reichl@fivetechno.de>
        <efe8a911-6072-59fb-8a8e-d5cdb4352cab@samsung.com>
        <5800260a-5332-f627-eb36-32df4fbf05e3@fivetechno.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

On 04.11.2020 14:06, Markus Reichl wrote:
> Am 04.11.20 um 13:25 schrieb Marek Szyprowski:
>> On 04.11.2020 11:25, Markus Reichl wrote:
>>> Recently introduced async probe on mmc devices can shuffle block IDs.
>>> Pin them to fixed values to ease booting in evironments where UUIDs 
>>> ar not practical.
>>> Use newly introduced aliases for mmcblk devices from [1].
>>>
>>> [1]
>>> https://patchwork.kernel.org/patch/11747669/
>>>
>>> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
>>> ---
>>>   arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi 
>>> b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>>> index a5c1ce1e396c..aa10d5bc7e1c 100644
>>> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>>> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>>> @@ -13,6 +13,11 @@
>>>   #include "exynos-mfc-reserved-memory.dtsi"
>>>     / {
>>> +    aliases {
>>> +        mmc0 = &sdhci_2;
>>> +        mmc1 = &mshc_0;
>>
>> Like in the OdroidXU3-family patch, I would use 0 for the eMMC (mshc_0)
>> and 2 for the SD-card (sdhci_2).
>
> How to deal then with sdhci_0 (from exynos4.dtsi) vc. mshc_0 (from 
> exynos4412.dts)?

sdhci_0 and mshc_0 both operate on the same physical MMC0 bus, so this 
is not an issue. They cannot be used simultaneously. The latter is just 
faster, the first one has been left there mainly for the software 
compatibility.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

