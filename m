Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417D92B8CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgKSIGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:06:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33244 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgKSIGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:06:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ80uQX082841;
        Thu, 19 Nov 2020 08:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Kwv+YMDhjDHl/xc+wr/ni92ziQ8+up3LgBc2cPV68Ow=;
 b=UndbpfkiWz/GFJn8xq5bjKZDOTd/fVuGLCSSVDiK/oXP8OnwGUcnySONPfrKHy5+TMF1
 M9Q9xE3VqgbfN/2uQWbBLYQoQOU/uC8H8DT/lfX7CT0ZQvDVnFuqD8S6GWnpnVPk1m5l
 fyJnqrB1qtigRNK1JTBsPAqn2PXQ35PTbQIVQa428yq4Qi5Go0/e7QnbaSW83nnEOeEq
 Vmhn+/5ExVYUh6Y5NGrhnuODAXW05TeVy9wKhP1OikpUA8wTru8nfG2V+I1redskrgMw
 UYq5rNgUid/r+o1P8Ssyqxra9ntbBfhlaMSHlGUUbFjUAyXzh5Umhzituzdc8b6piqEl dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34t76m40fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 08:03:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ81MQ5069930;
        Thu, 19 Nov 2020 08:03:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34umd1mq1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 08:03:45 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AJ83YjV013374;
        Thu, 19 Nov 2020 08:03:35 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Nov 2020 00:03:34 -0800
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
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <2f6a446a-e656-627c-27f2-8411f318448c@oracle.com>
Date:   Thu, 19 Nov 2020 09:05:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWBwFifg3mniUcdB7PO1CgzcxaNPYuWK3c7zK9H-hv=6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/19/20 2:49 AM, Andy Lutomirski wrote:
> On Tue, Nov 17, 2020 at 8:59 AM Alexandre Chartre
> <alexandre.chartre@oracle.com> wrote:
>>
>>
>>
>> On 11/17/20 4:52 PM, Andy Lutomirski wrote:
>>> On Tue, Nov 17, 2020 at 7:07 AM Alexandre Chartre
>>> <alexandre.chartre@oracle.com> wrote:
>>>>
>>>>
>>>>
>>>> On 11/16/20 7:34 PM, Andy Lutomirski wrote:
>>>>> On Mon, Nov 16, 2020 at 10:10 AM Alexandre Chartre
>>>>> <alexandre.chartre@oracle.com> wrote:
>>>>>>
>>>>>>
>>>>>> On 11/16/20 5:57 PM, Andy Lutomirski wrote:
>>>>>>> On Mon, Nov 16, 2020 at 6:47 AM Alexandre Chartre
>>>>>>> <alexandre.chartre@oracle.com> wrote:
>>>>>>>>
>>>>>>>> When entering the kernel from userland, use the per-task PTI stack
>>>>>>>> instead of the per-cpu trampoline stack. Like the trampoline stack,
>>>>>>>> the PTI stack is mapped both in the kernel and in the user page-table.
>>>>>>>> Using a per-task stack which is mapped into the kernel and the user
>>>>>>>> page-table instead of a per-cpu stack will allow executing more code
>>>>>>>> before switching to the kernel stack and to the kernel page-table.
>>>>>>>
>>>>>>> Why?
>>>>>>
>>>>>> When executing more code in the kernel, we are likely to reach a point
>>>>>> where we need to sleep while we are using the user page-table, so we need
>>>>>> to be using a per-thread stack.
>>>>>>
>>>>>>> I can't immediately evaluate how nasty the page table setup is because
>>>>>>> it's not in this patch.
>>>>>>
>>>>>> The page-table is the regular page-table as introduced by PTI. It is just
>>>>>> augmented with a few additional mapping which are in patch 11 (x86/pti:
>>>>>> Extend PTI user mappings).
>>>>>>
>>>>>>>     But AFAICS the only thing that this enables is sleeping with user pagetables.
>>>>>>
>>>>>> That's precisely the point, it allows to sleep with the user page-table.
>>>>>>
>>>>>>> Do we really need to do that?
>>>>>>
>>>>>> Actually, probably not with this particular patchset, because I do the page-table
>>>>>> switch at the very beginning and end of the C handler. I had some code where I
>>>>>> moved the page-table switch deeper in the kernel handler where you definitively
>>>>>> can sleep (for example, if you switch back to the user page-table before
>>>>>> exit_to_user_mode_prepare()).
>>>>>>
>>>>>> So a first step should probably be to not introduce the per-task PTI trampoline stack,
>>>>>> and stick with the existing trampoline stack. The per-task PTI trampoline stack can
>>>>>> be introduced later when the page-table switch is moved deeper in the C handler and
>>>>>> we can effectively sleep while using the user page-table.
>>>>>
>>>>> Seems reasonable.
>>>>>
>>>>
>>>> I finally remember why I have introduced a per-task PTI trampoline stack right now:
>>>> that's to be able to move the CR3 switch anywhere in the C handler. To do so, we need
>>>> a per-task stack to enter (and return) from the C handler as the handler can potentially
>>>> go to sleep.
>>>>
>>>> Without a per-task trampoline stack, we would be limited to call the switch CR3 functions
>>>> from the assembly entry code before and after calling the C function handler (also called
>>>> from assembly).
>>>
>>> The noinstr part of the C entry code won't sleep.
>>>
>>
>> But the noinstr part of the handler can sleep, and if it does we will need to
>> preserve the trampoline stack (even if we switch to the per-task kernel stack to
>> execute the noinstr part).
>>
>> Example:
>>
>> #define DEFINE_IDTENTRY(func)                                           \
>> static __always_inline void __##func(struct pt_regs *regs);             \
>>                                                                           \
>> __visible noinstr void func(struct pt_regs *regs)                       \
>> {                                                                       \
>>           irqentry_state_t state;         -+                              \
>>                                            |                              \
>>           user_pagetable_escape(regs);     | use trampoline stack (1)
>>           state = irqentry_enter(regs);    |                              \
>>           instrumentation_begin();        -+                              \
>>           run_idt(__##func, regs);       |===| run __func() on kernel stack (this can sleep)
>>           instrumentation_end();          -+                              \
>>           irqentry_exit(regs, state);      | use trampoline stack (2)
>>           user_pagetable_return(regs);    -+                              \
>> }
>>
>> Between (1) and (2) we need to preserve and use the same trampoline stack
>> in case __func() went sleeping.
>>
> 
> Why?  Right now, we have the percpu entry stack, and we do just fine
> if we enter on one percpu stack and exit from a different one. 
>
> We would need to call from asm to C on the entry stack, return back to
> asm, and then switch stacks.
> 

That's the problem: I didn't want to return back to asm, so that the pagetable
switch can be done anywhere in the C handler.

So yes, returning to asm to switch the stack is the solution if we want to avoid
having per-task trampoline stack. The drawback is that this forces to do the
page-table switch at the beginning and end of the handler; the pagetable switch
cannot be moved deeper down into the C handler.

But that's probably a good first step (effectively just moving CR3 switch to C
without adding per-task trampoline stack). I will update the patches to do that,
and we can defer the per-task trampoline stack to later if there's an effective
need for it.

alex.
