Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBD02B8312
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 18:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgKRRTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 12:19:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54226 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgKRRTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 12:19:42 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AIH9iqM072113;
        Wed, 18 Nov 2020 17:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=z/X9i5mztvM0OkHMOhe2dlJ5NTBBC7doCvCu+x+61iY=;
 b=lfOr/989aI6RE0ax2TmGko0pPBd/JksoK8rpN7CgxqqQ/3Aogn1ixW9crhufewIPx+9d
 1jdASFvrKJgubYW/TPSHGIrBLdxN1APQpKaR7pjYeXclXLjCbNGLe4Chk4TTsNQt+odX
 bzXZHKxwAIuiHONdxjUaO3AhIqr94hS6w41bWsqjJmoN9VTXxiyod1EJdQjGEc6x331b
 CM8vfdKHFdeDKQZwTVcbed/Ha3ibTArUnDSG1R3FOb5Q/DSie1zPUGABrIwgzjag3MpB
 e98rHjuTNgX0Hvx23QC4XCwKD4dcHqYCmlDd7bx1pBICf2eJ/NUmIu1P0RLMD2/uT1fX cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34t7vn94u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 17:15:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AIHBW3J074118;
        Wed, 18 Nov 2020 17:13:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34ts0sj3kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 17:13:02 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AIHColg006756;
        Wed, 18 Nov 2020 17:12:57 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Nov 2020 09:12:50 -0800
Subject: Re: [RFC][PATCH v2 00/21] x86/pti: Defer CR3 switch to C code
To:     David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "jan.setjeeilers@oracle.com" <jan.setjeeilers@oracle.com>,
        "junaids@google.com" <junaids@google.com>,
        "oweisse@google.com" <oweisse@google.com>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "graf@amazon.de" <graf@amazon.de>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "kuzuno@gmail.com" <kuzuno@gmail.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116201711.GE1131@zn.tnic>
 <44a88648-738a-4a4b-9c25-6b70000e037c@oracle.com>
 <20201117165539.GG5719@zn.tnic>
 <890f6b7e-a268-2257-edcb-5eacc7db3d8e@oracle.com>
 <20201117212608.GS5719@zn.tnic>
 <b63ec614-8a49-728d-aa61-76339378183f@oracle.com>
 <ce8d862f498042d1bd7a6e8a071f06bf@AcuMS.aculab.com>
 <0bedae59-5397-9cae-3c2a-66bc376f5616@oracle.com>
 <5c93e47e106c42659b2004e8de604d61@AcuMS.aculab.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <16cbd9ee-d8d9-7253-6d60-8ebf014aec06@oracle.com>
Date:   Wed, 18 Nov 2020 18:15:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5c93e47e106c42659b2004e8de604d61@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011180119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/18/20 2:22 PM, David Laight wrote:
> From: Alexandre Chartre
>> Sent: 18 November 2020 10:30
> ...
>> Correct, this RFC is not changing the overhead. However, it is a step forward
>> for being able to execute some selected syscalls or interrupt handlers without
>> switching to the kernel page-table. The next step would be to identify and add
>> the necessary mapping to the user page-table so that specified syscalls can be
>> executed without switching the page-table.
> 
> Remember that without PTI user space can read all kernel memory.
> (I'm not 100% sure you can force a cache-line read.)
> It isn't even that slow.
> (Even I can understand how it works.)
>
> So if you are worried about user space doing that you can't really
> run anything on the user page tables.

Yes, without PTI, userspace can read all kernel memory. But to run some
part of the kernel you don't need to have all kernel mappings. Also a lot
of the kernel contain non-sensitive information which can be safely expose
to userspace. So there's probably some room for running carefully selected
syscalls with the user page-table (and hopefully useful ones).
  

> System calls like getpid() are irrelevant - they aren't used (much).
> Even the time of day ones are implemented in the VDSO without a
> context switch.

getpid()/getppid() is interesting because it provides the amount of overhead
PTI is adding. But the impact can be more important if some TLB flushing are
also required (as you mentioned below).


> So the overheads come from other system calls that 'do work'
> without actually sleeping.
> I'm guessing things like read, write, sendmsg, recvmsg.
> 
> The only interesting system call I can think of is futex.
> As well as all the calls that return immediately because the
> mutex has been released while entering the kernel, I suspect
> that being pre-empted by a different thread (of the same process)
> doesn't actually need CR3 reloading (without PTI).
> 
> I also suspect that it isn't just the CR3 reload that costs.
> There could (depending on the cpu) be associated TLB and/or cache
> invalidations that have a much larger effect on programs with
> large working sets than on simple benchmark programs.

Right, although the TLB flush is mitigated with PCID, but this has
more impact if there's no PCID.


> Now bits of data that you are 'more worried about' could be kept
> in physical memory that isn't normally mapped (or referenced by
> a TLB) and only mapped when needed.
> But that doesn't help the general case.
> 

Note that having syscall which could be done without switching the
page-table is just one benefit you can get from this RFC. But the main
benefit is for integrating Address Space Isolation (ASI) which will be
much more complex if ASI as to plug in the current assembly CR3 switch.

Thanks,

alex.
