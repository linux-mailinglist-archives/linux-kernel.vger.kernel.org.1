Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5B62CD9A2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgLCOzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:55:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2200 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgLCOzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:55:44 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CmzND2Zsqz67LbF;
        Thu,  3 Dec 2020 22:53:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 3 Dec 2020 15:54:57 +0100
Received: from [10.47.8.200] (10.47.8.200) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 3 Dec 2020
 14:54:56 +0000
Subject: Re: [RESEND PATCH v3 0/4] iommu/iova: Solve longterm IOVA issue
To:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Will Deacon <will@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>, <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <kernel-team@android.com>, <xiyou.wangcong@gmail.com>,
        <linuxarm@huawei.com>, <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
 <160685669713.992935.17438167536143205811.b4-ty@kernel.org>
 <CAJwJo6YmF+tW2_it2BLCP6fLBrUR6kfx7jG0hsNy6uYG203Jfw@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6e09d847-fb7f-1ec1-02bf-f0c8b315845f@huawei.com>
Date:   Thu, 3 Dec 2020 14:54:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAJwJo6YmF+tW2_it2BLCP6fLBrUR6kfx7jG0hsNy6uYG203Jfw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.8.200]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2020 06:04, Dmitry Safonov wrote:
> On Tue, 1 Dec 2020 at 21:50, Will Deacon<will@kernel.org>  wrote:
>> On Tue, 17 Nov 2020 18:25:30 +0800, John Garry wrote:
>>> This series contains a patch to solve the longterm IOVA issue which
>>> leizhen originally tried to address at [0].
>>>
>>> A sieved kernel log is at the following, showing periodic dumps of IOVA
>>> sizes, per CPU and per depot bin, per IOVA size granule:
>>> https://raw.githubusercontent.com/hisilicon/kernel-dev/topic-iommu-5.10-iova-debug-v3/aging_test
>>>
>>> [...]
>> Applied the final patch to arm64 (for-next/iommu/iova), thanks!
>>
>> [4/4] iommu: avoid taking iova_rbtree_lock twice
>>        https://git.kernel.org/arm64/c/3a651b3a27a1
> Glad it made in next, 2 years ago I couldn't convince iommu maintainer
> it's worth it (but with a different justification):
> https://lore.kernel.org/linux-iommu/20180621180823.805-3-dima@arista.com/

Hi Dmitry,

I was unaware of your series, and it’s unfortunate that your 
optimization never made it. However I was having a quick look there, 
and, in case you did not notice, that the code which you were proposing 
changing in patch #1 for intel-iommu.c was removed in e70b081c6f37 
("iommu/vt-d: Remove IOVA handling code from the non-dma_ops path").

BTW, split_and_remove_iova() has no in-tree users anymore, so I can send 
a patch to delete if nobody else wants to.

BTW2, there's some more patches in my series which could use a review if 
you're feeling very helpful :)

Cheers,
John
