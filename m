Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C8729C4E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1823627AbgJ0R7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:59:04 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38828 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370831AbgJ0R4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:56:08 -0400
Received: by mail-oi1-f194.google.com with SMTP id h10so2181485oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 10:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2O1KCO6hwywnVoo1ZUF7NbbA0C0IV0tNoU9l9bzMP0=;
        b=S1ViT2cHVrQmbU96VSK2LZyZr+ilkGS2VBfzvJW6Z+a+nnW93t3/d3bJ+xbMiD5oVe
         CwoFCLmh3vIcFNKibKE/vFkWXIqMKnvoNVXZPV6LKwaHldgtP/OZ0Ad3KR5crCaCpMia
         hQemT14snZbTMZ9MEHtQtI9tl28bHMXI+CmXz6V566TRpnieFOiS1XzcfG2Ep5oN3/pM
         6d2XIHJA9prbRbet/wLtz7xCooDDubJBinCXHaMkbO4uTbR4yRWu+SCvb1eyIfGpKzT1
         Y2xysxMxtVist0vYrWO6PctYp1llUVnLwEd6sM6nD00jlcRQTDarb0Qybyj2d3pB35iF
         EOZA==
X-Gm-Message-State: AOAM530W0v3IPhvznnBKThXjzz772s15DSeNJOOr0LC1sKss+toYQCCx
        1AvAUIUy1mJ3pUD7rHzqXTt0gBazwuxX4JDarEg=
X-Google-Smtp-Source: ABdhPJzQPI+DV8csI4m/7ymq3SmMrcl2Dj4fQcISRslcjewCvGzla2ybIoo1TlgGWyOFjqCJCG3WMursfGdXiNmi/X8=
X-Received: by 2002:aca:c490:: with SMTP id u138mr2387344oif.54.1603821367589;
 Tue, 27 Oct 2020 10:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201027151132.14066-1-ardb@kernel.org>
In-Reply-To: <20201027151132.14066-1-ardb@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Oct 2020 18:55:56 +0100
Message-ID: <CAMuHMdXz5Q+V3eAePLOdBgGjecs1aZmjka3PAphVsHV+Mu3u=Q@mail.gmail.com>
Subject: Re: [PATCH] module: use hidden visibility for weak symbol references
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 4:11 PM Ard Biesheuvel <ardb@kernel.org> wrote:
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

Thanks, this get rids of

    aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
    aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!

which you may want to mention in the patch description, to make
it easier to be found.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
