Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4F22B5140
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgKPTfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:35:16 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34854 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgKPTfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:35:15 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGJKV8x095517;
        Mon, 16 Nov 2020 19:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=RWeINXuiLje/N3MSlb65Y0oEcBF4evaveY/U8g1ActI=;
 b=QB14JbfpPqCawSI/ocC2Jv0oOzSkjuoDIDW8IEjQQjpC2ULn7W+3Mp/zV+mTuBxj5DXo
 HH3fmRLRtob9LRLIJH3wAVkPf1Ch3htRH8f43LmQGx0T8GynShMWQ3CtlvJrOR/THv5M
 1FnQRU1vok7d2vfoaf2OicP5ZCI8Xi1ESOYpm/zPU86dpPewD31VbvpU+k7ZFfHWvC6D
 h/oKKQ4YygnNpbtlFe+oTgDxrnqdKqctWkjEp/Dg8VWea2L5dMS9mUxbKfitRGR4vT6y
 6mIdGwyPMLMr26wzbWzRnfkL0aH9XuQZhhrhS7se5Q1WSpRxEUgd+X6p9r3oUQEya/G/ DA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34t76kpvk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 19:34:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGJKUgF170672;
        Mon, 16 Nov 2020 19:34:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34ts5v3jun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 19:34:47 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AGJYh0T001026;
        Mon, 16 Nov 2020 19:34:43 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 11:34:43 -0800
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
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <93d1f346-7513-069f-dcd9-24f2ea009145@oracle.com>
Date:   Mon, 16 Nov 2020 20:37:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUJQJRi6fE=bs3iAySgM8wjmGU1f464FqOuU+PiBwwnQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/20 7:34 PM, Andy Lutomirski wrote:
> On Mon, Nov 16, 2020 at 10:10 AM Alexandre Chartre
> <alexandre.chartre@oracle.com> wrote:
>>
>>
>> On 11/16/20 5:57 PM, Andy Lutomirski wrote:
>>> On Mon, Nov 16, 2020 at 6:47 AM Alexandre Chartre
>>> <alexandre.chartre@oracle.com> wrote:
>>>>
>>>> When entering the kernel from userland, use the per-task PTI stack
>>>> instead of the per-cpu trampoline stack. Like the trampoline stack,
>>>> the PTI stack is mapped both in the kernel and in the user page-table.
>>>> Using a per-task stack which is mapped into the kernel and the user
>>>> page-table instead of a per-cpu stack will allow executing more code
>>>> before switching to the kernel stack and to the kernel page-table.
>>>
>>> Why?
>>
>> When executing more code in the kernel, we are likely to reach a point
>> where we need to sleep while we are using the user page-table, so we need
>> to be using a per-thread stack.
>>
>>> I can't immediately evaluate how nasty the page table setup is because
>>> it's not in this patch.
>>
>> The page-table is the regular page-table as introduced by PTI. It is just
>> augmented with a few additional mapping which are in patch 11 (x86/pti:
>> Extend PTI user mappings).
>>
>>>   But AFAICS the only thing that this enables is sleeping with user pagetables.
>>
>> That's precisely the point, it allows to sleep with the user page-table.
>>
>>> Do we really need to do that?
>>
>> Actually, probably not with this particular patchset, because I do the page-table
>> switch at the very beginning and end of the C handler. I had some code where I
>> moved the page-table switch deeper in the kernel handler where you definitively
>> can sleep (for example, if you switch back to the user page-table before
>> exit_to_user_mode_prepare()).
>>
>> So a first step should probably be to not introduce the per-task PTI trampoline stack,
>> and stick with the existing trampoline stack. The per-task PTI trampoline stack can
>> be introduced later when the page-table switch is moved deeper in the C handler and
>> we can effectively sleep while using the user page-table.
> 
> Seems reasonable.
> 
> Where is the code that allocates and frees these stacks hiding?  I
> think I should at least read it.

Stacks are allocated/freed with the task stack, this code is unchanged (see
alloc_thread_stack_node()). The trick is that I have doubled the THREAD_SIZE
(patch 8 "x86/pti: Introduce per-task PTI trampoline stack"). Half the stack
is a used as the kernel stack (mapped only in the kernel page-table), the
other half is used as the PTI stack (mapped in the kernel and user page-table).
The mapping to the user page-table is done in mm_map_task() in fork.c (patch 11
"x86/pti: Extend PTI user mappings").

alex.
