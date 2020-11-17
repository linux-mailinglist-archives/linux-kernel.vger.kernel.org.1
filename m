Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAF62B6AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgKQRAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:00:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53872 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgKQRAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:00:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHGxbOP183116;
        Tue, 17 Nov 2020 16:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=FCltDmIr+jXbG0Ys594WyQPGOm5F5LIyw1Gp1h4Kol4=;
 b=ES2GUMrPSa5Wdd1dlSxPc5NkJenJvcV5VJvwbONDrNJkh9ISgjc/V5lc/SO4pBEj0AI0
 tM8glPlIVypW6pJGQb9pduqJ3zpXfb2xltfoBm4T19HfwpO0CnI+4yE/+n4yb7/lNQIf
 5wuuZm9cwv2apFOHaHXsWkj74yHNKWzDl8C2ENYtm4QAPkCOZ/SROqCDXOI37dMSWR2X
 UEDQV5n5buYD9MzNKmEO/A072h2MWR0FiQSlxsU2tNOJCT5neMhkbvhuS16/K3/w/J9C
 GSVNvQnBLfdRn0CI9h7Q54Ahu6toFIRD0EjDoU8w6hyF78DJcA7adzmFkM8PITJOI+jI dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34t7vn3m12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 16:59:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHGtT4i002703;
        Tue, 17 Nov 2020 16:59:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34ts0r5jm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 16:59:35 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AHGxWD9023272;
        Tue, 17 Nov 2020 16:59:32 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Nov 2020 08:59:32 -0800
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
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <6f513efb-cde8-50f4-7872-13a18a10c4a6@oracle.com>
Date:   Tue, 17 Nov 2020 18:01:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWS8_yugbLGFpGUbj2Z5bV04jnCNcnc40QUXWCdmJQU-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/20 4:52 PM, Andy Lutomirski wrote:
> On Tue, Nov 17, 2020 at 7:07 AM Alexandre Chartre
> <alexandre.chartre@oracle.com> wrote:
>>
>>
>>
>> On 11/16/20 7:34 PM, Andy Lutomirski wrote:
>>> On Mon, Nov 16, 2020 at 10:10 AM Alexandre Chartre
>>> <alexandre.chartre@oracle.com> wrote:
>>>>
>>>>
>>>> On 11/16/20 5:57 PM, Andy Lutomirski wrote:
>>>>> On Mon, Nov 16, 2020 at 6:47 AM Alexandre Chartre
>>>>> <alexandre.chartre@oracle.com> wrote:
>>>>>>
>>>>>> When entering the kernel from userland, use the per-task PTI stack
>>>>>> instead of the per-cpu trampoline stack. Like the trampoline stack,
>>>>>> the PTI stack is mapped both in the kernel and in the user page-table.
>>>>>> Using a per-task stack which is mapped into the kernel and the user
>>>>>> page-table instead of a per-cpu stack will allow executing more code
>>>>>> before switching to the kernel stack and to the kernel page-table.
>>>>>
>>>>> Why?
>>>>
>>>> When executing more code in the kernel, we are likely to reach a point
>>>> where we need to sleep while we are using the user page-table, so we need
>>>> to be using a per-thread stack.
>>>>
>>>>> I can't immediately evaluate how nasty the page table setup is because
>>>>> it's not in this patch.
>>>>
>>>> The page-table is the regular page-table as introduced by PTI. It is just
>>>> augmented with a few additional mapping which are in patch 11 (x86/pti:
>>>> Extend PTI user mappings).
>>>>
>>>>>    But AFAICS the only thing that this enables is sleeping with user pagetables.
>>>>
>>>> That's precisely the point, it allows to sleep with the user page-table.
>>>>
>>>>> Do we really need to do that?
>>>>
>>>> Actually, probably not with this particular patchset, because I do the page-table
>>>> switch at the very beginning and end of the C handler. I had some code where I
>>>> moved the page-table switch deeper in the kernel handler where you definitively
>>>> can sleep (for example, if you switch back to the user page-table before
>>>> exit_to_user_mode_prepare()).
>>>>
>>>> So a first step should probably be to not introduce the per-task PTI trampoline stack,
>>>> and stick with the existing trampoline stack. The per-task PTI trampoline stack can
>>>> be introduced later when the page-table switch is moved deeper in the C handler and
>>>> we can effectively sleep while using the user page-table.
>>>
>>> Seems reasonable.
>>>
>>
>> I finally remember why I have introduced a per-task PTI trampoline stack right now:
>> that's to be able to move the CR3 switch anywhere in the C handler. To do so, we need
>> a per-task stack to enter (and return) from the C handler as the handler can potentially
>> go to sleep.
>>
>> Without a per-task trampoline stack, we would be limited to call the switch CR3 functions
>> from the assembly entry code before and after calling the C function handler (also called
>> from assembly).
> 
> The noinstr part of the C entry code won't sleep.
> 

But the noinstr part of the handler can sleep, and if it does we will need to
preserve the trampoline stack (even if we switch to the per-task kernel stack to
execute the noinstr part).

Example:

#define DEFINE_IDTENTRY(func)                                           \
static __always_inline void __##func(struct pt_regs *regs);             \
                                                                         \
__visible noinstr void func(struct pt_regs *regs)                       \
{                                                                       \
         irqentry_state_t state;         -+                              \
                                          |                              \
         user_pagetable_escape(regs);     | use trampoline stack (1)
         state = irqentry_enter(regs);    |                              \
         instrumentation_begin();        -+                              \
         run_idt(__##func, regs);       |===| run __func() on kernel stack (this can sleep)
         instrumentation_end();          -+                              \
         irqentry_exit(regs, state);      | use trampoline stack (2)
         user_pagetable_return(regs);    -+                              \
}

Between (1) and (2) we need to preserve and use the same trampoline stack
in case __func() went sleeping.

alex.
