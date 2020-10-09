Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A7E2885A9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 10:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbgJII65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 04:58:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732507AbgJII64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 04:58:56 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9FB24A3E691660E77F98;
        Fri,  9 Oct 2020 16:58:55 +0800 (CST)
Received: from [10.67.102.197] (10.67.102.197) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 9 Oct 2020 16:58:48 +0800
Subject: Re: [PATCH] arm:traps: Don't print stack or raw PC/LR values in
 backtraces
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Russell King - ARM Linux admin" <linux@armlinux.org.uk>
CC:     <dima@arista.com>, <will@kernel.org>, <jpoimboe@redhat.com>,
        <akpm@linux-foundation.org>, <christian.brauner@ubuntu.com>,
        <viro@zeniv.linux.org.uk>, <ldufour@linux.ibm.com>,
        <amanieu@gmail.com>, <walken@google.com>,
        <ben.dooks@codethink.co.uk>, <tglx@linutronix.de>,
        <mingo@kernel.org>, <vincent.whitchurch@axis.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wangle6@huawei.com>,
        <luohaizheng@huawei.com>
References: <20201009075957.110017-1-nixiaoming@huawei.com>
 <20201009080849.GM1551@shell.armlinux.org.uk>
 <20201009081820.jargnmck6zfkzegx@linutronix.de>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <ca6d4c91-2059-8325-8622-1445e15bc0b9@huawei.com>
Date:   Fri, 9 Oct 2020 16:58:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20201009081820.jargnmck6zfkzegx@linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/9 16:18, Sebastian Andrzej Siewior wrote:
> On 2020-10-09 09:08:50 [+0100], Russell King - ARM Linux admin wrote:
>> I am really not happy about this - it hurts at least my ability to
>> debug the kernel when people post oopses to the mailing list. If

In the reset scenario, dump_mem is retained:

@@ -125,6 +118,9 @@ static void dump_mem(const char *lvl, const char 
*str, unsigned long bottom,
         mm_segment_t fs;
         int i;

+ /* Do not print virtual addresses in non-reset scenarios */
+ if (!panic_on_oops)
+         return;


>> people wish to make the kernel harder to debug, and are prepared
>> to be told "your kernel is undebuggable" then this patch is fine.
> 
> I haven't look at the patch but don't they keep/add the representation:
>    PC: symbol+offset/size
>    LR: symbol+offset/size
> 
> ? This is needed at very least as a replacement for the missing address.

Yes, only %08lx was deleted, but %ps is still retained.

-	printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pS)\n",
-		loglvl, where, (void *)where, from, (void *)from);
+	printk("%s (%ps) from (%pS)\n",
+		loglvl, (void *)where, (void *)from);

Thanks
Xiaoming Ni

