Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1662992A2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786234AbgJZQkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:40:21 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38597 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1741277AbgJZQkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:40:21 -0400
Received: by mail-lf1-f67.google.com with SMTP id c141so12916429lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 09:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bYYpq/ODtlAp6N9v/jOmvwi4a5DwPQlK76zjEaH5y0U=;
        b=hmCYvw9TPflPd9H/DK+zYCiLVpY5wiSnYliiGK03r7yuumwzjDfiWUfaETFJkuFXlL
         QHuf3ENiQc9ybhv0U9lUsM06Seadp7EyAGOaVTxST1ou+WDqigqW997mKZ+cvV1uKUPP
         e9e/u9S4WZl/5w277vCvBfQHhABwox7LdWIN5koZP7tYuaA5zLWQN9uidAWWVvoLUJYW
         +w54kOvfmg0XpZYA3gMbNkug0gaWI0CMGdRGtc4zxGxSP8+d6YiFb39REgpsudDcnjBd
         Ju4exspOqQOM1aJ+gMqmHnyYonF/xDUYbq0piU/yNKW0E67Amo6MdYhnN7/PnKmB9mQG
         WRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bYYpq/ODtlAp6N9v/jOmvwi4a5DwPQlK76zjEaH5y0U=;
        b=R6RbDX9Qqpqir7krevRZECCX83z+vv9zMcaGlfFFIBUIf7azWqzx9BV8hn09wfBdZ/
         DzkQqQn6c1q4bb0LLapp7I5cQHFmqIIxPdEZl5CaoEPGrjRsjwyf7frSIwNp0qK2YJD2
         1SkzEbvnPMuMNWCzNu9mgb9+GxjsolWFqz7j0c+E/ljpqAPkE7FDANrmqJfTlHK0/9c/
         Oh11PN5GgOtLJDDH3G6Q19MSLbvc87XvYSyl0CwrlkhlQQ5T+pFxzc98kO67zZzPnFDF
         gkXwECex9zcVr7AZoG10ojbe/uBRZ+ScHvdrB6c0yku+yPi+i/3IAf/tixifFNY25gU5
         V0nQ==
X-Gm-Message-State: AOAM530UHQ9vOdo9XM8XyNzzKKDeFboaiJLEvNBetTCnTAZfThGuRbEe
        sRtMabFlbBTnySOHy5aBqwA=
X-Google-Smtp-Source: ABdhPJxEWYhWIhaW1xu9iLYys/ET2q6xrt2OTX3z8cDhceYtdfps/1yk+gQ6n16gAaYymVA4Q5lPRg==
X-Received: by 2002:a19:c3cd:: with SMTP id t196mr4934402lff.501.1603730418621;
        Mon, 26 Oct 2020 09:40:18 -0700 (PDT)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id m22sm1091484lfq.12.2020.10.26.09.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 09:40:17 -0700 (PDT)
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
To:     Dave Martin <Dave.Martin@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, libc-alpha@sourceware.org,
        systemd-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201026162410.GB27285@arm.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <ed3407a9-8479-edf7-23eb-5354e77d2a58@gmail.com>
Date:   Mon, 26 Oct 2020 18:39:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201026162410.GB27285@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.2020 18.24, Dave Martin wrote:
> On Wed, Oct 21, 2020 at 10:44:46PM -0500, Jeremy Linton via Libc-alpha wrote:
>> Hi,
>>
>> There is a problem with glibc+systemd on BTI enabled systems. Systemd
>> has a service flag "MemoryDenyWriteExecute" which uses seccomp to deny
>> PROT_EXEC changes. Glibc enables BTI only on segments which are marked as
>> being BTI compatible by calling mprotect PROT_EXEC|PROT_BTI. That call is
>> caught by the seccomp filter, resulting in service failures.
>>
>> So, at the moment one has to pick either denying PROT_EXEC changes, or BTI.
>> This is obviously not desirable.
>>
>> Various changes have been suggested, replacing the mprotect with mmap calls
>> having PROT_BTI set on the original mapping, re-mmapping the segments,
>> implying PROT_EXEC on mprotect PROT_BTI calls when VM_EXEC is already set,
>> and various modification to seccomp to allow particular mprotect cases to
>> bypass the filters. In each case there seems to be an undesirable attribute
>> to the solution.
>>
>> So, whats the best solution?
> 
> Unrolling this discussion a bit, this problem comes from a few sources:
> 
> 1) systemd is trying to implement a policy that doesn't fit SECCOMP
> syscall filtering very well.
> 
> 2) The program is trying to do something not expressible through the
> syscall interface: really the intent is to set PROT_BTI on the page,
> with no intent to set PROT_EXEC on any page that didn't already have it
> set.
> 
> 
> This limitation of mprotect() was known when I originally added PROT_BTI,
> but at that time we weren't aware of a clear use case that would fail.
> 
> 
> Would it now help to add something like:
> 
> int mchangeprot(void *addr, size_t len, int old_flags, int new_flags)
> {
> 	int ret = -EINVAL;
> 	mmap_write_lock(current->mm);
> 	if (all vmas in [addr .. addr + len) have
> 			their mprotect flags set to old_flags) {
> 
> 		ret = mprotect(addr, len, new_flags);
> 	}
> 	
> 	mmap_write_unlock(current->mm);
> 	return ret;
> }
> 
> 
> libc would now be able to do
> 
> 	mchangeprot(addr, len, PROT_EXEC | PROT_READ,
> 		PROT_EXEC | PROT_READ | PROT_BTI);
> 
> while systemd's MDWX filter would reject the call if
> 
> 	(new_flags & PROT_EXEC) &&
> 		(!(old_flags & PROT_EXEC) || (new_flags & PROT_WRITE)
> 
> 
> 
> This won't magically fix current code, but something along these lines
> might be better going forward.
> 
> 
> Thoughts?

Looks good to me.

-Topi

