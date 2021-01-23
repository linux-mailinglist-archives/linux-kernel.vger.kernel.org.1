Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4316D30120A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 02:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbhAWBdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 20:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbhAWBdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 20:33:36 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BFAC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 17:32:55 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id n10so4997636pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 17:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3hL4W9QXu159ZfoQL3nATF1a2LioZFfMtSd5lOSpXg=;
        b=okvjTCiTKeMVWpvv2qJSU0+HHjcwIFlZSiP7v0P03js4BRBDcKRqKF8Kyr4kFDjh9G
         9G+qcDOiHqI+tKk3TJTwcp0LPow2PnVV3xCkYOWChxo2SnPFNMtE4WtXsCw2dSdoVXlL
         mkKUGdshD2viuBhFRVAedlQObZcErltu5qL1vKZMesP965xLW8BHdRRwQ/pAE48z7DAG
         roTVVG3LTkt/WyFk0eRMMkSw5yCeQo5GrBk1srV1/Kysxtgr+2lEnRBsK9pZEPJJsLya
         o8OPI30VTLAn78xUwv7w+/GE8YtngpJ6VyNhCnXCxudB2lVXBbmIskzfRwG3LipT3mqk
         3leA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3hL4W9QXu159ZfoQL3nATF1a2LioZFfMtSd5lOSpXg=;
        b=PkQ9PnR49OtWx4pvcevL5RaHwUlPM8He9Z9URNSwjPVKvfZijqRu2IjT1Wc9nPKWKp
         IjY4enUH9jKT6XKUUi+eHUUWibu7FCkWeoLEj+P17f0/+gNKxx+rwN0VihlXWSlYt4Iq
         QtQNmbb8w/DqJhUh7mlgbc+wzYa8k3xW6sUPibnhkhkqcPMPZfT3cCv9YZS4MNsRdHP8
         TInodfHr7xZx1+3BixdlAey3OpvrcqTQt+p6GeVnR+j99wTeVlBts6pPY2qASt6GbtPL
         DQ8g1c0GQlEFhM8jjgUosEm2onfew9CgpuAFQlk8zrIZUI/dYbMuT8TDjeiuCzjx8O/L
         /dwg==
X-Gm-Message-State: AOAM530eP5z1GWAp9tbZjQEUX9M4MU0wkVX7X0HP0J1TlS3AYKAILi/e
        dIy+CcqFp5Sgypv9wOsqWRqJfOzLgCROwHLae1POgA==
X-Google-Smtp-Source: ABdhPJx4jRsCEpOG0QkJzh6mRf+I7yRdSkA71rXSp+iz2i/vlg+k+8skFfI6B7fkhKLAfv4CM+sWF50iwWGHtYFwQe0=
X-Received: by 2002:a63:1f47:: with SMTP id q7mr7460046pgm.10.1611365575148;
 Fri, 22 Jan 2021 17:32:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611263461.git.jpoimboe@redhat.com> <CA+icZUU6QBeahDWpgYPjkf_OmRC+4T4SAnCg=iObNq9+CGT6jA@mail.gmail.com>
 <20210122154158.lylubqugmcxehugg@treble> <CABCJKueaW1BEEBKLQzyp77VwTL+bE4x=kOLV3TWmc1s6-r3PeQ@mail.gmail.com>
In-Reply-To: <CABCJKueaW1BEEBKLQzyp77VwTL+bE4x=kOLV3TWmc1s6-r3PeQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 22 Jan 2021 17:32:43 -0800
Message-ID: <CAKwvOdkcoCFKD63xtQzRdFikDk-GUUfUG5EEKiCTA3cueEZQNA@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] objtool: vmlinux.o and CLANG LTO support
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Fangrui Song <maskray@google.com>,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 1:17 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Hi Josh,
>
> On Fri, Jan 22, 2021 at 7:42 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Thu, Jan 21, 2021 at 11:38:54PM +0100, Sedat Dilek wrote:
> > > On Thu, Jan 21, 2021 at 10:29 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > >
> > > > v2:
> > > > - fix commit description for why xen hypervisor page contents don't
> > > >   matter [Juergen]
> > > > - annotate indirect jumps as safe instead of converting them to
> > > >   retpolines [Andrew, Juergen]
> > > > - drop patch 1 - fake jumps no longer exist
> > > > - add acks
> > > >
> > > > Based on tip/objtool/core.
> > > >
> > > >
> > > > Add support for proper vmlinux.o validation, which will be needed for
> > > > Sami's upcoming x86 LTO set.  (And vmlinux validation is the future for
> > > > objtool anyway, for other reasons.)
> > > >
> > > > This isn't 100% done -- most notably, crypto still needs to be supported
> > > > -- but I think this gets us most of the way there.
> > > >
> > > > This can also be found at
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux
> > > >
> > >
> > > Should this be s/objtool-vmlinux/objtool-vmlinux-v2 ?
> >
> > Indeed:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux-v2
>
> I tested v2 on top of the LTO tree and with allyesconfig + relevant
> crypto configs disabled, and I only see the warnings I reported
> earlier.
>
> I also tested this on top of the CFI tree and with LTO+CFI enabled, I
> can reproduce the segfault Sedat reported in the previous thread. This
> happens because find_unsuffixed_func is called with a NULL sym in
> read_relocs:
>
> Program received signal SIGSEGV, Segmentation fault.
> find_unsuffixed_func (elf=elf@entry=0x7ffff55a5010, sym=0x0,
> suffix=0x416cbf ".cfi_jt", func=func@entry=0x7fffffffd5f0) at
> elf.c:274
> 274             loc = strstr(sym->name, suffix);
> (gdb) bt
> #0  find_unsuffixed_func (elf=elf@entry=0x7ffff55a5010, sym=0x0,
> suffix=0x416cbf ".cfi_jt", func=func@entry=0x7fffffffd5f0) at
> elf.c:274
> #1  0x000000000040d8f8 in read_relocs (elf=0x7ffff55a5010) at elf.c:637
> ...
>
> In this specific case, find_func_by_offset returns NULL for
> .text..L.cfi.jumptable.43 at addend 0x8, because Clang doesn't emit
> jump table symbols for static functions:
>
> 0000000000000000 <__typeid__ZTSFjmiE_global_addr>:
>    0:   e9 00 00 00 00          jmpq   5 <__typeid__ZTSFjmiE_global_addr+0x5>
>                         1: R_X86_64_PLT32       io_serial_in-0x4
>    5:   cc                      int3
>    6:   cc                      int3
>    7:   cc                      int3
>    8:   e9 00 00 00 00          jmpq   d <__typeid__ZTSFjmiE_global_addr+0xd>
>                         9: R_X86_64_PLT32       mem32_serial_in-0x4
>    d:   cc                      int3
>    e:   cc                      int3
>    f:   cc                      int3
>
> Nick, do you remember if there were plans to change this?

Do you have a link to any previous discussion to help jog my mind; I
don't really remember this one.

Is it that `__typeid__ZTSFjmiE_global_addr` is the synthesized jump
table, and yet there is no `__typeid__ZTSFjmiE_global_addr` entry in
the symbol table?
-- 
Thanks,
~Nick Desaulniers
