Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5862E77FB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 12:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgL3LNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 06:13:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9704 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgL3LNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 06:13:22 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D5TBH3WQ0zkxJl;
        Wed, 30 Dec 2020 19:11:35 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 30 Dec 2020
 19:12:36 +0800
Subject: Re: [PATCH v2 1/1] ARM: LPAE: use phys_addr_t instead of unsigned
 long in outercache hooks
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201230082805.1428-1-thunder.leizhen@huawei.com>
 <20201230082805.1428-2-thunder.leizhen@huawei.com>
 <20201230095424.GO1551@shell.armlinux.org.uk>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <d20c3746-79c3-508e-303d-bf21dd4c4d3c@huawei.com>
Date:   Wed, 30 Dec 2020 19:12:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201230095424.GO1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/12/30 17:54, Russell King - ARM Linux admin wrote:
> On Wed, Dec 30, 2020 at 04:28:05PM +0800, Zhen Lei wrote:
>> The outercache of some Hisilicon SOCs support physical addresses wider
>> than 32-bits. The unsigned long datatype is not sufficient for mapping
>> physical addresses >= 4GB. The commit ad6b9c9d78b9 ("ARM: 6671/1: LPAE:
>> use phys_addr_t instead of unsigned long in outercache functions") has
>> already modified the outercache functions. But the parameters of the
>> outercache hooks are not changed. This patch use phys_addr_t instead of
>> unsigned long in outercache hooks: inv_range, clean_range, flush_range.
>>
>> To ensure the outercache that does not support LPAE works properly, do
>> cast phys_addr_t to unsigned long by adding a group of temporary
>> variables. For example:
>> -static void l2c220_inv_range(unsigned long start, unsigned long end)
>> +static void l2c220_inv_range(phys_addr_t pa_start, phys_addr_t pa_end)
>>  {
>> +	unsigned long start = pa_start;
>> +	unsigned long end = pa_end;
>>
>> Note that the outercache functions have been doing this cast before this
>> patch. So now, the cast is just moved into the outercache hook functions.
>>
>> No functional change.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> This is fine, but there really needs to be a patch that makes use of
> this change before we accept it into mainline kernels.
> 

OK, I will send the outcache driver of Hisilicon after New Year's Day.

