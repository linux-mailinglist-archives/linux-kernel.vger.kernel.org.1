Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F232B98D2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgKSRDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:03:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37844 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgKSRDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:03:03 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJGriC1121092;
        Thu, 19 Nov 2020 17:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=BxEtFb49MUqdhhgGVcDAcXipwluSP8THkqTEGkvhFx0=;
 b=lnd44dL+/LXrPmq0Y9sB2k81GYCyJ4g4QSGCQlhFyFOblr1G2K/Oj+sc3kk//9r8ckZn
 5gM0xCOB4BG4T6zss/23yIPg4iTnXig6grk/O2dExV7ToOpjP+2lwODhZCg6x2cIFnkb
 f6zMhAuhIwj1BasvcS51TIQGQvGerL43u3fX4Vv5Y4w43vClzU4OFpSoYkRd+l0x1Lsv
 K9VGv+gtzdqEWk6xDkKdC4ow24iu8fFWEhidfJOBcK7jF3AvuXEJ0dE258S7jk8q8a+q
 blD6Xv1huZGYdYEGzOr6p3ffhdxZjA9K3HUz80MvwH304aUMYb6RlzdB7wc9IyyRkjNe Ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34t7vnegck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 17:00:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJGph5t147069;
        Thu, 19 Nov 2020 17:00:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34uspwdqkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 17:00:12 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AJH07Ns023333;
        Thu, 19 Nov 2020 17:00:08 GMT
Received: from linux.home (/92.157.89.78)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Nov 2020 09:00:07 -0800
Subject: Re: [RFC][PATCH v2 12/21] x86/pti: Use PTI stack instead of
 trampoline stack
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jan.setjeeilers@oracle.com, Junaid Shahid <junaids@google.com>,
        oweisse@google.com, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Graf <graf@amazon.de>, mgross@linux.intel.com,
        kuzuno@gmail.com
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116144757.1920077-13-alexandre.chartre@oracle.com>
 <CALCETrUSCwtR41CCo_cAQf_BwG7istH6fM=bxWh_VfOjSNFmSw@mail.gmail.com>
 <bc8a254e-deaa-388e-99ea-0291f5625b5b@oracle.com>
 <CALCETrUJQJRi6fE=bs3iAySgM8wjmGU1f464FqOuU+PiBwwnQQ@mail.gmail.com>
 <bf919e4b-d56f-711d-f7ae-b463b8fdadfd@oracle.com>
 <CALCETrWS8_yugbLGFpGUbj2Z5bV04jnCNcnc40QUXWCdmJQU-g@mail.gmail.com>
 <6f513efb-cde8-50f4-7872-13a18a10c4a6@oracle.com>
 <CALCETrWBwFifg3mniUcdB7PO1CgzcxaNPYuWK3c7zK9H-hv=6Q@mail.gmail.com>
 <2f6a446a-e656-627c-27f2-8411f318448c@oracle.com>
 <88bab705-4b33-bda9-3ece-563234822095@oracle.com>
 <CALCETrV9ckeSwyjLn4hxuJeakxnkRQ71RAVf44nTWOFva9EJFA@mail.gmail.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <2e976c6b-26e6-7baa-d351-726d7eeb6dcf@oracle.com>
Date:   Thu, 19 Nov 2020 18:02:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrV9ckeSwyjLn4hxuJeakxnkRQ71RAVf44nTWOFva9EJFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/19/20 5:06 PM, Andy Lutomirski wrote:
> On Thu, Nov 19, 2020 at 4:06 AM Alexandre Chartre
> <alexandre.chartre@oracle.com> wrote:
>>
>> On 11/19/20 9:05 AM, Alexandre Chartre wrote:
>>>>>>>>>>>
>>>>>>>>>>> When entering the kernel from userland, use the per-task PTI stack
>>>>>>>>>>> instead of the per-cpu trampoline stack. Like the trampoline stack,
>>>>>>>>>>> the PTI stack is mapped both in the kernel and in the user page-table.
>>>>>>>>>>> Using a per-task stack which is mapped into the kernel and the user
>>>>>>>>>>> page-table instead of a per-cpu stack will allow executing more code
>>>>>>>>>>> before switching to the kernel stack and to the kernel page-table.
>>>>>>>>>>
>>>>>>>>>> Why?
>>>>>>>>>
>>>>>>>>> When executing more code in the kernel, we are likely to reach a point
>>>>>>>>> where we need to sleep while we are using the user page-table, so we need
>>>>>>>>> to be using a per-thread stack.
>>>>>>>>>
>>>>>>>>>> I can't immediately evaluate how nasty the page table setup is because
>>>>>>>>>> it's not in this patch.
>>>>>>>>>
>>>>>>>>> The page-table is the regular page-table as introduced by PTI. It is just
>>>>>>>>> augmented with a few additional mapping which are in patch 11 (x86/pti:
>>>>>>>>> Extend PTI user mappings).
>>>>>>>>>
>>>>>>>>>>      But AFAICS the only thing that this enables is sleeping with user pagetables.
>>>>>>>>>
>>>>>>>>> That's precisely the point, it allows to sleep with the user page-table.
>>>>>>>>>
>>>>>>>>>> Do we really need to do that?
>>>>>>>>>
>>>>>>>>> Actually, probably not with this particular patchset, because I do the page-table
>>>>>>>>> switch at the very beginning and end of the C handler. I had some code where I
>>>>>>>>> moved the page-table switch deeper in the kernel handler where you definitively
>>>>>>>>> can sleep (for example, if you switch back to the user page-table before
>>>>>>>>> exit_to_user_mode_prepare()).
>>>>>>>>>
>>>>>>>>> So a first step should probably be to not introduce the per-task PTI trampoline stack,
>>>>>>>>> and stick with the existing trampoline stack. The per-task PTI trampoline stack can
>>>>>>>>> be introduced later when the page-table switch is moved deeper in the C handler and
>>>>>>>>> we can effectively sleep while using the user page-table.
>>>>>>>>
>>>>>>>> Seems reasonable.
>>>>>>>>
>>>>>>>
>>>>>>> I finally remember why I have introduced a per-task PTI trampoline stack right now:
>>>>>>> that's to be able to move the CR3 switch anywhere in the C handler. To do so, we need
>>>>>>> a per-task stack to enter (and return) from the C handler as the handler can potentially
>>>>>>> go to sleep.
>>>>>>>
>>>>>>> Without a per-task trampoline stack, we would be limited to call the switch CR3 functions
>>>>>>> from the assembly entry code before and after calling the C function handler (also called
>>>>>>> from assembly).
>>>>>>
>>>>>> The noinstr part of the C entry code won't sleep.
>>>>>>
>>>>>
>>>>> But the noinstr part of the handler can sleep, and if it does we will need to
>>>>> preserve the trampoline stack (even if we switch to the per-task kernel stack to
>>>>> execute the noinstr part).
>>>>>
>>>>> Example:
>>>>>
>>>>> #define DEFINE_IDTENTRY(func)                                           \
>>>>> static __always_inline void __##func(struct pt_regs *regs);             \
>>>>>                                                                            \
>>>>> __visible noinstr void func(struct pt_regs *regs)                       \
>>>>> {                                                                       \
>>>>>            irqentry_state_t state;         -+                              \
>>>>>                                             |                              \
>>>>>            user_pagetable_escape(regs);     | use trampoline stack (1)
>>>>>            state = irqentry_enter(regs);    |                              \
>>>>>            instrumentation_begin();        -+                              \
>>>>>            run_idt(__##func, regs);       |===| run __func() on kernel stack (this can sleep)
>>>>>            instrumentation_end();          -+                              \
>>>>>            irqentry_exit(regs, state);      | use trampoline stack (2)
>>>>>            user_pagetable_return(regs);    -+                              \
>>>>> }
>>>>>
>>>>> Between (1) and (2) we need to preserve and use the same trampoline stack
>>>>> in case __func() went sleeping.
>>>>>
>>>>
>>>> Why?  Right now, we have the percpu entry stack, and we do just fine
>>>> if we enter on one percpu stack and exit from a different one.
>>>> We would need to call from asm to C on the entry stack, return back to
>>>> asm, and then switch stacks.
>>>>
>>>
>>> That's the problem: I didn't want to return back to asm, so that the pagetable
>>> switch can be done anywhere in the C handler.
>>>
>>> So yes, returning to asm to switch the stack is the solution if we want to avoid
>>> having per-task trampoline stack. The drawback is that this forces to do the
>>> page-table switch at the beginning and end of the handler; the pagetable switch
>>> cannot be moved deeper down into the C handler.
>>>
>>> But that's probably a good first step (effectively just moving CR3 switch to C
>>> without adding per-task trampoline stack). I will update the patches to do that,
>>> and we can defer the per-task trampoline stack to later if there's an effective
>>> need for it.
>>>
>>
>> That might not be a good first step after all... Calling CR3 switch C functions
>> from assembly introduces extra pt_regs copies between the trampoline stack and the
>> kernel stack.
>>
>> Currently when entering syscall, we immediately switches CR3 and builds pt_regs
>> directly on the kernel stack. On return, registers are restored from pt_regs from
>> the kernel stack, the return frame is built on the trampoline stack and then we
>> switch CR3.
>>
>> To call CR3 switch C functions on syscall entry, we need to switch to the trampoline
>> stack, build pt_regs on the trampoline stack, call CR3 switch, switch to the kernel
>> stack, copy pt_regs to the kernel stack. On return, we have to copy pt_regs back to
>> the trampoline stack, call CR3 switch, restore registers.
>>
>> This is less of an impact for interrupt because we enter on the trampoline stack and
>> the current code already builds pt_regs on the trampoline stack and copies it to the
>> kernel stack (although this can certainly be avoided in the current code).
>>
>> I am not comfortable adding these extra steps in syscall and interrupt as the current
>> code is fairly optimized. With a per-task trampoline stack, we don't have extra copy
>> because we can build pt_regs directly on the trampoline stack and it will preserved
>> even when switching to the kernel stack. On syscall/interrupt return, it also saves
>> a copy of the iret frame from the kernel stack to the trampoline stack.
> 
> IIRC during the early KPTI development, we went through a stage with
> per-task stacks.  It was a mess, and we got rid of it for good reason.
> Your series has a bad diffstat, is a lot of churn, doesn't even handle
> the unmap part yet, and, by itself, adds basically no value.

I had some concerns about this RFC and they have been confirmed :-)

> We need to take a big step back and figure out what problem any of
> this is solving.  As I understand it, most of the issue is that you
> want to be able to switch between kernel and guest mode on one core
> without exposing kernel memory to Meltdown or Spectre attacks from
> guest code on another core.  If so, it seems to me that a much nicer
> solution would be to use a per-cpu or per-vcpu stack for the vm entry.
> It could plausibly even use the existing entry stack.  If you used a
> per-vcpu stack, though, you could even sleep with some care.
> 

A goal for this change was to prepare a smoother integration for Address
Space Isolation (ASI), in particular to meet the recommendation to have
KPTI uses ASI. Given the extra complication to refactor the CR3 switch,
hence to plug ASI into KPTI, I think it is probably best that we first focus
on having a clean and simple ASI implementation (but still generic) which
initially will only be used by KVM. Once we have the ASI framework in place
(with KVM being a consumer of ASI) will certainly be in a better position to
re-evaluate if there is a simple way to integrate with KPTI.

Thanks all feedback and for your time.

alex.
