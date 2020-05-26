Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702A31E2499
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 16:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbgEZOz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 10:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgEZOzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 10:55:25 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A01C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 07:55:24 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id 17so20714317ilj.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=3CchUKaOl3OxUD8vzoOX6WqHhwZWNC7mGRsWtMwPBrA=;
        b=Nk3dMpOP4wgpYWqxGOWOgp9Hw97hWUIa//UhNja59ERx0LOC+2nNIHTzdHFvkYVURt
         Tjvw/mOZ+y/T7EjO63Z2NcXQT1WM+mgnV8uFtPOHGGtR12qU3omPpWZiAR+0PtXJvUfj
         8HTiXABHQuIxV3nnO2pDsWrxsUtQJTotpgJpk2nLccUDibqvR8h0KutgEXPqnx4x0WJF
         4JiljhD4An7BoW01E7v7k517hRrz36qDSK+TVS9pPS5AlBl/vESGKEv2ONsPME2bsa3E
         laoywPDm2NRgwzxnDk/9ZSEXVIn6Er7BZD/nSftDIiI5DqlKTr18A+QTsq1icEppDOlR
         qzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=3CchUKaOl3OxUD8vzoOX6WqHhwZWNC7mGRsWtMwPBrA=;
        b=HGVL0ao6f0dl//cGV+RxTgTEfEneb8Kii+TQodrd9BQ3wc898tYYIFx+loaugIZL9a
         Bkxsw/MXw7y6LliAaiE29yIDYXSXdunYhmMdfv3kxrTjY9/bxctQVFPSdZIe0QnNpDcR
         R4R6XBTqPuAPaV6aqUW8ummRj4IEcUMhTwdddghOZe4FGVtYAIX6aeG42RhTl5QqkLYY
         sNQQgbmRsl3Fmll6ERIUQmlweIHlJ5R2VRenTJeeqE6PW75IQ398PiY7PL+XCE/Z4EfQ
         DM4oq0PC61wONmdy/0NGyWJXctYfUHMqja2J+XdNRfODM8S6jeQ+/dFUG8jGGrmhfKE0
         +Wbg==
X-Gm-Message-State: AOAM531g2dHgnwCnNxrXoblactTDh9okZBxWC9MjxVAYEYBaTAZ7zdK1
        HqNPiowPlbOFMruLJ9E5cpfQARh3wz1jacpjcgc=
X-Google-Smtp-Source: ABdhPJybgUZIEztP8qTecHIants1+pohVTZQaaXI1MouFq4cIstk/zZASvbecZGVAtVNzbQRhFzrLn/3tei809uRGVQ=
X-Received: by 2002:a92:5893:: with SMTP id z19mr1541597ilf.255.1590504924113;
 Tue, 26 May 2020 07:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200524212816.243139-1-nivedita@alum.mit.edu>
 <20200525225918.1624470-1-nivedita@alum.mit.edu> <CA+icZUVa8FhhwHgXn1o_hFmgqFG6-KE1F+qvkdCzQjmSSSDWDw@mail.gmail.com>
 <CAMj1kXHVFgRsbssJQD2C0GZnOgG=rMYbPGJQtiKhSw6sZj5PaA@mail.gmail.com>
 <CA+icZUWyFDgieQswvfhWemzymDh_UiVqH2uH52a+0otcr2Pd4w@mail.gmail.com>
 <CA+icZUVKRZPFX_Q8RRJnFsHrkM5VbiWUEam+6O5XSzgNaqAzPg@mail.gmail.com> <CA+icZUWTKJ=-OGJPzqm6HNQMkB1uS_B0ydU-9Xa035wB7vA4iw@mail.gmail.com>
In-Reply-To: <CA+icZUWTKJ=-OGJPzqm6HNQMkB1uS_B0ydU-9Xa035wB7vA4iw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 26 May 2020 16:55:13 +0200
Message-ID: <CA+icZUU54K8z2--6fS=LEaMJGgeWfudViT7ETMsSYF1i59_4mg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] x86/boot: Remove runtime relocations from
 compressed kernel
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 4:48 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Tue, May 26, 2020 at 2:44 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Tue, May 26, 2020 at 2:33 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Tue, May 26, 2020 at 2:30 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Tue, 26 May 2020 at 14:29, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > >
> > > > > On Tue, May 26, 2020 at 12:59 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > >
> > > > > > The compressed kernel currently contains bogus runtime relocations in
> > > > > > the startup code in head_{32,64}.S, which are generated by the linker,
> > > > > > but must not actually be processed at runtime.
> > > > > >
> > > > > > This generates warnings when linking with the BFD linker, and errors
> > > > > > with LLD, which defaults to erroring on runtime relocations in read-only
> > > > > > sections. It also requires the -z noreloc-overflow hack for the 64-bit
> > > > > > kernel, which prevents us from linking it as -pie on an older BFD linker
> > > > > > (<= 2.26) or on LLD, because the locations that are to be apparently
> > > > > > relocated are only 32-bits in size and so cannot normally have
> > > > > > R_X86_64_RELATIVE relocations.
> > > > > >
> > > > > > This series aims to get rid of these relocations. It is based on
> > > > > > efi/next, where the latest patches touch the head code to eliminate the
> > > > > > global offset table.
> > > > > >
> > > > > > The first patch is an independent fix for LLD, to avoid an orphan
> > > > > > section in arch/x86/boot/setup.elf.
> > > > > >
> > > > > > The second patch gets rid of almost all the relocations. It uses
> > > > > > standard PIC addressing technique for 32-bit, i.e. loading a register
> > > > > > with the address of _GLOBAL_OFFSET_TABLE_ and then using GOTOFF
> > > > > > references to access variables. For 64-bit, there is 32-bit code that
> > > > > > cannot use RIP-relative addressing, and also cannot use the 32-bit
> > > > > > method, since GOTOFF references are 64-bit only. This is instead handled
> > > > > > using a macro to replace a reference like gdt with (gdt-startup_32)
> > > > > > instead. The assembler will generate a PC32 relocation entry, with
> > > > > > addend set to (.-startup_32), and these will be replaced with constants
> > > > > > at link time. This works as long as all the code using such references
> > > > > > lives in the same section as startup_32, i.e. in .head.text.
> > > > > >
> > > > > > The third patch addresses a remaining issue with the BFD linker, which
> > > > > > insists on generating runtime relocations for absolute symbols. We use
> > > > > > z_input_len and z_output_len, defined in the generated piggy.S file, as
> > > > > > symbols whose absolute "addresses" are actually the size of the
> > > > > > compressed payload and the size of the decompressed kernel image
> > > > > > respectively. LLD does not generate relocations for these two symbols,
> > > > > > but the BFD linker does, prior to the upcoming 2.35. To get around this,
> > > > > > piggy.S is extended to also define two u32 variables (in .rodata) with
> > > > > > the lengths, and the head code is modified to use those instead of the
> > > > > > symbol addresses.
> > > > > >
> > > > > > An alternative way to handle z_input_len/z_output_len would be to just
> > > > > > include piggy.S in head_{32,64}.S instead of as a separate object file,
> > > > > > since the GNU assembler doesn't generate relocations for symbols set to
> > > > > > constants.
> > > > > >
> > > > > > The last patch adds a check in the linker script to ensure that no
> > > > > > runtime relocations get reintroduced. Since the GOT has been eliminated
> > > > > > as well, the compressed kernel has no runtime relocations whatsoever any
> > > > > > more.
> > > > > >
> > > > > > Changes from v1:
> > > > > > - Add .text.* to setup.ld instead of just .text.startup
> > > > > > - Rename the la() macro introduced in the second patch for 64-bit to
> > > > > >   rva(), and rework the explanatory comment.
> > > > > > - In the last patch, check both .rel.dyn and .rela.dyn, instead of just
> > > > > >   one per arch.
> > > > > >
> > > > >
> > > > > Hi,
> > > > >
> > > > > I would like to test this patchset v2 on top of Linux v5.7-rc7 together with:
> > > > >
> > > > > [1] x86/boot: Discard .discard.unreachable for arch/x86/boot/compressed/vmlinux
> > > > > [2] x86/boot: Correct relocation destination on old linkers
> > > > >
> > > > > I tried to pull efi/next on top of Linux v5.7-rc7 and cleaned up the
> > > > > merge problems, but I am not sure I did it correctly.
> > > > > So, which patches are really relevant from efi/next?
> > > > >
> > > > > What's your suggestions?
> > > > >
> > > >
> > > > efi/next is here:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next
> > > >
> > > > You'll need the top 3 patches.
> > >
> > > Thanks /o\.
> > >
> > > - Sedat -
> >
> > Are those diffs correct when using "x86/boot: Correct relocation
> > destination on old linkers"?
> >
> > $ cat ../head_32_S.diff
> > diff --cc arch/x86/boot/compressed/head_32.S
> > index 064e895bad92,03557f2174bf..000000000000
> > --- a/arch/x86/boot/compressed/head_32.S
> > +++ b/arch/x86/boot/compressed/head_32.S
> > @@@ -49,13 -49,17 +49,14 @@@
> >    * Position Independent Executable (PIE) so that linker won't optimize
> >    * R_386_GOT32X relocation to its fixed symbol address.  Older
> >    * linkers generate R_386_32 relocations against locally defined symbols,
> > -  * _bss, _ebss, in PIE.  It isn't wrong, just suboptimal compared
> >  - * _bss, _ebss, _got, _egot and _end, in PIE.  It isn't wrong, just less
> >  - * optimal than R_386_RELATIVE.  But the x86 kernel fails to properly handle
> > ++ * _bss, _ebss, _end in PIE.  It isn't wrong, just suboptimal compared
> >  + * to R_386_RELATIVE.  But the x86 kernel fails to properly handle
> >    * R_386_32 relocations when relocating the kernel.  To generate
> > -  * R_386_RELATIVE relocations, we mark _bss and _ebss as hidden:
> >  - * R_386_RELATIVE relocations, we mark _bss, _ebss, _got, _egot and _end as
> >  - * hidden:
> > ++ * R_386_RELATIVE relocations, we mark _bss, _ebss and _end as hidden:
> >    */
> >         .hidden _bss
> >         .hidden _ebss
> >  -      .hidden _got
> >  -      .hidden _egot
> > +       .hidden _end
> >
> >         __HEAD
> >   SYM_FUNC_START(startup_32)
> >
> > $ cat ../head_64_S.diff
> > diff --cc arch/x86/boot/compressed/head_64.S
> > index 4b7ad1dfbea6,76d1d64d51e3..000000000000
> > --- a/arch/x86/boot/compressed/head_64.S
> > +++ b/arch/x86/boot/compressed/head_64.S
> > @@@ -40,34 -40,11 +40,35 @@@
> >    */
> >         .hidden _bss
> >         .hidden _ebss
> >  -      .hidden _got
> >  -      .hidden _egot
> > +       .hidden _end
> >
> >         __HEAD
> >  +
> >  +/*
> >  + * This macro gives the relative virtual address of X, i.e. the offset of X
> >  + * from startup_32. This is the same as the link-time virtual address of X,
> >  + * since startup_32 is at 0, but defining it this way tells the
> >  + * assembler/linker that we do not want the actual run-time address of X. This
> >  + * prevents the linker from trying to create unwanted run-time relocation
> >  + * entries for the reference when the compressed kernel is linked as PIE.
> >  + *
> >  + * A reference X(%reg) will result in the link-time VA of X being stored with
> >  + * the instruction, and a run-time R_X86_64_RELATIVE relocation entry that
> >  + * adds the 64-bit base address where the kernel is loaded.
> >  + *
> >  + * Replacing it with (X-startup_32)(%reg) results in the offset being stored,
> >  + * and no run-time relocation.
> >  + *
> >  + * The macro should be used as a displacement with a base register containing
> >  + * the run-time address of startup_32 [i.e. rva(X)(%reg)], or as an immediate
> >  + * [$ rva(X)].
> >  + *
> >  + * This macro can only be used from within the .head.text section, since the
> >  + * expression requires startup_32 to be in the same section as the code being
> >  + * assembled.
> >  + */
> >  +#define rva(X) ((X) - startup_32)
> >  +
> >         .code32
> >   SYM_FUNC_START(startup_32)
> >         /*
> >
> > Thanks.
> >
>
> With LLVM/Clang/LLD I see:
>
>   mycompiler -Wp,-MD,arch/x86/boot/compressed/.kernel_info.o.d
> -nostdinc -isystem
> /home/dileks/src/llvm-toolchain/install/lib/clang/10.0.1rc1/include
> -I./arch/x86/include -I./arch/x86/include/generated  -I./include
> -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi
> -I./include/uapi -I./include/generated/uapi -include
> ./include/linux/kconfig.h -D__KERNEL__ -Qunused-arguments -m64 -O2
> -fno-strict-aliasing -fPIE -DDISABLE_BRANCH_PROFILING -mcmodel=small
> -mno-mmx -mno-sse -ffreestanding -fno-stack-protector
> -Wno-address-of-packed-member -Wno-gnu -Wno-pointer-sign
> -fmacro-prefix-map=./= -fno-asynchronous-unwind-tables -include
> hidden.h -D__ASSEMBLY__    -c -o
> arch/x86/boot/compressed/kernel_info.o
> arch/x86/boot/compressed/kernel_info.S
> <built-in>:345:10: fatal error: 'hidden.h' file not found
> #include "hidden.h"
>          ^~~~~~~~~~
> 1 error generated.
> make[5]: *** [scripts/Makefile.build:349:
> arch/x86/boot/compressed/kernel_info.o] Error 1
> make[4]: *** [arch/x86/boot/Makefile:114:
> arch/x86/boot/compressed/vmlinux] Error 2
> make[4]: *** Waiting for unfinished jobs....
>
> mycompiler is a wrapper-script to use ccache * clang-10 as compiler.
>
> patchset to previous build:
>
> $ git log --no-merges --oneline 5.7.0-rc7-1-amd64-clang..5.7.0-rc7-2-amd64-clang
> 8b74901cb9e5 (for-5.7/x86-boot-remove-runtime-relocations-from-compressed-kernel-v2-nivedita76)
> x86/boot: Check that there are no runtime relocations
> 83fb1bc3b076 x86/boot: Remove runtime relocations from head_{32,64}.S
> fede23dacbbd x86/boot: Remove run-time relocations from .head.text code
> 3e5ea481b8fb x86/boot: Add .text.* to setup.ld
> bec910ba3d67 x86/boot/compressed: Get rid of GOT fixup code
> be834cee6f39 x86/boot/compressed: Force hidden visibility for all
> symbol references
> 9b7c7d8d2d7b x86/boot/compressed: Move .got.plt entries out of the .got section
> ba6a49f806a0 (for-5.7/kbuild-compressed-debug-info) Makefile: support
> compressed debug info
> a1fb11944d11 (for-5.7/x86-boot-nivedita76) x86/boot: Correct
> relocation destination on old linkers
> c70e3890058f (for-5.7/x86-build-maskray) x86/boot: Discard
> .discard.unreachable for arch/x86/boot/compressed/vmlinux
>
> $ find ./ -name hidden.h
> ./drivers/firmware/efi/libstub/hidden.h
> ./arch/x86/boot/compressed/hidden.h
>
> Any thoughts?
>

Maybe this should be:

[ arch/x86/boot/compressed/Makefile ]

-KBUILD_CFLAGS += -include hidden.h
+KBUILD_CFLAGS += -include ./hidden.h

- Sedat -
