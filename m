Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34595302034
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 03:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbhAYCOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 21:14:46 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11434 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbhAYCFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 21:05:16 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DPCny1TLTzjBgB;
        Mon, 25 Jan 2021 10:03:34 +0800 (CST)
Received: from [10.174.179.117] (10.174.179.117) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Mon, 25 Jan 2021 10:04:20 +0800
Subject: Re: [PATCH] mm: Fix potential pte_unmap_unlock pte error
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <tglx@linutronix.de>, <dave.hansen@intel.com>,
        <jpoimboe@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>
References: <20210109080118.20885-1-linmiaohe@huawei.com>
 <20210110171443.GC1914459@tassilo.jf.intel.com>
 <530deddf-705e-045d-f7c6-521531dced71@huawei.com>
 <2c691a87-42fd-63f6-6d7a-136be6572fab@huawei.com>
 <20210123180107.95f54cc0849a6d8c6afa16ee@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <372dc830-56ae-799c-6026-bb35c1803026@huawei.com>
Date:   Mon, 25 Jan 2021 10:04:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210123180107.95f54cc0849a6d8c6afa16ee@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/1/24 10:01, Andrew Morton wrote:
> On Fri, 22 Jan 2021 16:27:23 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> Hi Andrew:
>> On 2021/1/14 10:51, Miaohe Lin wrote:
>>> Hi:
>>> On 2021/1/11 1:14, Andi Kleen wrote:
>>>> On Sat, Jan 09, 2021 at 03:01:18AM -0500, Miaohe Lin wrote:
>>>>> Since commit 42e4089c7890 ("x86/speculation/l1tf: Disallow non privileged
>>>>> high MMIO PROT_NONE mappings"), when the first pfn modify is not allowed,
>>>>> we would break the loop with pte unchanged. Then the wrong pte - 1 would
>>>>> be passed to pte_unmap_unlock.
>>>>
>>>> Thanks.
>>>>
>>>> While the fix is correct, I'm not sure if it actually is a real bug. Is there
>>>> any architecture that would do something else than unlocking the underlying
>>>> page?  If it's just the underlying page then it should be always the same
>>>> page, so no bug.
>>>>
>>>
>>> It's just a theoretical issue via code inspection.
>>
>> Should I send a new one without Cc statle or just drop this patch? Thanks.
> 
> Your patch makes the code much less scary looking.  I added Andi's
> observation to the changelog, removed the cc:stable and queued it up,
> thanks.
> 
> .
> 

Sounds reasonable. Many thanks for doing this!
