Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DEE2F3D7A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbhALVlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407019AbhALVhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:37:47 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EDFC061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:37:07 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id p14so3315836qke.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MC7BSr6d4yh4fJNH+ilIdGBl8uQ03KTfoLip01VhE/8=;
        b=iaw0KylzQa9399e718RK9zFSYe6sG0OYhLP52bdzy6Z18PmqQAxOW5XHJGUD9PlpuN
         V0SIyaCi0V/EciD5FDzh4t1sxCi+B24l08J/+yMjRMehevd+2yHd2TuLR4AlWKkAJ0Ja
         tFhHp8NLk0PyMlOfBGsO9q/TBwG/NYd8RvOnyWCkea78ztg6pnTW5lPRB1NxuxkVt6yE
         yZghQciwVpSXca4hnleyMcYh6C3BhL7q1k5PsuHUMcnO4MMkxObS6ZX0eep6xivmJaSZ
         fzdjAGd7yTF0OPybZYJAF92RAMRCWbkLjKaGps9hfczOfLhhNMPLuyxkeAOB/y+L83O3
         fDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MC7BSr6d4yh4fJNH+ilIdGBl8uQ03KTfoLip01VhE/8=;
        b=ejIuRpZTKblVJIkvEmBgIaMv6DUkH2NjRZAgKR07AwMVfFqWlZ+1y/iigskvpKE/Ez
         wuc094JmbhxzeLhHeg+sbscTzIvdvXTQKnlLc9/0aE+FyTT3DH/ZKs66T4H8kZ5hEog1
         qdYL1RA9+4rFHtUPAs730MQK1juUOqmdn0Pujj12rC0CMBZEuG3vKspoKo0Gw9BoELvD
         b9pGgh5MB1wZjs+X6KmepNrArzNhpZIuQmic7n1pcIYkc2ePlS0D/u8vgjohoMxQ+mHg
         0EKCrC+Y6LVH15kZhiwLD6Frh6kh589N9OtoxmtQ9C4YckqzI0obulo6r8j0hPJPKejU
         nJLA==
X-Gm-Message-State: AOAM530yZDSW9ce2vagaucHMPh2K65x1Hjz6RiFwPYWKmT0+XIu8UxB/
        MUhIoT/FrA7KQw3080oDAB0=
X-Google-Smtp-Source: ABdhPJxo/F+GaTZdNAQPdOP3DxstWyAl5Rb0p4ntaVxNmloGNaUmosyHV9+tjxfe7OkEaq13qPrSdw==
X-Received: by 2002:a37:a2d1:: with SMTP id l200mr1562906qke.445.1610487426123;
        Tue, 12 Jan 2021 13:37:06 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id b11sm1929244qtc.5.2021.01.12.13.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 13:37:05 -0800 (PST)
Date:   Tue, 12 Jan 2021 14:37:03 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ubsan: Implement __ubsan_handle_alignment_assumption
Message-ID: <20210112213703.GA1376568@ubuntu-m3-large-x86>
References: <20210112205542.1375847-1-natechancellor@gmail.com>
 <CAKwvOd=yrVKBn9TN2cP8SiB7A8=c2g41PyodKGJu+xEQwAmnDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=yrVKBn9TN2cP8SiB7A8=c2g41PyodKGJu+xEQwAmnDA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 01:15:42PM -0800, Nick Desaulniers wrote:
> On Tue, Jan 12, 2021 at 12:55 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > When building ARCH=mips 32r2el_defconfig with CONFIG_UBSAN_ALIGNMENT:
> >
> > ld.lld: error: undefined symbol: __ubsan_handle_alignment_assumption
> > >>> referenced by slab.h:557 (include/linux/slab.h:557)
> > >>>               main.o:(do_initcalls) in archive init/built-in.a
> > >>> referenced by slab.h:448 (include/linux/slab.h:448)
> > >>>               do_mounts_rd.o:(rd_load_image) in archive init/built-in.a
> > >>> referenced by slab.h:448 (include/linux/slab.h:448)
> > >>>               do_mounts_rd.o:(identify_ramdisk_image) in archive init/built-in.a
> > >>> referenced 1579 more times
> >
> > Implement this for the kernel based on LLVM's
> > handleAlignmentAssumptionImpl because the kernel is not linked against
> > the compiler runtime.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1245
> > Link: https://github.com/llvm/llvm-project/blob/llvmorg-11.0.1/compiler-rt/lib/ubsan/ubsan_handlers.cpp#L151-L190
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  lib/ubsan.c | 28 ++++++++++++++++++++++++++++
> >  lib/ubsan.h |  6 ++++++
> >  2 files changed, 34 insertions(+)
> >
> > diff --git a/lib/ubsan.c b/lib/ubsan.c
> > index 3e3352f3d0da..a1e6cc9993f8 100644
> > --- a/lib/ubsan.c
> > +++ b/lib/ubsan.c
> > @@ -427,3 +427,31 @@ void __ubsan_handle_load_invalid_value(void *_data, void *val)
> >         ubsan_epilogue();
> >  }
> >  EXPORT_SYMBOL(__ubsan_handle_load_invalid_value);
> > +
> > +void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
> > +                                        unsigned long align,
> > +                                        unsigned long offset)
> > +{
> > +       struct alignment_assumption_data *data = _data;
> > +       unsigned long real_ptr;
> > +
> > +       if (suppress_report(&data->location))
> > +               return;
> > +
> > +       ubsan_prologue(&data->location, "alignment-assumption");
> > +
> > +       if (offset)
> > +               pr_err("assumption of %lu byte alignment (with offset of %lu byte) for pointer of type %s failed",
> > +                      align, offset, data->type->type_name);
> > +       else
> > +               pr_err("assumption of %lu byte alignment for pointer of type %s failed",
> > +                      align, data->type->type_name);
> > +
> > +       real_ptr = ptr - offset;
> > +       pr_err("%saddress is %lu aligned, misalignment offset is %lu bytes",
> > +              offset ? "offset " : "", BIT(ffs(real_ptr)),
> 
> if real_ptr is an unsigned long, do we want to use `__ffs(real_ptr) +
> 1` here rather than ffs which takes an int?  It seems the kernel is
> missing a definition of ffsl. :(

Why the + 1? I think if we use __ffs (which it seems like we should), I
think that needs to become

BIT(real_ptr ? __ffs(real_ptr) : 0)

I have made that change locally and will send it for v2 in a day or so
to give Kees some time to check it out.

Thanks for the review!
Nathan
