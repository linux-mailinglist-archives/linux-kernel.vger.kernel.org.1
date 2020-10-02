Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FFC281780
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388083AbgJBQJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:09:55 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59722 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBQJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:09:55 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 092G9pRN047766;
        Fri, 2 Oct 2020 11:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601654991;
        bh=9xTA5+qh/F+xiW0/+hAkPCcePW2qVrOrlKz6iokDxDk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Bw2x/kduHCG1sD/TEX34leq45a8x94VRRnmb0qE4raG6ZUYPBtUB489UPUgE/E8gi
         BqvCgz0GffMF/UomYKNl4SkOQ5yGT7lsnk1xhS+Foj1KrenUyBjDbaDMqSkYZt8CCq
         Ofki5wc+Ewx8S04QBALC6e6jjmsEwngwHKiAbkyg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 092G9p2M104454
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Oct 2020 11:09:51 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 2 Oct
 2020 11:09:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 2 Oct 2020 11:09:50 -0500
Received: from [10.250.232.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 092G9hwS109185;
        Fri, 2 Oct 2020 11:09:45 -0500
Subject: Re: [PATCH 0/8] Add support for UHS modes in TI's J721e and J7200
 boards
To:     Nishanth Menon <nm@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <robh+dt@kernel.org>, <t-kristo@ti.com>
References: <20201001190541.6364-1-faiz_abbas@ti.com>
 <20201001191302.dlp2tzbvkk35vzgd@akan>
 <2a7ceab9-37ec-9117-1d98-9f307b4b5390@ti.com>
 <20201002124926.rr5dk5hhygavgqs3@akan>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <00746c65-d240-e7e9-810d-b6e33655cc57@ti.com>
Date:   Fri, 2 Oct 2020 21:39:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002124926.rr5dk5hhygavgqs3@akan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 02/10/20 6:19 pm, Nishanth Menon wrote:
> On 10:14-20201002, Faiz Abbas wrote:
>> Hi Nishanth,
>>
>> On 02/10/20 12:43 am, Nishanth Menon wrote:
>>> On 00:35-20201002, Faiz Abbas wrote:
>>>> The following patches add support for UHS modes for TI's j721e and j7200
>>>> boards.
>>>>
>>>> Patches 1-3 add support for gpios to j7200-evm
>>>>
>>>> Patches 4-6 add support for voltage regulators for required by the
>>>> SD card in both devices as well as enable UHS modes at 1.8V
>>>>
>>>> Patches 5-6 add some required configs to the arm64 defconfig.
>>>>
>>>> This series depends on driver patches adding tuning support here:
>>>> https://lore.kernel.org/linux-arm-kernel/20200923105206.7988-1-faiz_abbas@ti.com/
>>>>
>>>> Faiz Abbas (8):
>>>>   arm64: dts: ti: k3-j7200-main: Add gpio nodes in main domain
>>>>   arm64: dts: ti: k3-j7200: Add gpio nodes in wakeup domain
>>>>   arm64: dts: ti: k3-j7200-common-proc-board: Disable unused gpio
>>>>     modules
>>>>   arm64: dts: ti: k3-j721e-main: Add output tap delay values
>>>>   arm64: dts: ti: k3-j721e-common-proc-board: Add support SD card UHS
>>>>     modes
>>>>   arm64: dts: ti: k3-j7200-common-proc-board: Add support SD card UHS
>>>>     modes
>>>
>>> Split these up please!
>>
>> Into SD card UHS and gpio series?
>>
>>>>   arm64: defconfig: Enable OMAP I2C driver
>>>>   arm64: defconfig: Enable DAVINCI_GPIO driver
>>>>
>>>
>>> defconfig patches can be posted independent of dts patches, they go to
>>> different branches.
>>
>> I was trying to follow Arnd's advice here:
>> https://lore.kernel.org/linux-arm-kernel/CAK8P3a1JpCCCV-CVQj3+eMfWF+=4AuHPpv390Tyj2pKn63_ZVg@mail.gmail.com/
>>
>> He says that defconfig patches can be sent at the same time as dts updates and maintainers can send those
>> as separate pull requests.
> 
> BTW, [1] your patches 7/8 and 8/8 never hit the mailing list, So, I am
> commenting on the defconfig patches without actually seeing the patches,
> and solely based on $subject in the cover letter.

This is weird. They are there in my patches/ folder and I always do a "git send-email patches/* ..."

Not sure why they didn't get sent. My last send-email command does have all the patches being sent:

https://pastebin.ubuntu.com/p/VNWsrMcBZd/

> 
> The reason for my comment was that I think defconfig series could go
> independent of the remaining series into 5.10, since they are not
> related specifically to this series, they are probably needed even for
> am654 and j721e nodes that already exist and was a miss that we didn't
> enable. Tying that to this specific series didn't make sense to me.

You're right that they are not tied to the series.

> 
> But either way, we are way past rc7. I don't have enough time for
> these patches to bake in -next to make it to 5.10 window. So, lets try
> reposting this after rc1 tag is done so that I can send the defconfig
> (separately for 5.10 window) and the dts staged towards 5.11 (and no,
> I don't consider the dts patches as fixes - they are enabling the next
> level of functionality).
> 

Ok. I'll send only the defconfig patches in a new series and repost v2 of this at rc1.

Thanks,
Fai
