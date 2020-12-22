Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3EC2E0B10
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgLVNp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:45:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10065 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgLVNp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:45:57 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D0cy65Bv6zLxlQ;
        Tue, 22 Dec 2020 21:44:14 +0800 (CST)
Received: from [10.67.102.197] (10.67.102.197) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 22 Dec 2020 21:45:03 +0800
Subject: Re: [PATCH] powerpc:Don't print raw EIP/LR hex values in dump_stack()
 and show_regs()
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        David Laight <David.Laight@aculab.com>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "ravi.bangoria@linux.ibm.com" <ravi.bangoria@linux.ibm.com>,
        "mikey@neuling.org" <mikey@neuling.org>,
        "yanaijie@huawei.com" <yanaijie@huawei.com>,
        "haren@linux.ibm.com" <haren@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "wangle6@huawei.com" <wangle6@huawei.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20201221032758.12143-1-nixiaoming@huawei.com>
 <2279fc96-1f10-0c3f-64d9-734f18758620@csgroup.eu>
 <20201221163130.GZ2672@gate.crashing.org>
 <ad814ccf34c14c76b45e50b6e7741c3a@AcuMS.aculab.com>
 <20201221171228.GA2672@gate.crashing.org>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <9b874bd4-9ac8-eb94-8432-8d6193c3feaf@huawei.com>
Date:   Tue, 22 Dec 2020 21:45:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20201221171228.GA2672@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/22 1:12, Segher Boessenkool wrote:
> On Mon, Dec 21, 2020 at 04:42:23PM +0000, David Laight wrote:
>> From: Segher Boessenkool
>>> Sent: 21 December 2020 16:32
>>>
>>> On Mon, Dec 21, 2020 at 04:17:21PM +0100, Christophe Leroy wrote:
>>>> Le 21/12/2020 à 04:27, Xiaoming Ni a écrit :
>>>>> Since the commit 2b0e86cc5de6 ("powerpc/fsl_booke/32: implement KASLR
>>>>> infrastructure"), the powerpc system is ready to support KASLR.
>>>>> To reduces the risk of invalidating address randomization, don't print the
>>>>> EIP/LR hex values in dump_stack() and show_regs().
>>>
>>>> I think your change is not enough to hide EIP address, see below a dump
>>>> with you patch, you get "Faulting instruction address: 0xc03a0c14"
>>>
>>> As far as I can see the patch does nothing to the GPR printout.  Often
>>> GPRs contain code addresses.  As one example, the LR is moved via a GPR
>>> (often GPR0, but not always) for storing on the stack.
>>>
>>> So this needs more work.
>>
>> If the dump_stack() is from an oops you need the real EIP value
>> on order to stand any chance of making headway.
> 
> Or at least the function name + offset, yes.
> 
When the system is healthy, only symbols and offsets are printed,
Output address and symbol + offset when the system is dying
Does this meet both debugging and security requirements?
For example:

+static void __show_regs_ip_lr(const char *flag, unsigned long addr)
+{
+ if (system_going_down()) { /* panic oops reboot */
+         pr_cont("%s["REG"] %pS", flag, addr, (void *)addr);
+ } else {
+         pr_cont("%s%pS", flag, (void *)addr);
+ }
+}
+
  static void __show_regs(struct pt_regs *regs)
  {
         int i, trap;

-   printk("NIP:  "REG" LR: "REG" CTR: "REG"\n",
-          regs->nip, regs->link, regs->ctr);
+ __show_regs_ip_lr("NIP: ", regs->nip);
+ __show_regs_ip_lr(" LR: ", regs->link);
+ pr_cont(" CTR: "REG"\n", regs->ctr);
         printk("REGS: %px TRAP: %04lx   %s  (%s)\n",
                regs, regs->trap, print_tainted(), init_utsname()->release);
         printk("MSR:  "REG" ", regs->msr);




>> Otherwise you might just as well just print 'borked - tough luck'.
> 
> Yes.  ASLR is a house of cards.  But that isn't constructive wrt this
> patch :-)
> 
> 
> Segher
> .
> 

Thanks
Xiaoming Ni
