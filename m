Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD8A29C719
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827772AbgJ0S1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:27:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46617 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1827761AbgJ0S1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:27:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id x10so1194432plm.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 11:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3xxssZMfhcCk5+/sXgaGkrrOB6SC6L3pBY/sM5t9/hU=;
        b=DUlvCZgvOlE2JXI6215/PWcvhsm/BX8x0gJmDYHkZwkqKqqgv8ieOlVqgyCGn7MaYe
         7rIvU10iiKp3zsgVe+3d2UTsgAFlaB1veQ/o39487VlJPdsuGZIwQbrx22POJ+rPzYUy
         CYWBfegTk/3LOt2QvHnDBa9W7zzbr5m7BX2NA0Ivgyg+alhFHJFJaytY/lmEphy9rk+q
         I4A06b4SIgOl2zm4QLF4tR7Po5IG949e4c2nYJX7SEQ7zHnmUI39G+WVj/7EIskOFzPB
         4bNuQWBfrfqCLkHp3kGQgXmiL2OUOq/nnjOyAPtWdDScU4iiW7y6zh7qYmugJQ+SQNRh
         9C+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3xxssZMfhcCk5+/sXgaGkrrOB6SC6L3pBY/sM5t9/hU=;
        b=kIKKNHkxudYHIIP7qGQ/FriYl0WosPwqsyGHQXPemcG4oJHHGNOsqq9m5pzwktA7rz
         np4fq0MWzadruLNIu0OCU8mnss6XhWYZFBRkbazXRxDIHNkLZf+CrVGStG3jIor5Seis
         NBXIwe/Nx/jLl1Iz/MsmItykAzreMJPBiQFtGxUFhPZ25K7u+JkCSlls/qVXyDo/DPNe
         bjL4duuqT/AYB+VBT6GJCFYtOd/Mm9f0qQZfhMXMYpsiDxr0rGo3DtNrZBNQS0lPkcs1
         QiMvAAg4x06w5fUPXY8f3it+KURihqHIpj++R3dmdZC8Fxzi42INCETUrh6EjXkN0YuF
         m8Xg==
X-Gm-Message-State: AOAM533dviRMxFuy7K+EeS17+P3iqrSaVnp38RmilgM3BfVp0EMhLVqI
        uLlEb60YY8+26zYw61DNc4LpqePIpB/NGRR7ZQ1XqlaEAcI=
X-Google-Smtp-Source: ABdhPJzC7lPS4CDr/XrgaZ4QYZCCMIjayh78IPDH2di0tIpfUVl36VnlDIq97AtganVTDcHdK/jf/1Rak3d5JhBGCbc=
X-Received: by 2002:a17:902:c24b:b029:d3:f3e6:1915 with SMTP id
 11-20020a170902c24bb02900d3f3e61915mr3731085plg.56.1603823264821; Tue, 27 Oct
 2020 11:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201027151132.14066-1-ardb@kernel.org>
In-Reply-To: <20201027151132.14066-1-ardb@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Oct 2020 11:27:33 -0700
Message-ID: <CAKwvOd=XHAGotJ38o=hZTwi89XvCyshaUtWezZQ-k6aRT20xwQ@mail.gmail.com>
Subject: Re: [PATCH] module: use hidden visibility for weak symbol references
To:     Ard Biesheuvel <ardb@kernel.org>, Fangrui Song <maskray@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Fangrui

On Tue, Oct 27, 2020 at 8:11 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Geert reports that commit be2881824ae9eb92 ("arm64/build: Assert for
> unwanted sections") results in build errors on arm64 for configurations
> that have CONFIG_MODULES disabled.
>
> The commit in question added ASSERT()s to the arm64 linker script to
> ensure that linker generated sections such as .got, .plt etc are empty,
> but as it turns out, there are corner cases where the linker does emit
> content into those sections. More specifically, weak references to
> function symbols (which can remain unsatisfied, and can therefore not
> be emitted as relative references) will be emitted as GOT and PLT
> entries when linking the kernel in PIE mode (which is the case when
> CONFIG_RELOCATABLE is enabled, which is on by default).
>
> What happens is that code such as
>
>         struct device *(*fn)(struct device *dev);
>         struct device *iommu_device;
>
>         fn = symbol_get(mdev_get_iommu_device);
>         if (fn) {
>                 iommu_device = fn(dev);
>
> essentially gets converted into the following when CONFIG_MODULES is off:
>
>         struct device *iommu_device;
>
>         if (&mdev_get_iommu_device) {
>                 iommu_device = mdev_get_iommu_device(dev);
>
> where mdev_get_iommu_device is emitted as a weak symbol reference into
> the object file. The first reference is decorated with an ordinary
> ABS64 data relocation (which yields 0x0 if the reference remains
> unsatisfied). However, the indirect call is turned into a direct call
> covered by a R_AARCH64_CALL26 relocation, which is converted into a
> call via a PLT entry taking the target address from the associated
> GOT entry.
>
> Given that such GOT and PLT entries are unnecessary for fully linked
> binaries such as the kernel, let's give these weak symbol references
> hidden visibility, so that the linker knows that the weak reference
> via R_AARCH64_CALL26 can simply remain unsatisfied.
>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  include/linux/module.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 7ccdf87f376f..6264617bab4d 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -740,7 +740,7 @@ static inline bool within_module(unsigned long addr, const struct module *mod)
>  }
>
>  /* Get/put a kernel symbol (calls should be symmetric) */
> -#define symbol_get(x) ({ extern typeof(x) x __attribute__((weak)); &(x); })
> +#define symbol_get(x) ({ extern typeof(x) x __attribute__((weak,visibility("hidden"))); &(x); })
>  #define symbol_put(x) do { } while (0)
>  #define symbol_put_addr(x) do { } while (0)
>
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
