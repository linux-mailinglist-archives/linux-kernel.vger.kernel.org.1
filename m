Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFC62B9BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgKST4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 14:56:03 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59006 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgKST4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 14:56:02 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJJmUIO193529;
        Thu, 19 Nov 2020 19:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=902LxGdnbKaWgQKGoNpToeDkUs3cFDXkaK0CoiRQs8w=;
 b=r4ZdcOGdVrNwzLLrb9Jv378TBcaDSNik4r3sZDbz52ngTkd8azNp61Y8mWYEVKP0tIl2
 5+mmiM1iqm6rduJguNiJuIzNXvnWxQDK/3Q+T9akawVYausWc4VVhe5ZYvhNExySOhhG
 codhhmmLbF3nvs5ZXZSTqrFgnP3cOLcd1DCDs+sRHRwSRwyxMG6uoilbqrHoE4syM40x
 g6lxXwBYMGviHZ4tB81ok1mi9RzGafwVuTUfQHx7dq+PhiS//Q2bv8atgzS8td57FRza
 eeESqXLtxZNss7A1pbml3xoxwGs6KXCWKzPnPnN5bP3BaBoXHumCxi4XaQYMiiaxD0qb aw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34t4rb7gn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 19:53:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJJnc3x153232;
        Thu, 19 Nov 2020 19:53:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34ts0u7aku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 19:53:17 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AJJrDd3013486;
        Thu, 19 Nov 2020 19:53:13 GMT
Received: from linux.home (/92.157.89.78)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Nov 2020 11:53:13 -0800
Subject: Re: [RFC][PATCH v2 12/21] x86/pti: Use PTI stack instead of
 trampoline stack
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
 <87ft55p3gp.fsf@nanos.tec.linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <a9aa4887-02ee-0e9a-a37e-63e9cb0ff27f@oracle.com>
Date:   Thu, 19 Nov 2020 20:55:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87ft55p3gp.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190136
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/19/20 8:10 PM, Thomas Gleixner wrote:
> On Mon, Nov 16 2020 at 19:10, Alexandre Chartre wrote:
>> On 11/16/20 5:57 PM, Andy Lutomirski wrote:
>>> On Mon, Nov 16, 2020 at 6:47 AM Alexandre Chartre
>>> <alexandre.chartre@oracle.com> wrote:
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
> 
> Coming late, but this does not make any sense to me.
> 
> Unless you map most of the kernel into the user page-table sleeping with
> the user page-table _cannot_ work. And if you do that you broke KPTI.
> 
> You can neither pick arbitrary points in the C code of an exception
> handler to switch to the kernel mapping unless you mapped everything
> which might be touched before that into user space.
> 
> How is that supposed to work?
> 

Sorry I mixed up a few thing; I got confused with my own code which is not a
good sign...

It's not sleeping with the user page-table which, as you mentioned, doesn't
make sense, it's sleeping with the kernel page-table but with the PTI stack.

Basically, it is:
   - entering C code with (user page-table, PTI stack);
   - then it switches to the kernel page-table so we have (kernel page-table, PTI stack);
   - and then it switches to the kernel stack so we have (kernel page-table, kernel stack).

As this is all C code, some of which is executed with the PTI stack, we need the PTI stack
to be per-task so that the stack is preserved, in case that C code does a sleep/schedule
(no matter if this happens when using the PTI stack or the kernel stack).

alex.
