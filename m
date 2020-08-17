Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9102479E7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 00:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgHQWGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 18:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbgHQWGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:06:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A259C061343
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 15:06:35 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id f9so8299888pju.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 15:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cWCid31trlwRX7XdfsbfwsYP5/XIk2QJn77x1TORX4M=;
        b=NXzN4f82HnWfQkiCcF+SX5NXOiO4v+KrUeo/LrrpOV+3MGTS+4cyvz3PWtiz+gB6vr
         QL0TK1sDFtGUtdMqdj8BplSJ+vL9el6/RVpkjy03Npgh44KcgW+WykjkSKy3c3yi7ve5
         uZsoIrNDJcDgFuj7T3th5Mh3X9k5tHK5ZzPdGdH72PjjkYd8YGJrA2wHlgHoO6DtH3xJ
         M9oNHiXVM/91ZencrMHLzl34yY6uSdOKyh3sRihaaxspFIRXrkkQQQiMDnG9cyZ2KvwO
         EbA/uWWkwxeUvPGqI1GzFSzcml5KspjAgCsntz81TrfELRcidw7/keX+nZo0Z7ph9z7o
         vnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cWCid31trlwRX7XdfsbfwsYP5/XIk2QJn77x1TORX4M=;
        b=GALW36X0UPjdeUHty9RfYki5gVee/jVBmk4kSg3gurNqHMH3cHuZ9dr4DOryGHOmCl
         Fy3gFlQlQj8WeDWERmH4EsgdBjhrbodafZoqMS3ilqkr6gtW0fegb5dpOHkPlEK8yNDy
         SK2nGakryR0QVQQ7PZDUlw7q5xnz2SX5B90coBd9+j7VAJF1C19+PLfOZI3rvMiVA4cE
         R/dXLXFCjnCGyJcsdT0iKk4r8THAWgY2X0HYyai3uWpc+fOnlmNXBTTsKSANe9voajum
         28Kg72CbXfm+P9R/6OiKGtF0NuXDrlPqNfnlXD6pHeRpzgvh7W9e3ghMd5cIBj7RKr/d
         Xnow==
X-Gm-Message-State: AOAM531nx/EWepDqcHm+Nm0JAKkFDFvBrfLNUA2WmfUu2d6m059p3AkT
        3U2wJQjCebPzk5GFkDvdbbWu7w==
X-Google-Smtp-Source: ABdhPJyX2YqsEKBUUEhjY7AqW5QScCarLEIXr9eJDcVCFNHsKfKduPE6VRJ2uTT7E90j6XOcZsqfXA==
X-Received: by 2002:a17:902:8210:: with SMTP id x16mr13374143pln.166.1597701993230;
        Mon, 17 Aug 2020 15:06:33 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
        by smtp.gmail.com with ESMTPSA id j142sm21983520pfd.100.2020.08.17.15.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 15:06:32 -0700 (PDT)
Date:   Mon, 17 Aug 2020 15:06:29 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 23/36] arm/build: Explicitly keep .ARM.attributes
 sections
Message-ID: <20200817220629.3pkabegeedomsaaz@google.com>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-24-keescook@chromium.org>
 <CAKwvOdn11z+iFQZC54JvQHC=NFX1FsoRMw2a-2P=5sQ6FKwbnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOdn11z+iFQZC54JvQHC=NFX1FsoRMw2a-2P=5sQ6FKwbnw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-03, 'Nick Desaulniers' via Clang Built Linux wrote:
>On Fri, Jul 31, 2020 at 4:18 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> In preparation for adding --orphan-handling=warn, explicitly keep the
>> .ARM.attributes section by expanding the existing ELF_DETAILS macro into
>> ARM_DETAILS.
>>
>> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
>> Link: https://lore.kernel.org/lkml/CAKwvOdk-racgq5pxsoGS6Vtifbtrk5fmkmnoLxrQMaOvV0nPWw@mail.gmail.com/
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  arch/arm/include/asm/vmlinux.lds.h | 4 ++++
>>  arch/arm/kernel/vmlinux-xip.lds.S  | 2 +-
>>  arch/arm/kernel/vmlinux.lds.S      | 2 +-
>>  3 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
>> index a08f4301b718..c4af5182ab48 100644
>> --- a/arch/arm/include/asm/vmlinux.lds.h
>> +++ b/arch/arm/include/asm/vmlinux.lds.h
>> @@ -52,6 +52,10 @@
>>                 ARM_MMU_DISCARD(*(__ex_table))                          \
>>                 COMMON_DISCARDS
>>
>> +#define ARM_DETAILS                                                    \
>> +               ELF_DETAILS                                             \
>> +               .ARM.attributes 0 : { *(.ARM.attributes) }
>
>I had to look up what the `0` meant:
>https://sourceware.org/binutils/docs/ld/Output-Section-Attributes.html#Output-Section-Attributes
>mentions it's an "address" and
>https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_chapter/ld_3.html#SEC21
>mentions it as "start" (an address).
>Unless we need those, can we drop them? (Sorry for the resulting churn
>that would cause).  I think the NO_LOAD stuff makes more sense, but
>I'm curious if the kernel checks for that.

NOLOAD means SHT_NOBITS (usually SHF_ALLOC). .ARM.attributes is a
non-SHF_ALLOC section.

An explicit 0 (output section address) is good - GNU ld's internal
linker scripts (ld --verbose output) use 0 for such non-SHF_ALLOC sections.
Without the 0, the section may get a non-zero address, which is not
wrong - but probably does not look well. See https://reviews.llvm.org/D85867 for details.


Reviewed-by: Fangrui Song <maskray@google.com>

>> +
>>  #define ARM_STUBS_TEXT                                                 \
>>                 *(.gnu.warning)                                         \
>>                 *(.glue_7)                                              \
>> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
>> index 904c31fa20ed..57fcbf55f913 100644
>> --- a/arch/arm/kernel/vmlinux-xip.lds.S
>> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
>> @@ -150,7 +150,7 @@ SECTIONS
>>         _end = .;
>>
>>         STABS_DEBUG
>> -       ELF_DETAILS
>> +       ARM_DETAILS
>>  }
>>
>>  /*
>> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
>> index bb950c896a67..1d3d3b599635 100644
>> --- a/arch/arm/kernel/vmlinux.lds.S
>> +++ b/arch/arm/kernel/vmlinux.lds.S
>> @@ -149,7 +149,7 @@ SECTIONS
>>         _end = .;
>>
>>         STABS_DEBUG
>> -       ELF_DETAILS
>> +       ARM_DETAILS
>>  }
>>
>>  #ifdef CONFIG_STRICT_KERNEL_RWX
>> --
>> 2.25.1
>>
