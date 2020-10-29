Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3529EDAC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgJ2Ny2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgJ2Ny0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:54:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE961C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:54:25 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i1so2902024wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rYnSA5ZoiujykRNozsG5LomUFpo5IhTRaCiGcXzwirA=;
        b=bCUtkd4ezKe1U4qHyzh5AIdnEv13lbJdYO5x8qLZTolHIsEWg9asPfzA7oqkHPL67f
         vA0vO949iJAaJB9d+6z4l/5ghNYiuEUZELeDi10eJVYcDMFNFxYwpxWtI4AkL+YrBncE
         nJHRXabEyMETHE1also5c85D/kFDhN/+j1WWx3KGVVmjvyUk8ToK5ETOEeBiQYb3v2j/
         4Y66IPwQTWKGUEfF8Hp/u8e6j2JwwSFXx7X2jbQdGgDHgjLOuFFim4JhmwqutMLnIq79
         dNX9UbgQnWJGD1Rf6goJ72vwY0hWs41c7CN2p4QenczNDA3X14DzeNqIxQLauFAKBcu3
         BEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rYnSA5ZoiujykRNozsG5LomUFpo5IhTRaCiGcXzwirA=;
        b=W3csi9jRGrGb23ULgDx5PeSZYyWRJv0rpyQ2rPhWPwUgofApexoecLThnwfBzv48m4
         f0s/1IOdi+DUsmok/GHA5UUzsar0NIItphvIGU/q+Uh59+ag22vKBAXHIjKkbU635KBy
         iLd98snTfOpz+aACPoCTWTFIVkLMXIgBLbzzNQ4dk9gFo/OG7Wf6a9WKYlVVx0qqso3i
         X2HnRroYvIUxFit7R02bpj1GtTcDVB2c6mlgo4G2tPcg8YZt0zgLUmR71MeyGKgtWy0i
         aOG+6HvJdVrvG5QDVdio6EnInss8kL4PD2krmshE5XWmnDc/gR54xMLAqXXytdVI8Xxa
         az5A==
X-Gm-Message-State: AOAM530rXBp7UKNRg3o29J2zZ3pAw6zxSfrlIiQQmkmZQN+Ep2boac2J
        HiXJOAh8n+J5y1/G1KqPD7B3kw==
X-Google-Smtp-Source: ABdhPJyl8m3/11RhymK3V9IrjO73jUl15Nz+RctxKh87V9ezZJnGEDu0EQrvbROcFMnU49M5KbndVw==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr5550483wro.328.1603979664621;
        Thu, 29 Oct 2020 06:54:24 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id z11sm5484304wrr.66.2020.10.29.06.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 06:54:23 -0700 (PDT)
Subject: Re: [PATCH 2/4] arm64: hide more compat_vdso code
To:     Arnd Bergmann <arnd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20201026160342.3705327-1-arnd@kernel.org>
 <20201026160342.3705327-2-arnd@kernel.org>
 <20201026165543.GA42952@C02TD0UTHF1T.local>
 <CAK8P3a2W-BcRyxx7+JXr+MCBLSuLzLdEDzM8LMk5y1rjaEuXbw@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <9616a4d4-12d4-f7c2-dd9b-1502a0a7322a@arista.com>
Date:   Thu, 29 Oct 2020 13:54:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2W-BcRyxx7+JXr+MCBLSuLzLdEDzM8LMk5y1rjaEuXbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/20 1:35 PM, Arnd Bergmann wrote:
> On Mon, Oct 26, 2020 at 5:55 PM Mark Rutland <mark.rutland@arm.com> wrote:
>> On Mon, Oct 26, 2020 at 05:03:29PM +0100, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> When CONFIG_COMPAT_VDSO is disabled, we get a warning
>>> about a potential out-of-bounds access:
>>>
>>> arch/arm64/kernel/vdso.c: In function 'aarch32_vdso_mremap':
>>> arch/arm64/kernel/vdso.c:86:37: warning: array subscript 1 is above array bounds of 'struct vdso_abi_info[1]' [-Warray-bounds]
>>>    86 |  unsigned long vdso_size = vdso_info[abi].vdso_code_end -
>>>       |                            ~~~~~~~~~^~~~~
>>>
>>> This is all in dead code however that the compiler is unable to
>>> eliminate by itself.
>>>
>>> Change the array to individual local variables that can be
>>> dropped in dead code elimination to let the compiler understand
>>> this better.
>>>
>>> Fixes: 0cbc2659123e ("arm64: vdso32: Remove a bunch of #ifdef CONFIG_COMPAT_VDSO guards")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> This looks like a nice cleanup to me! I agree we don't need the array
>> here.
>>
>> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks!
> 
> I see the patch now conflicts with "mm: forbid splitting special mappings"
> in -mm, by Dmitry Safonov. I have rebased my patch on top, should
> I send it to Andrew for inclusion in -mm then?

Makes sense to me.
I plan to add some more patches on top that will make tracking of user
landing (on vdso/sigpage/etc) common between architectures in generic code.
So, I think it's probably good idea to keep it in one place, -mm tree
seems like a proper place for it.

Thanks,
          Dmitry
