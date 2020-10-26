Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2609A2999C8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 23:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394606AbgJZWjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 18:39:49 -0400
Received: from foss.arm.com ([217.140.110.172]:54016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730294AbgJZWjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 18:39:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EB0C30E;
        Mon, 26 Oct 2020 15:39:43 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD7DE3F68F;
        Mon, 26 Oct 2020 15:39:42 -0700 (PDT)
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
To:     Dave Martin <Dave.Martin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        systemd-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, toiwoton@gmail.com,
        libc-alpha@sourceware.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201026162410.GB27285@arm.com> <20201026165755.GV3819@arm.com>
 <20201026175230.GC27285@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <45c64b49-a38b-4b0c-d9cf-6c586dacbcc9@arm.com>
Date:   Mon, 26 Oct 2020 17:39:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026175230.GC27285@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/26/20 12:52 PM, Dave Martin wrote:
> On Mon, Oct 26, 2020 at 04:57:55PM +0000, Szabolcs Nagy via Libc-alpha wrote:
>> The 10/26/2020 16:24, Dave Martin via Libc-alpha wrote:
>>> Unrolling this discussion a bit, this problem comes from a few sources:
>>>
>>> 1) systemd is trying to implement a policy that doesn't fit SECCOMP
>>> syscall filtering very well.
>>>
>>> 2) The program is trying to do something not expressible through the
>>> syscall interface: really the intent is to set PROT_BTI on the page,
>>> with no intent to set PROT_EXEC on any page that didn't already have it
>>> set.
>>>
>>>
>>> This limitation of mprotect() was known when I originally added PROT_BTI,
>>> but at that time we weren't aware of a clear use case that would fail.
>>>
>>>
>>> Would it now help to add something like:
>>>
>>> int mchangeprot(void *addr, size_t len, int old_flags, int new_flags)
>>> {
>>> 	int ret = -EINVAL;
>>> 	mmap_write_lock(current->mm);
>>> 	if (all vmas in [addr .. addr + len) have
>>> 			their mprotect flags set to old_flags) {
>>>
>>> 		ret = mprotect(addr, len, new_flags);
>>> 	}
>>> 	
>>> 	mmap_write_unlock(current->mm);
>>> 	return ret;
>>> }
>>
>> if more prot flags are introduced then the exact
>> match for old_flags may be restrictive and currently
>> there is no way to query these flags to figure out
>> how to toggle one prot flag in a future proof way,
>> so i don't think this solves the issue completely.
> 
> Ack -- I illustrated this model because it makes the seccomp filter's
> job easy, but it does have limitations.
> 
>> i think we might need a new api, given that aarch64
>> now has PROT_BTI and PROT_MTE while existing code
>> expects RWX only, but i don't know what api is best.
> 
> An alternative option would be a call that sets / clears chosen
> flags and leaves others unchanged.

I tend to favor a set/clear API, but that could also just be done by 
creating a new PROT_BTI_IF_X which enables BTI for areas already set to 
_EXEC. That goes right by the seccomp filters too, and actually is 
closer to what glibc wants to do anyway.


> 
> The trouble with that is that the MDWX policy then becomes hard to
> implement again.
> 
> 
> But policies might be best set via another route, such as a prctl,
> rather than being implemented completely in a seccomp filter.
> 
> Cheers
> ---Dave
> 

