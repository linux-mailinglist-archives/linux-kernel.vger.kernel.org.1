Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9923028AC04
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 04:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgJLCYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 22:24:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbgJLCYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 22:24:08 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 36A2E6A6EF26DEA1012C;
        Mon, 12 Oct 2020 10:24:06 +0800 (CST)
Received: from [10.67.102.197] (10.67.102.197) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 10:23:59 +0800
Subject: Re: [PATCH] arm:traps: Don't print stack or raw PC/LR values in
 backtraces
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
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
 <20201011213238.GN1551@shell.armlinux.org.uk>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <ac712544-e479-26aa-226b-1859517ea60e@huawei.com>
Date:   Mon, 12 Oct 2020 10:23:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20201011213238.GN1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/12 5:32, Russell King - ARM Linux admin wrote:
> On Fri, Oct 09, 2020 at 10:18:20AM +0200, Sebastian Andrzej Siewior wrote:
>> On 2020-10-09 09:08:50 [+0100], Russell King - ARM Linux admin wrote:
>>> I am really not happy about this - it hurts at least my ability to
>>> debug the kernel when people post oopses to the mailing list. If
>>> people wish to make the kernel harder to debug, and are prepared
>>> to be told "your kernel is undebuggable" then this patch is fine.
>>
>> I haven't look at the patch but don't they keep/add the representation:
>>    PC: symbol+offset/size
>>    LR: symbol+offset/size
>>
>> ? This is needed at very least as a replacement for the missing address.
> 
> I don't have a problem getting rid of the hex numbers in [< >]
> although then I will need to convert the symbol back to an address
> using the vmlinux to then calculate its address to then find the
> appropriate place in the objdump output - because objdump does
> _not_ use the symbol+offset annotation.  Yes, I really do look up
> the numeric addresses in the objdump output to then read the
> disassembly.
> 
> $ objdump -d vmlinux | less
> 
> and then search for the address is the fastest and most convenient
> way for me rather than having to deal with some random script.
> 
> Maybe I'm just antequated about how I do my debugging, but this
> seems to me to be the most efficient and fastest way.
> 
The loading address of the kernel module is not fixed, so symbol+offset 
is more useful than a hexadecimal address when the call stack contains 
kernel module symbols.
Delete the PC/LR address and retain the sysbol+offset. The kernel can 
still be debugged.

Thanks
Xiaoming Ni
