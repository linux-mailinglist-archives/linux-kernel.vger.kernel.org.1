Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2F6295C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 12:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896358AbgJVKMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 06:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896284AbgJVKMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 06:12:30 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366E9C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 03:12:30 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z2so1560673lfr.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 03:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sYnH6aqIwTQitjCjG/9NQOBr5RVniOR4tlgCFK9V1uk=;
        b=Ky8oYdprKO2xoRNJlLlTQiV3N0tpxU4CVqLVPMC48m1Zyj9bC5WDIcOPZUci/12fJn
         ppSIzXAfoFaa7pm6qW1otMPV1wupW3GNxDcAizZdVf3B8/Kfs8EIrbtikK8tBPQGgzo9
         Sl9acr1aQKhjNR9vceckmJZNKR5trCNwblI1jlN5vsyhCa96C37s7T3jYR5LKel7zK0T
         qug6hRq32LYUOiT3IDcSgsoxafAEuMrmOFOdxhPJ+rwjXexFj1jxTwQkf1iARDYSrvj3
         frouoaK8xNlWT0slcMGB74tnokZbGPj1eXS2xs6MZMbU9EcpnNvXvIsBDjSBn/QOuwM1
         lgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sYnH6aqIwTQitjCjG/9NQOBr5RVniOR4tlgCFK9V1uk=;
        b=sYcBriMXdXJEhzWWEw8vdWWTl3FjkbkzHksAO+rlkOOvmGwemUYlTEftLx1KV6JcTF
         7FhEiNDmBZHYHTr+ON083fJ5JAyjbhADmiJXTgi0Zw0qrVPMQbaOLKG9TAthERA9yP2z
         o0zZ6TICAfNnROSXariTa0e5q/p0CRrmsgkinww5jvL10ny1OBo2Wjgy39UzZyett2NI
         e7VNH6NrtEVGSYKsqvXlAozvlO6+TyaGj5rDNe2KDkuuyDfqrxjFPZi8o9ZlaCasQpqW
         QJSCewDmVZ+eSAPBMAIUEHXiHKznoSV+B/GvtWBNKlkPVONFKkozsahz928N69DpLt63
         qC+w==
X-Gm-Message-State: AOAM531LowcKKcycFyz2NsEMK54xEjUahA9mfkwn0Q9E00UhYZoGGfeq
        0HaVtvG1U8qcxwkwjgAq7d8=
X-Google-Smtp-Source: ABdhPJzeRxfpYGJRB9oYjb7C0bbyjfB1wKhO0u6mo+GwjmGg1rq98Bf2sbdk3U+l8GFdchzr1xdObQ==
X-Received: by 2002:a19:80d5:: with SMTP id b204mr547967lfd.384.1603361548691;
        Thu, 22 Oct 2020 03:12:28 -0700 (PDT)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id x20sm229660ljj.139.2020.10.22.03.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 03:12:27 -0700 (PDT)
Subject: Re: [systemd-devel] BTI interaction between seccomp filters in
 systemd and glibc mprotect calls, causing service failures
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Lennart Poettering <mzxreary@0pointer.de>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        systemd-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, libc-alpha@sourceware.org,
        Dave Martin <dave.martin@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201022071812.GA324655@gardel-login>
 <87sga6snjn.fsf@oldenburg2.str.redhat.com>
 <511318fd-efde-f2fc-9159-9d16ac8d33a7@gmail.com>
 <20201022082912.GQ3819@arm.com> <20201022083823.GA324825@gardel-login>
 <20201022093104.GB1229@gaia>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <4e82e730-4e71-35fe-e46e-f032766dedeb@gmail.com>
Date:   Thu, 22 Oct 2020 13:12:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022093104.GB1229@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.2020 12.31, Catalin Marinas wrote:
> On Thu, Oct 22, 2020 at 10:38:23AM +0200, Lennart Poettering wrote:
>> On Do, 22.10.20 09:29, Szabolcs Nagy (szabolcs.nagy@arm.com) wrote:
>>>>> The dynamic loader has to process the LOAD segments to get to the ELF
>>>>> note that says to enable BTI.  Maybe we could do a first pass and load
>>>>> only the segments that cover notes.  But that requires lots of changes
>>>>> to generic code in the loader.
>>>>
>>>> What if the loader always enabled BTI for PROT_EXEC pages, but then when
>>>> discovering that this was a mistake, mprotect() the pages without BTI? Then
>>>> both BTI and MDWX would work and the penalty of not getting MDWX would fall
>>>> to non-BTI programs. What's the expected proportion of BTI enabled code vs.
>>>> disabled in the future, is it perhaps expected that a distro would enable
>>>> the flag globally so eventually only a few legacy programs might be
>>>> unprotected?
>>>
>>> i thought mprotect(PROT_EXEC) would get filtered
>>> with or without bti, is that not the case?
>>
>> We can adjust the filter in systemd to match any combination of
>> flags to allow and to deny.
> 
> Yes but Szabolcs' point to Topi was that if we can adjust the filters to
> allow mprotect(PROT_EXEC), why not allow mprotect(PROT_EXEC|PROT_BTI)
> instead? Anyway, I see the MDWX and BTI as complementary policies so
> ideally we shouldn't have to choose between one or the other. If we
> allow mprotect(PROT_EXEC), that would override MDWX and also disable
> BTI.

Allowing mprotect(PROT_EXEC|PROT_BTI) would mean that all you need to 
circumvent MDWX is to add PROT_BTI flag. I'd suggest getting the flags 
right at mmap() time or failing that, reverting the PROT_BTI for legacy 
programs later.

Could the kernel tell the loader of the BTI situation with auxiliary 
vectors? Then it would be easy for the loader to always use the best 
mmap() flags without ever needing to mprotect().

-Topi
