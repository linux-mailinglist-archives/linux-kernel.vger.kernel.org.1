Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58812FDFD8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 04:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393419AbhAUCyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:54:51 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11421 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbhAUCjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 21:39:17 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DLmkB020Fzj9BR;
        Thu, 21 Jan 2021 10:36:50 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Thu, 21 Jan 2021 10:37:34 +0800
Subject: Re: [PATCH 0/2] arm64: mm: fix kdump broken with ZONE_DMA
 reintroduced
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20201226033557.116251-1-chenzhou10@huawei.com>
 <20210120124054.GA19504@willie-the-truck> <20210120130741.GB2642@gaia>
CC:     <ardb@kernel.org>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
        <nsaenzjulienne@suse.de>, <song.bao.hua@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <aad956d1-8992-c62f-777d-6e78307c057d@huawei.com>
Date:   Thu, 21 Jan 2021 10:37:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210120130741.GB2642@gaia>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will, Catalin,


On 2021/1/20 21:07, Catalin Marinas wrote:
> On Wed, Jan 20, 2021 at 12:40:55PM +0000, Will Deacon wrote:
>> On Sat, Dec 26, 2020 at 11:35:55AM +0800, Chen Zhou wrote:
>>> If the memory reserved for crash dump kernel falled in ZONE_DMA32,
>>> the devices in crash dump kernel need to use ZONE_DMA will alloc fail.
>>>            
>>> Fix this by reserving low memory in ZONE_DMA if CONFIG_ZONE_DMA is
>>> enabled, otherwise, reserving in ZONE_DMA32.
>>>
>>> Patch 1 updates the comments about the ZONE_DMA.
>>> Patch 2 fix kdump broken.
>>>
>>> Chen Zhou (2):
>>>   arm64: mm: update the comments about ZONE_DMA
>>>   arm64: mm: fix kdump broken with ZONE_DMA reintroduced
>> Please can you repost this if it is still needed after the changes that
>> landed in -rc4?
> I don't think this series is needed anymore but I'll let Chen confirm.
Yes, we don't need this series, Catalin has solved the issue i mentioned.

I will repost the series "support reserving crashkernel above 4G on arm64 kdump"
based on the latest code.

Thanks,
Chen Zhou

