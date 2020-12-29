Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80042E6E87
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 07:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgL2Gcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 01:32:35 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9655 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgL2Gcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 01:32:35 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D4l1343dqz15klg;
        Tue, 29 Dec 2020 14:31:03 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Tue, 29 Dec 2020
 14:31:50 +0800
Subject: Re: [PATCH 1/1] ARM: LPAE: use phys_addr_t instead of unsigned long
 in outercache hooks
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201225114458.1334-1-thunder.leizhen@huawei.com>
 <a0ca2ec8-40cf-4b5e-a6fe-f68d9650a82f@huawei.com>
 <20201226121547.GC1551@shell.armlinux.org.uk>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <da5efb31-1bea-af50-5cc9-601212472118@huawei.com>
Date:   Tue, 29 Dec 2020 14:31:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201226121547.GC1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/12/26 20:15, Russell King - ARM Linux admin wrote:
> On Sat, Dec 26, 2020 at 10:18:08AM +0800, Leizhen (ThunderTown) wrote:
>> On 2020/12/25 19:44, Zhen Lei wrote:
>>> The outercache of some Hisilicon SOCs support physical addresses wider
>>> than 32-bits. The unsigned long datatype is not sufficient for mapping
>>> physical addresses >= 4GB. The commit ad6b9c9d78b9 ("ARM: 6671/1: LPAE:
>>> use phys_addr_t instead of unsigned long in outercache functions") has
>>> already modified the outercache functions. But the parameters of the
>>> outercache hooks are not changed. This patch use phys_addr_t instead of
>>> unsigned long in outercache hooks: inv_range, clean_range, flush_range.
>>>
>>> To ensure the outercache that does not support LPAE works properly, do
>>> cast phys_addr_t to unsigned long by adding a middle-tier function.
>>
>> This patch will impact the outercache drivers that have not been merged into
>> the kernel. They should also update the datatype of the outercache hooks.
> 
> This isn't much of a concern to mainline. If it's that big a problem
> for you, then please consider merging your code into mainline so that
> everyone can benefit from it.

All right, I got it.

> 

