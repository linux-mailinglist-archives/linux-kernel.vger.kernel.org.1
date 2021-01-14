Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BED2F58AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbhANCwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:52:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11012 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbhANCwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:52:08 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DGTM52rSwzj7Sc;
        Thu, 14 Jan 2021 10:50:25 +0800 (CST)
Received: from [10.174.176.197] (10.174.176.197) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Thu, 14 Jan 2021 10:51:24 +0800
Subject: Re: [PATCH] mm: Fix potential pte_unmap_unlock pte error
To:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <tglx@linutronix.de>, <dave.hansen@intel.com>,
        <jpoimboe@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210109080118.20885-1-linmiaohe@huawei.com>
 <20210110171443.GC1914459@tassilo.jf.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <530deddf-705e-045d-f7c6-521531dced71@huawei.com>
Date:   Thu, 14 Jan 2021 10:51:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210110171443.GC1914459@tassilo.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.197]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/1/11 1:14, Andi Kleen wrote:
> On Sat, Jan 09, 2021 at 03:01:18AM -0500, Miaohe Lin wrote:
>> Since commit 42e4089c7890 ("x86/speculation/l1tf: Disallow non privileged
>> high MMIO PROT_NONE mappings"), when the first pfn modify is not allowed,
>> we would break the loop with pte unchanged. Then the wrong pte - 1 would
>> be passed to pte_unmap_unlock.
> 
> Thanks.
> 
> While the fix is correct, I'm not sure if it actually is a real bug. Is there
> any architecture that would do something else than unlocking the underlying
> page?  If it's just the underlying page then it should be always the same
> page, so no bug.
> 

It's just a theoretical issue via code inspection.

> That said of course the change is the right thing for main line, but probably doesn't
> need to be backported.
> 

So it should not be backported. Should I resend a patch or Andrew would kindly do this?

> -Andi
> .
> 

Many thanks for review and reply.
