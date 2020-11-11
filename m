Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581F12AEC70
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 09:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgKKIxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 03:53:52 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46954 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgKKIxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:53:50 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AB8nqZu018798;
        Wed, 11 Nov 2020 08:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=h69Ueb/ZNXKdXkzEiqGkNiFoL9e/QNBM/uJezD1NOs8=;
 b=uyZM4x9Qn5uD2c+mUJNqN9Zy32FFvBtkdlOwwoHfdSvPdlEPfI9amhWyNSLRjX1bqlE6
 bbhaGFqJATt/VnGC+vIRDYxgeBnng62cbO3oRL0mOtGmQRfro5Sowhj4NBGSdIKOvOdm
 gJ1IhPTQyoYXTOmeWl49GkeezWIAvzgii4azC00uBXdUvahF2DQoN/GzysLwjGMbVAS4
 10diEkPUBwgmSWV4EviyJbK+1Ym0hYIA7mH+gfxaJgfy6A+b/v08MyrYWEPgQpRpvwAX
 n8+fTzlu2+xJBCGxEBb0j1iEaOioYJjsvYpOoYOK1NMt8CxFaNWrrw0XcNiaTp8e5sST zA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34nkhkyswp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 08:53:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AB8isdO047833;
        Wed, 11 Nov 2020 08:53:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34p5g1eqnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Nov 2020 08:53:23 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AB8rC6C010401;
        Wed, 11 Nov 2020 08:53:19 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Nov 2020 00:53:11 -0800
Subject: Re: [RFC][PATCH 13/24] x86/pti: Extend PTI user mappings
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
References: <20201109144425.270789-1-alexandre.chartre@oracle.com>
 <20201109144425.270789-14-alexandre.chartre@oracle.com>
 <bb5b370b-5091-f3ca-9967-5a5d91287788@oracle.com>
 <CALCETrUcyHtoZOjkoivDfMZHo0Z-gum_eHP8ca4gPLcTLWu5Xg@mail.gmail.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <a12e3d8f-e0be-ee64-c8e5-6ccdab861cd1@oracle.com>
Date:   Wed, 11 Nov 2020 09:55:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUcyHtoZOjkoivDfMZHo0Z-gum_eHP8ca4gPLcTLWu5Xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110048
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/20 12:39 AM, Andy Lutomirski wrote:
>>
>> On 11/9/20 6:28 PM, Andy Lutomirski wrote:
>>> On Mon, Nov 9, 2020 at 3:22 AM Alexandre Chartre
>>> <alexandre.chartre@oracle.com> wrote:
>>>>
>>>> Extend PTI user mappings so that more kernel entry code can be executed
>>>> with the user page-table. To do so, we need to map syscall and interrupt
>>>> entry code,
>>>
>>> Probably fine.
>>>
>>>> per cpu offsets (__per_cpu_offset, which is used some in
>>>> entry code),
>>>
>>> This likely already leaks due to vulnerable CPUs leaking address space
>>> layout info.
>>
>> I forgot to update the comment, I am not mapping __per_cpu_offset anymore.
>>
>> However, if we do map __per_cpu_offset then we don't need to enforce the
>> ordering in paranoid_entry to switch CR3 before GS.
> 
> I'm okay with mapping __per_cpu_offset.
> 

Good. That way I can move the GS update back to assembly code (paranoid_entry/exit
will be mostly reduce to updating GS), and probably I won't need to disable
stack-protector.


>>>
>>>> the stack canary,
>>>
>>> That's going to be a very tough sell.
>>>
>>
>> I can get rid of this, but this will require to disable stack-protector for
>> any function that we can call while using the user page-table, like already
>> done in patch 21 (x86/entry: Disable stack-protector for IST entry C handlers).
>>
> 
> You could probably get away with using a different stack protector
> canary before and after the CR3 switch as long as you are careful to
> have the canary restored when you return from whatever function is
> involved.
> 

I was thinking about doing that. I will give it a try.

Thanks,

alex.

