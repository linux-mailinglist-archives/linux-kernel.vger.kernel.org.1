Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642BA2B683F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbgKQPHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:07:52 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58232 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbgKQPHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:07:52 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHF4EZ9086169;
        Tue, 17 Nov 2020 15:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=LJ5Gpontmz7S2CLUM9pY0583Z0BZHf4rwl89j0dY5Ks=;
 b=E/JjIl19XJ1QYmf5EKM2C/uB+KlTg062hrw4Lbgh0cBxqzW7u4u5c2Wk63Oyv2QohAfj
 S+9FgGfZtbQObtiyqMF3VAV5smF5DkFFNBVqhK1Bzfj2wtTzf6Bz7m3ur+ilh/BQPG6h
 7Mh/nNqAVf3KPOeZsA60neXF2pyqyGagVkSq2WRbNpMSm8ZeJU1vORH14J6GHMrzQZdc
 9Z4Le0T7MUs0iEbxFWAUsSMcw+36Kk6vsSirEYp8C4X6TKywdyjrZ86Qt4GgMTc44vG8
 dygCVIQaAuEYGj4Odeimlmi+8xYx2DqMmWnXtyH/SnKUowCtfHIEUQDGLoOjBeZVNMDe ZA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34t4rau1xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 15:07:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHExaRb162222;
        Tue, 17 Nov 2020 15:07:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34usptg84k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 15:07:05 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AHF6t5U006040;
        Tue, 17 Nov 2020 15:07:00 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Nov 2020 07:06:54 -0800
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
Message-ID: <bf919e4b-d56f-711d-f7ae-b463b8fdadfd@oracle.com>
Date:   Tue, 17 Nov 2020 16:09:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUJQJRi6fE=bs3iAySgM8wjmGU1f464FqOuU+PiBwwnQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170112
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

I finally remember why I have introduced a per-task PTI trampoline stack right now:
that's to be able to move the CR3 switch anywhere in the C handler. To do so, we need
a per-task stack to enter (and return) from the C handler as the handler can potentially
go to sleep.

Without a per-task trampoline stack, we would be limited to call the switch CR3 functions
from the assembly entry code before and after calling the C function handler (also called
from assembly).

alex.
