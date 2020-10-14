Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F71228E73C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390609AbgJNT0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:26:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45968 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389668AbgJNT0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:26:31 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EJOXQj127936;
        Wed, 14 Oct 2020 19:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=RN6CNB803VwFAHMIUpkW+4jVwqpSiOQaTn16Ydku+2E=;
 b=K5dCEzg/ErgV9Q7z9GcJvuIO+1ZUnPF46xKbcnbzTlOydKfY990wDi6V5Lpi7X39El/u
 4hOTxORZFQBGHgu94eEzZ11dJlmuik8D5RYofjwiwWLnjmvYeVVl9BNOpq7G9he24kyE
 l2gv1qOBTVr3ji6yiRPVYSIZgXkPwCMwiRaX1r7ctaC24CIFVajmqj4m5vkGSOBhAmS6
 ezLXUYXZ9xsk/iAGeUz2W3kN99rhLw50Y/uv5aQb5zbp2lLByrDN+cFoVKq6oTjtX7qO
 /K6dn+NW0ZV1k6Oz99PQZopMkODEh9wEMQy5jiqPPJ1lWwqYIc1t8YctwE2OQo/LPswV Aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 343pak018j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 19:26:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EJEbaW114125;
        Wed, 14 Oct 2020 19:24:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 343pvy9e3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 19:24:08 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09EJNxrY029094;
        Wed, 14 Oct 2020 19:24:00 GMT
Received: from [10.159.149.68] (/10.159.149.68)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 12:23:59 -0700
Subject: Re: [PATCH 7/8] x86/cpu/intel: enable X86_FEATURE_NT_GOOD on Intel
 Broadwellx
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kirill@shutemov.name, mhocko@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20201014083300.19077-1-ankur.a.arora@oracle.com>
 <20201014083300.19077-8-ankur.a.arora@oracle.com>
 <20201014153127.GB1424414@gmail.com>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <c0b81c05-8703-c12f-8ed6-12342d0b29aa@oracle.com>
Date:   Wed, 14 Oct 2020 12:23:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201014153127.GB1424414@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-14 8:31 a.m., Ingo Molnar wrote:
> 
> * Ankur Arora <ankur.a.arora@oracle.com> wrote:
> 
>> System:           Oracle X6-2
>> CPU:              2 nodes * 10 cores/node * 2 threads/core
>> 		  Intel Xeon E5-2630 v4 (Broadwellx, 6:79:1)
>> Memory:           256 GB evenly split between nodes
>> Microcode:        0xb00002e
>> scaling_governor: performance
>> L3 size:          25MB
>> intel_pstate/no_turbo: 1
>>
>> Performance comparison of 'perf bench mem memset -l 1' for x86-64-stosb
>> (X86_FEATURE_ERMS) and x86-64-movnt (X86_FEATURE_NT_GOOD):
>>
>>                x86-64-stosb (5 runs)     x86-64-movnt (5 runs)       speedup
>>                -----------------------   -----------------------     -------
>>       size       BW        (   pstdev)          BW   (   pstdev)
>>
>>       16MB      17.35 GB/s ( +- 9.27%)    11.83 GB/s ( +- 0.19%)     -31.81%
>>      128MB       5.31 GB/s ( +- 0.13%)    11.72 GB/s ( +- 0.44%)    +121.84%
>>     1024MB       5.42 GB/s ( +- 0.13%)    11.78 GB/s ( +- 0.03%)    +117.34%
>>     4096MB       5.41 GB/s ( +- 0.41%)    11.76 GB/s ( +- 0.07%)    +117.37%
> 
>> +	if (c->x86 == 6 && c->x86_model == INTEL_FAM6_BROADWELL_X)
>> +		set_cpu_cap(c, X86_FEATURE_NT_GOOD);
> 
> So while I agree with how you've done careful measurements to isolate bad
> microarchitectures where non-temporal stores are slow, I do think this
> approach of opt-in doesn't scale and is hard to maintain.
> 
> Instead I'd suggest enabling this by default everywhere, and creating a
> X86_FEATURE_NT_BAD quirk table for the bad microarchitectures.
Okay, some kind of quirk table is a great idea. Also means that there's a
single place for keeping this rather than it being scattered all over in
the code.

That also simplifies my handling of features like X86_FEATURE_CLZERO.
I was concerned that if you squint a bit, it seems to be an alias to
X86_FEATURE_NT_GOOD and that seemed ugly.

> 
> This means that with new microarchitectures we'd get automatic enablement,
> and hopefully chip testing would identify cases where performance isn't as
> good.
Makes sense to me. A first class citizen, as it were...

Thanks for reviewing btw.

Ankur

> 
> I.e. the 'trust but verify' method.


> 
> Thanks,
> 
> 	Ingo
> 
