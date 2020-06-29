Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2CC20E8DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 01:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgF2WjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 18:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgF2WjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:39:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA08C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 15:39:23 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y18so7662061plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 15:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zapdhd5wOeOGPDdB4uAKBeHEzFOq3zrNgTJZIPqzsqk=;
        b=Wvv6Dtahe6GleCa8gnqJNTTtBdjrDG/3r9+HUHNe1jsxUhVUVDEgPWlkxSOV3+OcpV
         v0yR4N+iEbZgX778DbNIAGbX2TIxXq8+Gi5oJu49hU17BL7Hul5QEysAexG+ydNbgMOo
         PgZNkcokgimWBksjl3pSSevXfUPYwItR7Qx+SH3PIHn4sW66rnj1q1F8YWuGydSIXxFr
         NVXjogMU4noRATaEN0MJ6mFh4ZeVK1i3Bij938QPTFKa5JAl6VfJKmGV/K9AeE4afg28
         digtp2TDXdCuKL/FpFMtMWT1RH71K4pG9kI+Uky6Ez4JPeUdL50qfh7445r1NRn122Id
         mcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zapdhd5wOeOGPDdB4uAKBeHEzFOq3zrNgTJZIPqzsqk=;
        b=lzWKTUYKNkVRCjePYBGZT01tGfRCRcL9wKN2MoBT9ZqR/xsIWAXYihFbw0VLtQkJe9
         OVaHcxJJjY7766Me2i+chAUnx3HSh2Oyo0if2+DNbhVmMTJj3wPUD2ZbGmID494X+8g4
         1LXggeO0ICH88ZqGX9D1B5fTKvr63j9CQaod+u+zjgO7bpdgyfIPAgyxbmU9w0/eQxRl
         RT1Z/xFAP1oEP1As/vSrWt7NZkbscWGUZhqSfnq3+tLn5ebq1cFXKIwMuL3rUnj7jfPv
         EGrWvVBtbT9kfj60HhJPzExbEf+2mkKtZ3tEU5RgpOfRQzplrSMS480JNV2GV0r+Wau5
         MuIQ==
X-Gm-Message-State: AOAM532s+pPZ0h38e6T1XVn9OLwdj9KzpKjBIFpSE5H7cX4Of2zAaZjc
        xt/iHE02S862msYTMhnreWivv238z/np9zrFCplDJA==
X-Google-Smtp-Source: ABdhPJzKxVVA/UERXMxrjy6ojZ8dNl3GRmf36xXfXS/hUkCCbIEUj7V30jAYgp4qDheTF4tDFuQLeaTyAIpDG9yRI/I=
X-Received: by 2002:a17:902:7208:: with SMTP id ba8mr15114728plb.179.1593470362777;
 Mon, 29 Jun 2020 15:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200626185913.92890-1-masahiroy@kernel.org> <CAKwvOd=V_M43CP7G87K3TqSsxua2NcXPz6BnDt-z6167O2WAzQ@mail.gmail.com>
 <CAK7LNATcwGkSWV7NSgwG_WqzvTPphT9=KK+qvT3FK_7y1UCzTA@mail.gmail.com> <CAKwvOdntZw2k8ZZ7txPC-FD+50cPpMwctGYTW0j2zw+FVj9SgA@mail.gmail.com>
In-Reply-To: <CAKwvOdntZw2k8ZZ7txPC-FD+50cPpMwctGYTW0j2zw+FVj9SgA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Jun 2020 15:39:11 -0700
Message-ID: <CAKwvOd=JbEJNdWzk_xdMiy9QewbU3ESOHcokAXKkARrgm-ibEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: remove cc-option test of -fno-stack-protector
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 11:26 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sat, Jun 27, 2020 at 4:59 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Sat, Jun 27, 2020 at 5:13 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Fri, Jun 26, 2020 at 12:00 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
> > > > index dba6a83bc349..93792b457b81 100644
> > > > --- a/arch/x86/kernel/cpu/Makefile
> > > > +++ b/arch/x86/kernel/cpu/Makefile
> > > > @@ -17,8 +17,7 @@ KCOV_INSTRUMENT_perf_event.o := n
> > > >  KCSAN_SANITIZE_common.o := n
> > > >
> > > >  # Make sure load_percpu_segment has no stackprotector
> > > > -nostackp := $(call cc-option, -fno-stack-protector)
> > > > -CFLAGS_common.o                := $(nostackp)
> > > > +CFLAGS_common.o                := -fno-stack-protector
> > >
> > > Any time I see `:=` assignment to a CFLAGS variable, it's a red flag
> > > for overwriting existing CFLAGS, which is a common source of bugs.  I
> > > recognize the kernel is current a mix and match for:
> > >
> > > CFLAGS_<file>.o
> > >
> > > rules to either use `+=` or `:=`, but I wish we were consistent, and
> > > consistent in our use of `+=`.  For those rules, is there a difference
> > > between the use of `+=` and `:=` like there is for the more general
> > > case of appending to KBUILD_CFLAGS?  If not, it's ok to match the
> > > existing style, but it's curious to me in this patch to see a mixed
> > > use of `+=` and `:=`.
> >
> >
> > I think Kees mostly answered your question.
> >
> > Let me add some comments.
> >
> >
> > '+=' is the most used in kernel Makefiles, but
> > ':=' and '=' are also used.
> >
> > So, you are right, we are inconsistent.
> > This applies to not only CFLAGS_<file>.o, but also obj-y, etc.
> >
> > For example,
> > https://github.com/torvalds/linux/blob/v5.7/arch/arm64/kernel/Makefile#L15
> > 'obj-y :=' works since it is the first assignment to obj-y in that file.
> > 'obj-y +=' also works, of course.
> >
> > We can consistently use '+=' everywhere, but I do not send
> > patches for churn.
> >
> >
> > You can use any assignment operator to CFLAGS_<file>.o
> > if it is the first assignment in the Makefile.
> > Using '+=' is robust for future code insertion/removal, though.
> >
> >
> > If the right-hand side contains variable references,
> > there is important difference in the behavior.
> >
> > You may know two flavors in variables
> > (https://www.gnu.org/software/make/manual/make.html#Flavors)
>
> Cool, thanks for all the info.  With that, I'm happy with this patch.
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
>
> > CFLAGS_foo.o := $(call cc-option,-fno-stack-protector)
> > The cc-option is expanded immediately when this line is parsed.
> > (So, the compiler is invoked for 'make clean' too)
> >
> >
> > CFLAGS_foo.o += $(call cc-option,-fno-stack-protector)
> > If this is the first assignment in the file,
> > '+=' act as '=', so the evaluation of cc-option
> > is delayed until $(CFLAGS_foo.o) is expanded.
> > (So, the compiler is NOT invoked for 'make clean')
>
> Ah, I think that may explain: I've been seeing the occasional warning
> from $(NM) when running `make clean` for ARCH=arm, I'll bet that's
> where this is coming from then.  Next time I reproduce it, I'll try to
> find maybe where we're using `:=` or `=` with `$(NM)`.
>
> Maybe arch/arm/boot/compressed/Makefile, KBSS_SZ is evaluated for
> `make clean`? (If you start an arm build, but kill it before vmlinux
> is created, then `make clean` I suspect that KBSS_SZ is evaluated?)

$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make LLVM=1 -j71
$ rm vmlinux
$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make LLVM=1 -j71 clean
llvm-nm: error: arch/arm/boot/compressed/../../../../vmlinux: No such
file or directory.

I suspect I see this from doing an ARCH=arm build, then building a
different ARCH and killing the build before vmlinux is produced or
`make clean` for a different ARCH, then run a `make clean` for
ARCH=arm.

Is the above (regarding lazy evaluation) not true for LDFLAGS_vmlinux?
I would have thought this would work:

diff --git a/arch/arm/boot/compressed/Makefile
b/arch/arm/boot/compressed/Makefile
index 00602a6fba04..9e7343ccc279 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -113,10 +113,9 @@ ccflags-y := -fpic $(call
cc-option,-mno-single-pic-base,) -fno-builtin \
 asflags-y := -DZIMAGE

 # Supply kernel BSS size to the decompressor via a linker symbol.
-KBSS_SZ = $(shell echo $$(($$($(NM) $(obj)/../../../../vmlinux | \
+LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(shell echo $$(($$($(NM)
$(obj)/../../../../vmlinux | \
                sed -n -e 's/^\([^ ]*\) [AB] __bss_start$$/-0x\1/p' \
-                      -e 's/^\([^ ]*\) [AB] __bss_stop$$/+0x\1/p') )) )
-LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)
+                                        -e 's/^\([^ ]*\) [AB]
__bss_stop$$/+0x\1/p') )) )

-- 
Thanks,
~Nick Desaulniers
