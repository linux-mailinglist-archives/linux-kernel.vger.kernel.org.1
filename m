Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AB32FE79D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbhAUK32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:29:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49340 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729232AbhAUK2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611224785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ioXqDDiFH1FLFozZBQ+HRIcOlQIXWLS3JcruiTjdisI=;
        b=B8qahuPcFsItxiAoc0BojRGvpNK8KZaxW1SRhPeED+uZjcqOl1q6WBRoqXWESiojl0lN6C
        KHDWBHEKNHu/5vU+ui7GidA3j00p2raXaLgIIylAeQnZPryVwovJwX2TiZDbMWacePUG8K
        TB25+oTBfFryD58kggBVXuMIzldlfw8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-dm33LaqPPA2tgoaLyyCBPQ-1; Thu, 21 Jan 2021 05:26:23 -0500
X-MC-Unique: dm33LaqPPA2tgoaLyyCBPQ-1
Received: by mail-wr1-f69.google.com with SMTP id o17so737295wra.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ioXqDDiFH1FLFozZBQ+HRIcOlQIXWLS3JcruiTjdisI=;
        b=IuSKKOHy2vQsLIwoB0ivWa511Oo35H1FPuHyNA3SHioXlfpPMzaxZ1HkaYK/c52uXD
         UTM74K6eA1dZM3yMzkM5zprPbhZ1HFjUbnlzaWq5MLQyW73FghvALqiMAwsafdVFZWy1
         ZohOXWjuebxqT5aUZoQhtQBMAjLphbJwpvbBBQRpyVBHmE//QTRIz+5BwhbOidr/aVUE
         q652dNFl8c4RVnj4JGdVVWL9oLAK/M8pxVu6grehP797hFtnKgWhDIjmSqh1gX/wvCeP
         ioFATrELX0ZAMPiNZW4wcQ1pZx78K6kmosMtUfgo9uYkWA+wYPaa5ynxLyGCndebU63u
         nXUg==
X-Gm-Message-State: AOAM532Oiw5i1nC4HR4ENvHmYciFbUxO6btN/PvgnQG2qNdCzNgA61sV
        nomQkz5EDSESVOTyjlZ3EoNWX9Xp+TBsL1YlG2wewLWiITcTAxHP3pJv1YvCj5Tatsd/pENe9VS
        1iAFyYsEAWg7KT1BReWCJOXGY
X-Received: by 2002:a1c:740b:: with SMTP id p11mr8434070wmc.34.1611224782065;
        Thu, 21 Jan 2021 02:26:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytwLyArMdkrGW2euiv2F5R+LcpKlJ7dFLk1oelXDZLOX3sUNvrSI1pLXYiudKjaGFuCBlfJQ==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr8434041wmc.34.1611224781804;
        Thu, 21 Jan 2021 02:26:21 -0800 (PST)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id a6sm7378064wmj.27.2021.01.21.02.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 02:26:21 -0800 (PST)
Subject: Re: [RFC PATCH 00/17] objtool: add base support for arm64
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org
References: <20210120173800.1660730-1-jthierry@redhat.com>
 <CAMj1kXHO0wgcZ4ZDxj1vS9s7Szfpz8Nz=SAW_=Dnnjy+S9AtyQ@mail.gmail.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <186bb660-6e70-6bbf-4e96-1894799c79ce@redhat.com>
Date:   Thu, 21 Jan 2021 11:26:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHO0wgcZ4ZDxj1vS9s7Szfpz8Nz=SAW_=Dnnjy+S9AtyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On 1/21/21 10:03 AM, Ard Biesheuvel wrote:
> Hello Julien,
> 
> On Wed, 20 Jan 2021 at 18:38, Julien Thierry <jthierry@redhat.com> wrote:
>>
>> Hi,
>>
>> This series enables objtool to start doing stack validation on arm64
>> kernel builds.
> 
> Could we elaborate on this point, please? 'Stack validation' means
> getting an accurate picture of all kernel code that will be executed
> at some point in the future, due to the fact that there are stack
> frames pointing to them. And this ability is essential in order to do
> live patching safely?
> 
> If this is the goal, I wonder whether this is the right approach for
> arm64 (or for any other architecture, for that matter)
> 
> Parsing/decoding the object code and even worse, relying on GCC
> plugins to annotate some of the idioms as they are being generated, in
> order to infer intent on the part of the compiler goes *way* beyond
> what we should be comfortable with. The whole point of this exercise
> is to guarantee that there are no false positives when it comes to
> deciding whether the kernel is in a live patchable state, and I don't
> see how we can ever provide such a guarantee when it is built on such
> a fragile foundation.
> 
> If we want to ensure that the stack contents are always an accurate
> reflection of the real call stack, we should work with the toolchain
> folks to identify issues that may interfere with this, and implement
> controls over these behaviors that we can decide to use in the build.
> In the past, I have already proposed adding a 'kernel' code model to
> the AArch64 compiler that guarantees certain things, such as adrp/add
> for symbol references, and no GOT indirections for position
> independent code. Inhibiting optimizations that may impact our ability
> to infer the real call stack from the stack contents is something we
> might add here as well.
> 

I'm not familiar with toolcahin code models, but would this approach be 
able to validate assembly code (either inline or in assembly files?)

> Another thing that occurred to me is that inferring which kernel code
> is actually live in terms of pending function returns could be
> inferred much more easily from a shadow call stack, which is a thing
> we already implement for Clang builds.
> 

I was not familiar with the shadow call stack. If I understand correctly 
that would be a stack of return addresses of function currently on the 
call stack, is that correct?

That would indeed be a simpler approach, however I guess the 
instrumentation has a cost. Is the instrumentation also available with 
GCC? And is this instrumentation efficient enough to be suitable for 
production builds?

If we can rely on shadow call stack to implement the reliable unwinder, 
I guess this could be the way to go.

> In summary, I would not be in favor of enabling objtool on arm64 at
> all until we have exhausted other options for providing the
> functionality that we need it for (given that objtool provides many
> other things that only x86 cares about, IIUC)
> 
I understand the concern and appreciate the suggestion. I guess this 
does need some thorough discussions for the right approach.

Thanks,

-- 
Julien Thierry

