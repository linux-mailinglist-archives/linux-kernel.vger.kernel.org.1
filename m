Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5492695B3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgINTei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:34:38 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:60583 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgINTef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1600112074;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Fo/MPFaFCp1nlAEk2N92wAt0BIun2jTPvkus0uWpA6M=;
  b=TyuBqa+R41s+9O4IC30exXuhDYK4npiqIOKst3sBqxNmaFmgaxVdaDUd
   NbJCkVPu/xAuICP6wLiPwsCbxYmIw8dPKzY4BTBaMsCj9YFPjnS94gQfy
   4rCFEZTEdUdtCvQ63lEmGybT8VMg8uEtOQX27nuNuv9qVhwKDwQY1RKpI
   k=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: uKJG1RCtT3r357QhwXxin9mzH969Edlqkv3H9SUUgABvMuWhdsZGgtqEdAyj0K4eoMjoBp82Wn
 kDnjbfsHMgjedlzChxG2DigxLndPY78nmFY+fK8LapItumgX4naFUmij+xXb4PLKW3qTs6Tu9C
 Kw7y30qyvCXlsINb5IvkK0pG+6D7eABHCDKk85Tv1yTQrVS1xwjayQV/+Is4vvm6VBPH4QE3sM
 Fmx5udtqThoWkXGAdp2xhZJAFYCZ1ERyXCY5461tABjUghhvEk1J5zaM4Sj0WmkmfiSdAU7n4E
 IJM=
X-SBRS: 2.7
X-MesageID: 27642265
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,427,1592884800"; 
   d="scan'208";a="27642265"
Subject: Re: [PATCH v3] x86/uaccess: Use pointer masking to limit uaccess
 speculation
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>
CC:     Dan Williams <dan.j.williams@intel.com>, X86 ML <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com>
 <20200914175604.GF680@zn.tnic>
 <CAPcyv4hqxs1zuXb5jkA-6Fm72Vu0ZDCfqeWJKSePM+zFyY9kzg@mail.gmail.com>
 <20200914192156.GG680@zn.tnic> <20200914192725.cqja3icshjemvcxw@treble>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <3619a590-6f1c-d6b6-f4e1-69239489c165@citrix.com>
Date:   Mon, 14 Sep 2020 20:34:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914192725.cqja3icshjemvcxw@treble>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 FTLPEX02CL05.citrite.net (10.13.108.178)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2020 20:27, Josh Poimboeuf wrote:
> On Mon, Sep 14, 2020 at 09:21:56PM +0200, Borislav Petkov wrote:
>> On Mon, Sep 14, 2020 at 11:48:55AM -0700, Dan Williams wrote:
>>>> Err, stupid question: can this macro then be folded into access_ok() so
>>>> that you don't have to touch so many places and the check can happen
>>>> automatically?
>>> I think that ends up with more changes because it changes the flow of
>>> access_ok() from returning a boolean to returning a modified user
>>> address that can be used in the speculative path.
>> I mean something like the totally untested, only to show intent hunk
>> below? (It is late here so I could very well be missing an aspect):
>>
>> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
>> index 2bffba2a1b23..c94e1589682c 100644
>> --- a/arch/x86/include/asm/uaccess.h
>> +++ b/arch/x86/include/asm/uaccess.h
>> @@ -7,6 +7,7 @@
>>  #include <linux/compiler.h>
>>  #include <linux/kasan-checks.h>
>>  #include <linux/string.h>
>> +#include <linux/nospec.h>
>>  #include <asm/asm.h>
>>  #include <asm/page.h>
>>  #include <asm/smap.h>
>> @@ -92,8 +93,15 @@ static inline bool pagefault_disabled(void);
>>   */
>>  #define access_ok(addr, size)					\
>>  ({									\
>> +	bool range;							\
>> +	typeof(addr) a = addr, b;					\
>> +									\
>>  	WARN_ON_IN_IRQ();						\
>> -	likely(!__range_not_ok(addr, size, user_addr_max()));		\
>> +									\
>> +	range = __range_not_ok(addr, size, user_addr_max());		\
>> +	b = (typeof(addr)) array_index_nospec((__force unsigned long)addr, TASK_SIZE_MAX); \
>> +									\
>> +	likely(!range && a == b);					\
> That's not going to work because 'a == b' can (and will) be
> misspeculated.

Correct.

array_index_nospec() only works (safety wise) when there are no
conditional jumps between it and the memory access it is protecting.

Otherwise, an attacker can just take control of that later jump and skip
the check that way.

~Andrew
