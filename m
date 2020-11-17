Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CFB2B5A99
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 08:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgKQH4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 02:56:42 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:39846 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgKQH4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 02:56:41 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AH7sOfD105916;
        Tue, 17 Nov 2020 07:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=xAhqxGCZLoi1O5NTHsmK7a/tHEhJ7cD7DaijvEC5Br8=;
 b=h2KNyezJ0JwMsxpFzGNoSrtLr2vY+TlUuzwNK0PMU7IJkk6NjP2eac8p156pydyUDAdz
 bdObjgsp3sY3PWuL2nhRtF3Wy9yCui+eqA66BdRTS+jrJf1ETbcN585SwGw5Z/H8ksdr
 Xoq4PwxgWi3EVVFA6C0gFVoblO9RSWLFeW03wrronuXv6lMMmJd50M8F0A1E+oPDVcrg
 HGwiaWZTW0Ix64wUCgyNsdO9fOwclqYEz/YWXhe3GHv1QWeDUcUvYOup3LgUZB98Av+i
 kpXDGmSA/JcXZAOYEFzx8jGV2SKsGgbim1UIicex0aHvaf5v5WpmbZ16ep1yDsAJ4f/k vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34t4ras6gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 07:56:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AH7pZfB002302;
        Tue, 17 Nov 2020 07:54:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34uspt1abk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 07:54:15 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AH7s405015257;
        Tue, 17 Nov 2020 07:54:05 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 23:54:03 -0800
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
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <44a88648-738a-4a4b-9c25-6b70000e037c@oracle.com>
Date:   Tue, 17 Nov 2020 08:56:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201116201711.GE1131@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170056
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/20 9:17 PM, Borislav Petkov wrote:
> On Mon, Nov 16, 2020 at 03:47:36PM +0100, Alexandre Chartre wrote:
>> This RFC proposes to defer the PTI CR3 switch until we reach C code.
>> The benefit is that this simplifies the assembly entry code, and make
>> the PTI CR3 switch code easier to understand. This also paves the way
>> for further possible projects such an easier integration of Address
>> Space Isolation (ASI), or the possibility to execute some selected
>> syscall or interrupt handlers without switching to the kernel page-table
> 
> What for? What is this going to be used for in the end?
> 

In addition to simplify the assembly entry code, this will also simplify
the integration of Address Space Isolation (ASI) which will certainly be
the primary beneficiary of this change. The main goal of ASI is to provide
KVM address space isolation to mitigate guest-to-host speculative attacks
like L1TF or MDS. Current proposal of ASI is plugged into the CR3 switch
assembly macro which make the code brittle and complex. (see [1])

I am also expected this might help with some other ideas like having
syscall (or interrupt handler) which can run without switching the
page-table.


>> (and thus avoid the PTI page-table switch overhead).
> 
> Overhead of how much? Why do we care?
> 

PTI has a measured overhead of roughly 5% for most workloads, but it can
be much higher in some cases. The overhead is mostly due to the page-table
switch (even with PCID) so if we can run a syscall or an interrupt handler
without switching the page-table then we can get this kind of performance
back.


> What is the big picture justfication for this diffstat
> 
>>   21 files changed, 874 insertions(+), 314 deletions(-)
> 
> and the diffstat for the ASI enablement?
> 

The latest ASI RFC (RFC v4) is here [1]. This RFC has ASI plugged directly into
the CR3 switch assembly macro. We are working on a new implementation, based
on these changes which avoid having to deal with assembly code and makes the
implementation more robust.

alex.

[1] ASI RFCv4 - https://lore.kernel.org/lkml/20200504144939.11318-1-alexandre.chartre@oracle.com/
