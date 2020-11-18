Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90992B7B47
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgKRK2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:28:14 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38206 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgKRK2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:28:13 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AIAOGiC016733;
        Wed, 18 Nov 2020 10:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=irPkb0wEnMeFD50yq3Ox0OK/lpdxkaxQ+tKjERIBYrE=;
 b=J+7D/uibj/uMA4rrvN5Z0+dhGL85TFxY9sfCr2qfLoRlGRUMlNbcB+nxcvoM3lrq4ihh
 BrSqSpClqNJd+psO0Ow1ADsssYm1tgCYKKNZaX28GlBg72yYXxM0LNZc7fgEmvLLuA+K
 U1JF/LnRgbiWNKi9hFIzNd/eUwj06l1OW2Nrr63Oxa1ozr8YBvDbuUhkhWZB+ir7iew+
 GlA5j2kQfpl+1/ZVWNo3sAURA115OXP7ofiVOsI/In0OjRK51Kpug4iR4FkKrEVS70fW
 p/MMLjoo+gmfxYfjVU02p9P6MzpbR/V9JpITfW3TtXI4b7ttCO251bdv3rsLh+4za2CS jQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34t4rayg3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 10:27:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AIAPdR0164690;
        Wed, 18 Nov 2020 10:27:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34uspukr0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 10:27:40 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AIARWLb027340;
        Wed, 18 Nov 2020 10:27:37 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Nov 2020 02:27:32 -0800
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
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <0bedae59-5397-9cae-3c2a-66bc376f5616@oracle.com>
Date:   Wed, 18 Nov 2020 11:29:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <ce8d862f498042d1bd7a6e8a071f06bf@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011180071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011180071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/18/20 10:30 AM, David Laight wrote:
> From: Alexandre Chartre
>> Sent: 18 November 2020 07:42
>>
>>
>> On 11/17/20 10:26 PM, Borislav Petkov wrote:
>>> On Tue, Nov 17, 2020 at 07:12:07PM +0100, Alexandre Chartre wrote:
>>>> Some benchmarks are available, in particular from phoronix:
>>>
>>> What I was expecting was benchmarks *you* have run which show that
>>> perf penalty, not something one can find quickly on the internet and
>>> something one cannot always reproduce her-/himself.
>>>
>>> You do know that presenting convincing numbers with a patchset greatly
>>> improves its chances of getting it upstreamed, right?
>>>
>>
>> Well, it looks like I wrongfully assume that KPTI was a well known performance
>> overhead since it was introduced (because it adds extra page-table switches),
>> but you are right I should be presenting my own numbers.
> 
> IIRC the penalty comes from the page table switch.
> Doing it at a different time is unlikely to make much difference.
>

Correct, this RFC is not changing the overhead. However, it is a step forward
for being able to execute some selected syscalls or interrupt handlers without
switching to the kernel page-table. The next step would be to identify and add
the necessary mapping to the user page-table so that specified syscalls can be
executed without switching the page-table.


> For some workloads the penalty is massive - getting on for 50%.
> We are still using old kernels on AWS.
> 

Here are some micro benchmarks of the getppid and getpid syscalls which highlight
the PTI overhead. This uses the kernel tools/perf command, and the getpid command
from libMICRO (https://github.com/redhat-performance/libMicro):

system running 5.10-rc4 booted with nopti:
------------------------------------------

# perf bench syscall basic
# Running 'syscall/basic' benchmark:
# Executed 10000000 getppid() calls
      Total time: 0.792 [sec]

        0.079223 usecs/op
        12622549 ops/sec

# getpid -B 100000
              prc thr   usecs/call      samples   errors cnt/samp
getpid         1   1      0.08029          102        0   100000


We can see that getpid and getppid syscall have the same execution
time around 0.08 usecs. These syscalls are very small and just return
a value, so the time is mostly spent entering/exiting the kernel.


same system booted with pti:
----------------------------

# perf bench syscall basic
# Running 'syscall/basic' benchmark:
# Executed 10000000 getppid() calls
      Total time: 2.025 [sec]

        0.202527 usecs/op
         4937605 ops/sec

# getpid -B 100000
              prc thr   usecs/call      samples   errors cnt/samp
getpid         1   1      0.20241          102        0   100000


With PTI, the execution time jumps to 0.20 usecs (+0.12 usecs = +150%).

That's a very extreme case because these are very small syscalls, and
in that case the overhead to switch page-tables is significant compared
to the execution time of the syscall.

So with an overhead of +0.12 usecs per syscall, the PTI impact is significant
with workload which uses a lot of short syscalls. But if you use longer syscalls,
for example with an average execution time of 2.0 usecs per syscall then you
have a lower overhead of 6%.

alex.
