Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CA829CBE2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 23:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832253AbgJ0WSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 18:18:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35589 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1832245AbgJ0WST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 18:18:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id f38so1602263pgm.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R+TzVjMGuuOAhuzCd/X5fEku0ly/jO19B59u1oK4LbQ=;
        b=Okz3JM1XL2nGsxb1umt2mHqpIKQ+k+MWyuFrfrCyx40mavkIIWPiaIfEkAuBDROdJe
         tlbiQ/Gr4XoD+3zlQLbIrm/t9pU0Z2mlENWFUMLC9JsXD9e4QSxvs1De7eZtcmAis+tk
         7ZQwLnxij0pofykJ1B3MrMtMPz1yQ4rwRkYb7PWjYh9DFctmRPVhDMWIS6XCWIG7CIfS
         PWvvifkuQY6SkpIfAEPngT3HmkdvtSeUaZbEjZt//6hWmBqxmfRgD4wAdpjQzwyhXRht
         jokEHxj7qc0Smu0DhMj8vYHrAxK1OMgmABWamWw/UxwP12Jeckngab4TJXFNy3NYarKH
         SMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R+TzVjMGuuOAhuzCd/X5fEku0ly/jO19B59u1oK4LbQ=;
        b=ZYjEF2FQ3R3FNI1auyLqlbQzKmMzaIj8fVSqZyTzT9sZ7qaycsaEXo5BzMBxsKbBIt
         ovPFE8oOEafUg5FEGCfIx5LrqUJ2fDIdys7MpzNb/YNw1bkjWSHlaf1kzxTj1wQF6FEZ
         oF4kLT1t9EOp57gKkScUYG+NnycFF2cgb/Ssz/9UFrl6oi3MySUrNtCNysz4q9ncdJ1G
         nA6Fgoj8mMGxegC6R2Kny1tJFc4b/TtnxVT/bDY6OWW/vhutBR/bpOMHAhg0qFg5pjyn
         /5/fRJQZkUnrGBNlWuWN0SjJQUfs1MAL+x51QDDgrgXSkuRaPzUqQqGQChpnOwgfJNpr
         qP2w==
X-Gm-Message-State: AOAM530hCPPmTSgL7cOKbYCTfN5OAtplUTQPtqst93XV2rkLrUX1fujO
        NP2X2J/JyyfARmu6fJ/CDF042CCI1c6xew==
X-Google-Smtp-Source: ABdhPJz6qXWNZwihj4vmh8FMC8KRX91scrpXZ5I9yPVtl7DBpCVijZUC5X0m4T3lxibWwwThvzSwCQ==
X-Received: by 2002:a63:5d44:: with SMTP id o4mr3552930pgm.409.1603837098358;
        Tue, 27 Oct 2020 15:18:18 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
        by smtp.gmail.com with ESMTPSA id s131sm3183027pgc.18.2020.10.27.15.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 15:18:17 -0700 (PDT)
Date:   Tue, 27 Oct 2020 15:18:14 -0700
From:   Fangrui Song <maskray@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH] module: use hidden visibility for weak symbol references
Message-ID: <20201027221814.rkm73l5dtyysvagj@google.com>
References: <20201027151132.14066-1-ardb@kernel.org>
 <CAKwvOd=XHAGotJ38o=hZTwi89XvCyshaUtWezZQ-k6aRT20xwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOd=XHAGotJ38o=hZTwi89XvCyshaUtWezZQ-k6aRT20xwQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One nit about ".got" in the message:

Reviewed-by: Fangrui Song <maskray@google.com>

On 2020-10-27, Nick Desaulniers wrote:
>+ Fangrui
>
>On Tue, Oct 27, 2020 at 8:11 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> Geert reports that commit be2881824ae9eb92 ("arm64/build: Assert for
>> unwanted sections") results in build errors on arm64 for configurations
>> that have CONFIG_MODULES disabled.
>>
>> The commit in question added ASSERT()s to the arm64 linker script to
>> ensure that linker generated sections such as .got, .plt etc are empty,

.got -> .got.plt

be2881824ae9eb92 does not ASSERT on .got (it can).

Strangely *(.got) is placed in .text in arch/arm64/kernel/vmlinux.lds.S
I think that line can be removed. On x86, aarch64 and many other archs,
the start of .got.plt is the GOT base. .got is not needed (ppc/arm/riscv
use .got instead of .got.plt as the GOT base anchor).

>> but as it turns out, there are corner cases where the linker does emit
>> content into those sections. More specifically, weak references to
>> function symbols (which can remain unsatisfied, and can therefore not
>> be emitted as relative references) will be emitted as GOT and PLT
>> entries when linking the kernel in PIE mode (which is the case when
>> CONFIG_RELOCATABLE is enabled, which is on by default).

Confirmed.

>> What happens is that code such as
>>
>>         struct device *(*fn)(struct device *dev);
>>         struct device *iommu_device;
>>
>>         fn = symbol_get(mdev_get_iommu_device);
>>         if (fn) {
>>                 iommu_device = fn(dev);
>>
>> essentially gets converted into the following when CONFIG_MODULES is off:
>>
>>         struct device *iommu_device;
>>
>>         if (&mdev_get_iommu_device) {
>>                 iommu_device = mdev_get_iommu_device(dev);
>>
>> where mdev_get_iommu_device is emitted as a weak symbol reference into
>> the object file. The first reference is decorated with an ordinary
>> ABS64 data relocation (which yields 0x0 if the reference remains
>> unsatisfied). However, the indirect call is turned into a direct call
>> covered by a R_AARCH64_CALL26 relocation, which is converted into a
>> call via a PLT entry taking the target address from the associated
>> GOT entry.

Yes, the R_AARCH64_CALL26 relocation referencing an undefined weak
symbol causes one .plt entry and one .got.plt entry.

>> Given that such GOT and PLT entries are unnecessary for fully linked
>> binaries such as the kernel, let's give these weak symbol references
>> hidden visibility, so that the linker knows that the weak reference
>> via R_AARCH64_CALL26 can simply remain unsatisfied.
>>
>> Cc: Jessica Yu <jeyu@kernel.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>  include/linux/module.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/module.h b/include/linux/module.h
>> index 7ccdf87f376f..6264617bab4d 100644
>> --- a/include/linux/module.h
>> +++ b/include/linux/module.h
>> @@ -740,7 +740,7 @@ static inline bool within_module(unsigned long addr, const struct module *mod)
>>  }
>>
>>  /* Get/put a kernel symbol (calls should be symmetric) */
>> -#define symbol_get(x) ({ extern typeof(x) x __attribute__((weak)); &(x); })
>> +#define symbol_get(x) ({ extern typeof(x) x __attribute__((weak,visibility("hidden"))); &(x); })
>>  #define symbol_put(x) do { } while (0)
>>  #define symbol_put_addr(x) do { } while (0)
>>
>> --
>> 2.17.1
>>
>
>
>-- 
>Thanks,
>~Nick Desaulniers
