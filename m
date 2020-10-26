Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83DB299278
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786033AbgJZQcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:32:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45178 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786024AbgJZQcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:32:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id a4so10876035lji.12;
        Mon, 26 Oct 2020 09:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=81sFbAVwzGBYdqNxSKasnwihrmLk5qFx2xW7a2yOVFA=;
        b=ilyK4nriJpTU+ZsR5TzVNUPI2EICBAV+EtzdIfm0c8gnj9uEXsmcIlrH4esm52Sof5
         Z9W3RF1ohEzkLaXmgew/evfyvbKalDRv4wGUlakWh1vwJi+Holvp1iFQavUz7IIINteZ
         DXfWJqJcuIjSWoOYQlpTF8qMEVNtDnTAy14ZhUAoO6a9psISAvTf4eiGo88ojEk0OVOt
         DoluxxDfBapo4lA0C3ZHtuZ8p4Qzmm8/zACDjcDNBsCtA/MAYCoro7MwWTB4NW5u7X6u
         DympMB1G1hMAQePPLbaLhpIDiugGlLowk9LLdoo0k7DAhyw+bMfwmtOEMfW0IrE3liO8
         VgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=81sFbAVwzGBYdqNxSKasnwihrmLk5qFx2xW7a2yOVFA=;
        b=aBD6BVbE9GaYshfcgxadgaPU+aGfpaOayN3P62A/cJUaWvnj7KHw/aYtW1wIKX8c1W
         mWMRFNjPdLsO/dzpTrm2h6X276k+rCHXcH174gazTUKJ3lGcIAzhDOg/bEvBrw1Zyj6K
         w8aNrK7mXXxSqT43lC2k4wqghadFXp4Pnnqhr9iLEdcJC2H8jhRY8qgvSue3ktmkHHFF
         ulnNAWMPJ8cTgxeMf/pztIwZhBsCKrnCjie6U+lFWYAAm2ycF41s5bGSJQ4fKlEqaNIg
         iACewGugwkBLAyyH4OYowMKeoEcInH/DueTXhPGJE2cxCQRlrTmY6fJb4nExnvWx0E4z
         V3RA==
X-Gm-Message-State: AOAM530qw7zP4PUjFwCTG0vewLcj1tXKFBFIGxilasEniAS34LyiWIrD
        NelPotsLWrdJKf9AAhihR0tVWqgoPeInSQ==
X-Google-Smtp-Source: ABdhPJyBBZepygrfLeS9IiJiGCwiL99FGQQQhPP2SALgITxO/hNm/8c7G2c/C1WBoQBEiojldvEEsA==
X-Received: by 2002:a2e:2ac6:: with SMTP id q189mr5924430ljq.269.1603729930410;
        Mon, 26 Oct 2020 09:32:10 -0700 (PDT)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id q123sm1264618ljq.108.2020.10.26.09.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 09:32:09 -0700 (PDT)
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, libc-alpha@sourceware.org,
        systemd-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dave Martin <dave.martin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201022075447.GO3819@arm.com>
 <78464155-f459-773f-d0ee-c5bdbeb39e5d@gmail.com>
 <202010221256.A4F95FD11@keescook> <20201023090232.GA25736@gaia>
 <cf655c11-d854-281a-17ae-262ddf0aaa08@gmail.com> <20201026145245.GD3117@gaia>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <d7f45447-0f71-2855-98ac-6e873291ed09@gmail.com>
Date:   Mon, 26 Oct 2020 18:31:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201026145245.GD3117@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.2020 16.52, Catalin Marinas wrote:
> On Sat, Oct 24, 2020 at 02:01:30PM +0300, Topi Miettinen wrote:
>> On 23.10.2020 12.02, Catalin Marinas wrote:
>>> On Thu, Oct 22, 2020 at 01:02:18PM -0700, Kees Cook wrote:
>>>> Regardless, it makes sense to me to have the kernel load the executable
>>>> itself with BTI enabled by default. I prefer gaining Catalin's suggested
>>>> patch[2]. :)
>>> [...]
>>>> [2] https://lore.kernel.org/linux-arm-kernel/20201022093104.GB1229@gaia/
>>>
>>> I think I first heard the idea at Mark R ;).
>>>
>>> It still needs glibc changes to avoid the mprotect(), or at least ignore
>>> the error. Since this is an ABI change and we don't know which kernels
>>> would have it backported, maybe better to still issue the mprotect() but
>>> ignore the failure.
>>
>> What about kernel adding an auxiliary vector as a flag to indicate that BTI
>> is supported and recommended by the kernel? Then dynamic loader could use
>> that to detect that a) the main executable is BTI protected and there's no
>> need to mprotect() it and b) PROT_BTI flag should be added to all PROT_EXEC
>> pages.
> 
> We could add a bit to AT_FLAGS, it's always been 0 for Linux.

Great!

>> In absence of the vector, the dynamic loader might choose to skip doing
>> PROT_BTI at all (since the main executable isn't protected anyway either, or
>> maybe even the kernel is up-to-date but it knows that it's not recommended
>> for some reason, or maybe the kernel is so ancient that it doesn't know
>> about BTI). Optionally it could still read the flag from ELF later (for
>> compatibility with old kernels) and then do the mprotect() dance, which may
>> trip seccomp filters, possibly fatally.
> 
> I think the safest is for the dynamic loader to issue an mprotect() and
> ignore the EPERM error. Not all user deployments have this seccomp
> filter, so they can still benefit, and user can't tell whether the
> kernel change has been backported.

But the seccomp filter can be set to kill the process, so that's 
definitely not the safest way. I think safest is that when the AT_FLAGS 
bit is seen, ld.so doesn't do any mprotect() calls but instead when 
mapping the segments, mmap() flags are adjusted to include PROT_BTI, so 
mprotect() calls are not necessary. If there's no seccomp filter, 
there's no disadvantage for avoiding the useless mprotect() calls.

I'd expect the backported kernel change to include both aux vector and 
also using PROT_BTI for the main executable. Then the logic would work 
with backported kernels as well.

If there's no aux vector, all bets are off. The kernel could be old and 
unpatched, even so old that PROT_BTI is not known. Perhaps also in the 
future there may be new technologies which have replaced BTI and the 
kernel could want a previous generation ld.so not to try to use BTI, so 
this could be also indicated with the lack of aux vector. The dynamic 
loader could still attempt to mprotect() the pages, but that could be 
fatal. Getting to the point where the error can be ignored means that 
there's no seccomp filter, at least none set to kill. Perhaps the pain 
is only temporary, new or patched kernels should eventually replace the 
old versions.

> Now, if the dynamic loader silently ignores the mprotect() failure on
> the main executable, is there much value in exposing a flag in the aux
> vectors? It saves a few (one?) mprotect() calls but I don't think it
> matters much. Anyway, I don't mind the flag.

Saving a few system calls is indeed not an issue, but not being able to 
use MDWX and PROT_BTI simultaneously was the original problem (service 
failures).

-Topi
