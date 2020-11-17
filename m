Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37192B5B28
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgKQImr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:42:47 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:43216 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgKQImr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:42:47 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AH8f8nc182454;
        Tue, 17 Nov 2020 08:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=+aRie4tbBexDEFv2DScd8LHVGxXLgZpvnvLkUlXSVqg=;
 b=KmmCginOQbqewQa9euOtiN2INLwoIq9PiJ8qp8CJ4wOk54HrGu/XYIwEJzmTScVGTg5U
 H6yJBBTrOp2z3usaWdQZ6Anvko7+rGF9xDN6zvJHJ578NkuvC3de8lPjOKpBkHf8KRpT
 r+CJQtQGYxTvkHLJLpFpSef8JAP8n/4bN81lxgsm3TqpYUA0j/E7sbnnrqwBpdXJ6as3
 yYkp10wKr16rgR82MKeaJHv/bH+gyL9/HEGQwgWjtHZ7Lqu7Tjj8JyDvMsfmyfgrVOkH
 DWhEV1FGU1+4P8zRvMuaVGikGkOiaFdisKNoJKsGkzjDDos/KDktVvP6QjDLYmndyZ1Q og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34t4rasbva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 08:42:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AH8TZ18126090;
        Tue, 17 Nov 2020 08:40:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34uspt30sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 08:40:23 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AH8eLpG000530;
        Tue, 17 Nov 2020 08:40:21 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Nov 2020 00:40:20 -0800
Subject: Re: [RFC][PATCH v2 11/21] x86/pti: Extend PTI user mappings
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
 <20201116144757.1920077-12-alexandre.chartre@oracle.com>
 <CALCETrXoykRjRPYPfZr6gBKoMnHuRYiJTDOcFYMq8GLef00j1A@mail.gmail.com>
 <820278dc-5f8e-6224-71b4-7c61819f68d1@oracle.com>
 <CALCETrXYP13pPcRfDDkwetLgzA3quYOBg7OTo5nbpLpPfSqaLw@mail.gmail.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <d4be0149-1a28-24e8-7821-e8c96f98a7ac@oracle.com>
Date:   Tue, 17 Nov 2020 09:42:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXYP13pPcRfDDkwetLgzA3quYOBg7OTo5nbpLpPfSqaLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=2 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=2 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/17/20 12:06 AM, Andy Lutomirski wrote:
> On Mon, Nov 16, 2020 at 12:18 PM Alexandre Chartre
> <alexandre.chartre@oracle.com> wrote:
>>
>>
>> On 11/16/20 8:48 PM, Andy Lutomirski wrote:
>>> On Mon, Nov 16, 2020 at 6:49 AM Alexandre Chartre
>>> <alexandre.chartre@oracle.com> wrote:
>>>>
>>>> Extend PTI user mappings so that more kernel entry code can be executed
>>>> with the user page-table. To do so, we need to map syscall and interrupt
>>>> entry code, per cpu offsets (__per_cpu_offset, which is used some in
>>>> entry code), the stack canary, and the PTI stack (which is defined per
>>>> task).
>>>
>>> Does anything unmap the PTI stack?  Mapping is easy, and unmapping
>>> could be a pretty big mess.
>>>
>>
>> No, there's no unmap. The mapping exists as long as the task page-table
>> does (i.e. as long as the task mm exits). I assume that the task stack
>> and mm are freed at the same time but that's not something I have checked.
>>
> 
> Nope.  A multi-threaded mm will free task stacks when the task exits,
> but the mm may outlive the individual tasks.  Additionally, if you
> allocate page tables as part of mapping PTI stacks, you need to make
> sure the pagetables are freed.

So I think I just need to unmap the PTI stack from the user page-table
when the task exits. Everything else is handled because the kernel and
PTI stack are allocated in a single chunk (referenced by task->stack).


>  Finally, you need to make sure that
> the PTI stacks have appropriate guard pages -- just doubling the
> allocation is not safe enough.

The PTI stack does have guard pages because it maps only a part of the task
stack into the user page-table, so pages around the PTI stack are not mapped
into the user-pagetable (the page below is the task stack guard, and the page
above is part of the kernel-only stack so it's never mapped into the user
page-table).

+ *   +-------------+
+ *   |             | ^                       ^
+ *   | kernel-only | | KERNEL_STACK_SIZE     |
+ *   |    stack    | |                       |
+ *   |             | V                       |
+ *   +-------------+ <- top of kernel stack  | THREAD_SIZE
+ *   |             | ^                       |
+ *   | kernel and  | | KERNEL_STACK_SIZE     |
+ *   | PTI stack   | |                       |
+ *   |             | V                       v
+ *   +-------------+ <- top of stack

> My intuition is that this is going to be far more complexity than is justified.

Sounds like only the PTI stack unmap is missing, which is hopefully not
that bad. I will check that.

alex.
