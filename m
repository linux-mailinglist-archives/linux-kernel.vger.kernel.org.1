Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F84300EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbhAVVTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730519AbhAVVSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 16:18:21 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB16C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 13:17:40 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id s2so3825151vsk.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 13:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sk3+j83/KSEJTb6TEvM8GbjRjDbTnWMuzmzS+vYhd84=;
        b=jJ41Rsfkz3o0MWv4IJWTXq63mHmfaX+BJkU+/fys2gbnzcIFGWCp714VRTvbhS3k0J
         MucsMji+/CjfFQsvjWTyn9RLylFpFg92dEtUpPVED1/A1NJgH57tUHtEs/SmUJE2l6Lb
         ldtys/UM/dRWqFxePYOFSDzG0Qq/oLsOIL/XvuYNTAW1mGhZ+7BAalAXflPmCpmKwp5/
         i3v/2I0fIrToYHFfPTh20dfBMPWlpij9MeYYk13c7awPZfiukdYWfEMj3wA15x6Yo4fG
         cM0yNx31H7cPyHo7oye/6bhmFcjnVrcyubUZFff1VU74EcN+veJ+JNXUmyvWyT47jnkB
         4DgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sk3+j83/KSEJTb6TEvM8GbjRjDbTnWMuzmzS+vYhd84=;
        b=eEOtRS1grQOxh5YjIysq/sf5Al5s4H2VNqduGZcZcSuOWdvEO3URfHEzmeHFkUqNsY
         rZZd+P7bEcptF0UL8rMKdqlQ7QzRBAf21uOdjBJ5K4iOUEvPi8PJfcY0z9NhUTVW/mGG
         vt9GuXZcFXvJnOlX98jji8vmHw+C7ycyEqv10eQib09RJfdpKVQ3RMmMV+8Md2iqYqPo
         u6Miguylbci4f9gkTYgW9AKcI8qJPkiugKfQRzTLrBikZa1vibPfFAZW5dgDWgSv6xwm
         kthEOKShylbP0eaOPeFyu4h5HEu1eUYqU8Hti0kr3G5WCALGcG4mgh6mgI38VO+xEqsQ
         kzxw==
X-Gm-Message-State: AOAM532SKvla0Ov+CWSyO4Q0id8k7sl35RRINsCvIpfZIi7ykVTChHmz
        uYXhkx90LhDe2Z83wTkONFxkNHMvaVFQGl1YSIgYgWAVukwbGA==
X-Google-Smtp-Source: ABdhPJyFuWiXZnDfYREwtCshf8AwKAeVe7zt6frjpZGSKkASAFE4DohX80O/vcb+lvhbKnH2qSQoGBfgUtFEESQUnxA=
X-Received: by 2002:a67:7956:: with SMTP id u83mr688634vsc.54.1611350259494;
 Fri, 22 Jan 2021 13:17:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611263461.git.jpoimboe@redhat.com> <CA+icZUU6QBeahDWpgYPjkf_OmRC+4T4SAnCg=iObNq9+CGT6jA@mail.gmail.com>
 <20210122154158.lylubqugmcxehugg@treble>
In-Reply-To: <20210122154158.lylubqugmcxehugg@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 22 Jan 2021 13:17:28 -0800
Message-ID: <CABCJKueaW1BEEBKLQzyp77VwTL+bE4x=kOLV3TWmc1s6-r3PeQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] objtool: vmlinux.o and CLANG LTO support
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On Fri, Jan 22, 2021 at 7:42 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Jan 21, 2021 at 11:38:54PM +0100, Sedat Dilek wrote:
> > On Thu, Jan 21, 2021 at 10:29 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > v2:
> > > - fix commit description for why xen hypervisor page contents don't
> > >   matter [Juergen]
> > > - annotate indirect jumps as safe instead of converting them to
> > >   retpolines [Andrew, Juergen]
> > > - drop patch 1 - fake jumps no longer exist
> > > - add acks
> > >
> > > Based on tip/objtool/core.
> > >
> > >
> > > Add support for proper vmlinux.o validation, which will be needed for
> > > Sami's upcoming x86 LTO set.  (And vmlinux validation is the future for
> > > objtool anyway, for other reasons.)
> > >
> > > This isn't 100% done -- most notably, crypto still needs to be supported
> > > -- but I think this gets us most of the way there.
> > >
> > > This can also be found at
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux
> > >
> >
> > Should this be s/objtool-vmlinux/objtool-vmlinux-v2 ?
>
> Indeed:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux-v2

I tested v2 on top of the LTO tree and with allyesconfig + relevant
crypto configs disabled, and I only see the warnings I reported
earlier.

I also tested this on top of the CFI tree and with LTO+CFI enabled, I
can reproduce the segfault Sedat reported in the previous thread. This
happens because find_unsuffixed_func is called with a NULL sym in
read_relocs:

Program received signal SIGSEGV, Segmentation fault.
find_unsuffixed_func (elf=elf@entry=0x7ffff55a5010, sym=0x0,
suffix=0x416cbf ".cfi_jt", func=func@entry=0x7fffffffd5f0) at
elf.c:274
274             loc = strstr(sym->name, suffix);
(gdb) bt
#0  find_unsuffixed_func (elf=elf@entry=0x7ffff55a5010, sym=0x0,
suffix=0x416cbf ".cfi_jt", func=func@entry=0x7fffffffd5f0) at
elf.c:274
#1  0x000000000040d8f8 in read_relocs (elf=0x7ffff55a5010) at elf.c:637
...

In this specific case, find_func_by_offset returns NULL for
.text..L.cfi.jumptable.43 at addend 0x8, because Clang doesn't emit
jump table symbols for static functions:

0000000000000000 <__typeid__ZTSFjmiE_global_addr>:
   0:   e9 00 00 00 00          jmpq   5 <__typeid__ZTSFjmiE_global_addr+0x5>
                        1: R_X86_64_PLT32       io_serial_in-0x4
   5:   cc                      int3
   6:   cc                      int3
   7:   cc                      int3
   8:   e9 00 00 00 00          jmpq   d <__typeid__ZTSFjmiE_global_addr+0xd>
                        9: R_X86_64_PLT32       mem32_serial_in-0x4
   d:   cc                      int3
   e:   cc                      int3
   f:   cc                      int3

Nick, do you remember if there were plans to change this?

Sami
