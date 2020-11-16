Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E912B4FC1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 19:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388469AbgKPScy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 13:32:54 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34050 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388105AbgKPScw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 13:32:52 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGIUJoP152544;
        Mon, 16 Nov 2020 18:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=z0fncIWvpWks9UlgsGIQvgOH6hT2maJxTS6diusAzv4=;
 b=JJvtjuK9QQFr2ZXtiVzUOptjaQEiLzuS13JWM8CYjJV3W+EHBbBNLLIoImmPjcYOwaKh
 NX69chLReMHixYr90rK83cNHFPzhs8hnFMzYJATgFaimAAOE9JLJFrAS8YbfM17TPNyA
 vDDrbRrjzeZ40bwLgrRpvvtO1+lUB90gfau4ctmMAVRy7bD6gPwgmlAu0+fHEIXZoBU5
 YacpRVhGGJoa/cNYehPGy4jXggi4LRFimuxB0JRGyYlPUPMd5MQoJxLoiZwQlOc+m9Hk
 9DTv80UmKeqqeok7AWxmu7SJJRDThz/29OoR69PtafiGgfvAzc3E/kUyHN+1irt5w3S2 uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34t4rapph8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 18:32:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGIPXDO032135;
        Mon, 16 Nov 2020 18:32:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34uspsbw5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 18:32:33 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AGIWVuq030741;
        Mon, 16 Nov 2020 18:32:31 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 10:32:30 -0800
Subject: Re: [RFC][PATCH v2 21/21] x86/pti: Use a different stack canary with
 the user and kernel page-table
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
 <20201116144757.1920077-22-alexandre.chartre@oracle.com>
 <CALCETrU5qnsxgLb6W5UPk8RRbbkFTTbjLxHefkBXCyk-2=uDcQ@mail.gmail.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <3cf22df6-86fd-91b3-6dde-ce28ca48a6f6@oracle.com>
Date:   Mon, 16 Nov 2020 19:34:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrU5qnsxgLb6W5UPk8RRbbkFTTbjLxHefkBXCyk-2=uDcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011160109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011160109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/20 5:56 PM, Andy Lutomirski wrote:
> On Mon, Nov 16, 2020 at 6:48 AM Alexandre Chartre
> <alexandre.chartre@oracle.com> wrote:
>>
>> Using stack protector requires the stack canary to be mapped into
>> the current page-table. Now that the page-table switch between the
>> user and kernel page-table is deferred to C code, stack protector can
>> be used while the user page-table is active and so the stack canary
>> is mapped into the user page-table.
>>
>> To prevent leaking the stack canary used with the kernel page-table,
>> use a different canary with the user and kernel page-table. The stack
>> canary is changed when switching the page-table.
> 
> Unless I've missed something, this doesn't have the security
> properties we want.  One CPU can be executing with kernel CR3, and
> another CPU can read the stack canary using Meltdown.

I think you are right because we have the mapping to the stack canary in
the user page-table. From userspace, we will only read the user stack canary,
but using Meltdown we can speculatively read the kernel stack canary which
will be stored at the same place.

> I think that doing this safely requires mapping a different page with
> the stack canary in the two pagetables.

Right.

alex.
