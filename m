Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924C2295C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 12:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896289AbgJVKEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 06:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896273AbgJVKEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 06:04:20 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD4BC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 03:04:20 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d24so1505356lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 03:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v+g60jSFAWmJk25t84LrgkacnZZF5EGyn0T0qZYVJPQ=;
        b=denJkyKo92QmJssuyfNHfRh0bkOUOm5JqGz3HF1V9AggK73d8uBn1SVUc6JwVPJT3t
         CZZH2hDr8ZvCnvN5OuDbmntXCPNXzvk9S9X0CIc0r3jl31ctji8I/Jnzw+Cjgombxodf
         pJ+LcpOpCw+4LSzfK7fIJbztKe2RblaEqbo6uG6Qil0PDVeAIo2/vyKdke/9/hOHob2R
         zdikt4Q9Rxzuw+JOmRY1Wvj//l5kpKiNlCk/sDoUMLkG+J2OSKzstDfkBdYN9xoiAxI8
         9j6/5ywhVoesc97aCeT5ocNG+WPTaZmjOxHhy0+4XEMwne8jJ7X6KQUlwHe0d4/R8uz8
         vBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v+g60jSFAWmJk25t84LrgkacnZZF5EGyn0T0qZYVJPQ=;
        b=IVRFpd9KE8yCrnEVfKA7LFOm7A1EKfySfeCCs+C5djW1esNsHTGaVvmsw0bNNFQ4hO
         L/Lp0UdAzuYwMh3oC0iRjc72GLOtG6Quy7qk4VcjVJyveqMn9gYnRoSnDEmPG5n41LB1
         fFlwl4hz+pP/qJhSer1u1zONYv8IR0krbjDS//PxWnu4OUXPhjxqPclbZZsSr3WQauJe
         odE4v19uBfJSDk2tlDS40yYA/kDfWlKIAYI+ymNGAzQyQFBFrsYDtQkEuWafSBrVsUcm
         3xfY5R3PuFCzxTdrBsEzLYr4klH60ehYjQzhOVcf0FhjWr8cKvZcgKNfhvktwp3QByBH
         Gx2A==
X-Gm-Message-State: AOAM531fW6WnNh8WxMIB5Mowp+UlebIzoBua+Kngp8Qgq7yP4/UhHta8
        9ICOj4Zxahg0Ch6GMSGXi/g=
X-Google-Smtp-Source: ABdhPJwH9XOdDe0YlZMRGx22HEpQlzpQeIUZpjxkbSUK3SepOq2QRD5zb2keQbFEDVMtjNYwhkZhhw==
X-Received: by 2002:a19:434f:: with SMTP id m15mr528494lfj.601.1603361058694;
        Thu, 22 Oct 2020 03:04:18 -0700 (PDT)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id m4sm227110ljg.137.2020.10.22.03.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 03:04:18 -0700 (PDT)
Subject: Re: [systemd-devel] BTI interaction between seccomp filters in
 systemd and glibc mprotect calls, causing service failures
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Mark Rutland <mark.rutland@arm.com>,
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
 <511318fd-efde-f2fc-9159-9d16ac8d33a7@gmail.com>
 <20201022082912.GQ3819@arm.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <55b44a39-ab19-363e-3703-9bf4e7d75f68@gmail.com>
Date:   Thu, 22 Oct 2020 13:03:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022082912.GQ3819@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.2020 11.29, Szabolcs Nagy wrote:
> The 10/22/2020 11:17, Topi Miettinen via Libc-alpha wrote:
>> On 22.10.2020 10.54, Florian Weimer wrote:
>>> * Lennart Poettering:
>>>> Did you see Topi's comments on the systemd issue?
>>>>
>>>> https://github.com/systemd/systemd/issues/17368#issuecomment-710485532
>>>>
>>>> I think I agree with this: it's a bit weird to alter the bits after
>>>> the fact. Can't glibc set up everything right from the begining? That
>>>> would keep both concepts working.
>>>
>>> The dynamic loader has to process the LOAD segments to get to the ELF
>>> note that says to enable BTI.  Maybe we could do a first pass and load
>>> only the segments that cover notes.  But that requires lots of changes
>>> to generic code in the loader.
>>
>> What if the loader always enabled BTI for PROT_EXEC pages, but then when
>> discovering that this was a mistake, mprotect() the pages without BTI? Then
>> both BTI and MDWX would work and the penalty of not getting MDWX would fall
>> to non-BTI programs. What's the expected proportion of BTI enabled code vs.
>> disabled in the future, is it perhaps expected that a distro would enable
>> the flag globally so eventually only a few legacy programs might be
>> unprotected?
> 
> i thought mprotect(PROT_EXEC) would get filtered
> with or without bti, is that not the case?

It would be filtered, but the idea is that with modern binaries this 
would not happen since the pages would be mapped with mmap(,, PROT_EXEC 
| PROT_BTI,,) which is OK for purposes MDWX. The loader would have to 
use mprotect(PROT_EXEC) to get rid of PROT_BTI only for the legacy binaries.

-Topi
