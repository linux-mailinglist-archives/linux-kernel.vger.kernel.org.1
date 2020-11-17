Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79FA2B6CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgKQSK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:10:26 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56832 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgKQSKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:10:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHI9cq1119279;
        Tue, 17 Nov 2020 18:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=4GjLcg5Os3m+EyOW5OQa2pNFW6Omw9U7viZOiKGPyOQ=;
 b=Z8D2KgJyAfOMRfckq3beTQBHHBG6Gu0Dxk5rbv20kzwsts5D9CknIXvWIQcsj4uDqPjH
 uEBGZ24OrNHOCz7ibaSy08LAtdc/5Esp5LAXcBTG7RivedqZeoW0nVRhJWG5Nhp0rWzU
 MLHuZRQg71HneDKqkjUhyGE/T5RAPmhL7j8eofzyVVDCgpNmiH3sCErPHRLlpbnR8NbQ
 pYDTjBfBEC03zRApW+Q+0rn1YA4i1aI91mTZMYyPfYmND8jXkwQDHV7a1wJ1a0TT04ZE
 RhxqPBvp3lKkpVFWFWGP2JeMeaDeOZ+5Kd4qoIdfmQihPe31ZjRIQlUr/PXGj7oVmeLR PQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34t7vn40eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 18:09:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHI1HGp105691;
        Tue, 17 Nov 2020 18:09:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34umcyhkd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 18:09:53 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AHI9mN0011150;
        Tue, 17 Nov 2020 18:09:50 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Nov 2020 10:09:48 -0800
Subject: Re: [RFC][PATCH v2 00/21] x86/pti: Defer CR3 switch to C code
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, junaids@google.com, oweisse@google.com,
        rppt@linux.vnet.ibm.com, graf@amazon.de, mgross@linux.intel.com,
        kuzuno@gmail.com
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116201711.GE1131@zn.tnic>
 <44a88648-738a-4a4b-9c25-6b70000e037c@oracle.com>
 <20201117165539.GG5719@zn.tnic>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <890f6b7e-a268-2257-edcb-5eacc7db3d8e@oracle.com>
Date:   Tue, 17 Nov 2020 19:12:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201117165539.GG5719@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/17/20 5:55 PM, Borislav Petkov wrote:
> On Tue, Nov 17, 2020 at 08:56:23AM +0100, Alexandre Chartre wrote:
>> The main goal of ASI is to provide KVM address space isolation to
>> mitigate guest-to-host speculative attacks like L1TF or MDS.
> 
> Because the current L1TF and MDS mitigations are lacking or why?
> 

Yes. L1TF/MDS allow some inter cpu-thread attacks which are not mitigated at
the moment. In particular, this allows a guest VM to attack another guest VM
or the host kernel running on a sibling cpu-thread. Core Scheduling will
mitigate the guest-to-guest attack but not the guest-to-host attack. Address
Space Isolation provides a mitigation for guest-to-host attack.


>> Current proposal of ASI is plugged into the CR3 switch assembly macro
>> which make the code brittle and complex. (see [1])
>>
>> I am also expected this might help with some other ideas like having
>> syscall (or interrupt handler) which can run without switching the
>> page-table.
> 
> I still fail to see why we need all that. I read, "this does this and
> that" but I don't read "the current problem is this" and "this is our
> suggested solution for it".
> 
> So what is the issue which needs addressing in the current kernel which
> is going to justify adding all that code?

The main issue this is trying to address is that the CR3 switch is currently
done in assembly code from contexts which are very restrictive: the CR3 switch
is often done when only one or two registers are available for use, sometimes
no stack is available. For example, the syscall entry switches CR3 with a single
register available (%sp) and no stack.

Because of this, it is fairly tricky to expand the logic for switching CR3.
This is a problem that we have faced while implementing Address Space Isolation
(ASI) where we need extra logic to drive the page-table switch. We have successfully
implement ASI with the current CR3 switching assembly code, but this requires
complex assembly construction. Hence this proposal to defer CR3 switching to C
code so that it can be more easily expandable.

Hopefully this can also contribute to make the assembly entry code less complex,
and be beneficial to other projects.


>> PTI has a measured overhead of roughly 5% for most workloads, but it can
>> be much higher in some cases.
> 
> "it can be"? Where? Actual use case?

Some benchmarks are available, in particular from phoronix:

https://www.phoronix.com/scan.php?page=article&item=linux-more-x86pti
https://www.phoronix.com/scan.php?page=news_item&px=x86-PTI-Initial-Gaming-Tests
https://www.phoronix.com/scan.php?page=article&item=linux-kpti-kvm
https://medium.com/@loganaden/linux-kpti-performance-hit-on-real-workloads-8da185482df3


>> The latest ASI RFC (RFC v4) is here [1]. This RFC has ASI plugged
>> directly into the CR3 switch assembly macro. We are working on a new
>> implementation, based on these changes which avoid having to deal with
>> assembly code and makes the implementation more robust.
> 
> This still doesn't answer my questions. I read a lot of "could be used
> for" formulations but I still don't know why we need that. So what is
> the problem that the kernel currently has which you're trying to address
> with this?
> 

Hopefully this is clearer with the answer I provided above.

Thanks,

alex.
