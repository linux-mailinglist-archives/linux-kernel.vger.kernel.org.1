Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE09F2959FD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894809AbgJVIRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894673AbgJVIRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:17:39 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5402AC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 01:17:39 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b1so1125678lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 01:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8HYVfJFH+cmeus6VJeMKUXXnaDsK6MzsFkED7ZSnMuM=;
        b=lo1gjkqPQq/3i6U4FJ0Ro4myZDcbR+atFTQwMG5g8ALJulSqy0fO4Z+1pIH0jHVGL4
         Ql/X1AJpnZs6z1fTSn6a5qgG0nNMxOV6MzXR/EEolZmLZa1NoBOTeh/0kiuD9YoEa4Vv
         hmk7io9opZfIapHfa8wlfROEIqpr6qwwjJNx0qtTeITK8kDg2ixjuZJ+vpQ5oKgpfyNR
         94ss/pu34Pvn+rHzaERpFpUp86NeswuianA34kcK+0/34JVyzKmw8oVIFCpS8Mb/yHEn
         Tnzdjb7I0l8m9wehOU5U1Vfe3peSgeUOOxEarCoovs9N0kh+YkL6iI2N5h5AdFpoo88O
         VwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8HYVfJFH+cmeus6VJeMKUXXnaDsK6MzsFkED7ZSnMuM=;
        b=YWyaxaNal6fyrWpTnwpkdkkWp15mES3UkbEHgXxRFGIZ3t2ckix3mtItxHwLYma/w7
         P6KnYZkO0kVni6dSfixy9ExIB0M8i2J+LIBsAVNISJhETPguUeD/ydUeXWqXr2WBUeUY
         SQ7eaqq8d79S4sHjAbaBhFxA0QAP+sprqCVSgN/57u85Qycs1FiA0AfmIDq2awIBcw9H
         g5hbYze83eevQex9kRTWIf1HdW+Fykc72+F4ytkQ6apj4UTAhkWTaexVwm7BR9jmXCW9
         F2lWeuNDQ9+87qiMa1gj2s+VlmrU1iBYRdRcMUVIY92cQt+KzmnepyscAEMFMcCpzCse
         2avA==
X-Gm-Message-State: AOAM532+igoIMq3G8caCe3ep6l0+M5k/juSjSkRoELM6F0C3NrzdeLiT
        pWseIJB8Yn5uJFoog9HK5Ec=
X-Google-Smtp-Source: ABdhPJwWZL3I0YCdmzYXRbsvsREOh3P1rTMxFf9qvQvDcdbABeRyQT7+/UgfusPG41cJSHDVowERSQ==
X-Received: by 2002:ac2:521a:: with SMTP id a26mr422161lfl.10.1603354657804;
        Thu, 22 Oct 2020 01:17:37 -0700 (PDT)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id r5sm182350ljm.77.2020.10.22.01.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 01:17:37 -0700 (PDT)
Subject: Re: [systemd-devel] BTI interaction between seccomp filters in
 systemd and glibc mprotect calls, causing service failures
To:     Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        systemd-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, libc-alpha@sourceware.org,
        Dave Martin <dave.martin@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201022071812.GA324655@gardel-login>
 <87sga6snjn.fsf@oldenburg2.str.redhat.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <511318fd-efde-f2fc-9159-9d16ac8d33a7@gmail.com>
Date:   Thu, 22 Oct 2020 11:17:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87sga6snjn.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.2020 10.54, Florian Weimer wrote:
> * Lennart Poettering:
> 
>> On Mi, 21.10.20 22:44, Jeremy Linton (jeremy.linton@arm.com) wrote:
>>
>>> Hi,
>>>
>>> There is a problem with glibc+systemd on BTI enabled systems. Systemd
>>> has a service flag "MemoryDenyWriteExecute" which uses seccomp to deny
>>> PROT_EXEC changes. Glibc enables BTI only on segments which are marked as
>>> being BTI compatible by calling mprotect PROT_EXEC|PROT_BTI. That call is
>>> caught by the seccomp filter, resulting in service failures.
>>>
>>> So, at the moment one has to pick either denying PROT_EXEC changes, or BTI.
>>> This is obviously not desirable.
>>>
>>> Various changes have been suggested, replacing the mprotect with mmap calls
>>> having PROT_BTI set on the original mapping, re-mmapping the segments,
>>> implying PROT_EXEC on mprotect PROT_BTI calls when VM_EXEC is already set,
>>> and various modification to seccomp to allow particular mprotect cases to
>>> bypass the filters. In each case there seems to be an undesirable attribute
>>> to the solution.
>>>
>>> So, whats the best solution?
>>
>> Did you see Topi's comments on the systemd issue?
>>
>> https://github.com/systemd/systemd/issues/17368#issuecomment-710485532
>>
>> I think I agree with this: it's a bit weird to alter the bits after
>> the fact. Can't glibc set up everything right from the begining? That
>> would keep both concepts working.
> 
> The dynamic loader has to process the LOAD segments to get to the ELF
> note that says to enable BTI.  Maybe we could do a first pass and load
> only the segments that cover notes.  But that requires lots of changes
> to generic code in the loader.

What if the loader always enabled BTI for PROT_EXEC pages, but then when 
discovering that this was a mistake, mprotect() the pages without BTI? 
Then both BTI and MDWX would work and the penalty of not getting MDWX 
would fall to non-BTI programs. What's the expected proportion of BTI 
enabled code vs. disabled in the future, is it perhaps expected that a 
distro would enable the flag globally so eventually only a few legacy 
programs might be unprotected?

-Topi
