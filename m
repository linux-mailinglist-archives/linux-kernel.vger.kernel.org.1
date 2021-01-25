Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022AD302F58
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 23:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbhAYWq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 17:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732458AbhAYWoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 17:44:23 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D3DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 14:43:42 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id 43so4975917uag.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 14:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJqD3Ld7l3viyoQkm5VOgrbWfrIZ+ljq8B5I09iFpu0=;
        b=P4ofq9I75lotxCWpd+qzaE0PMx6BRULx+ZTzAZCDLS0pf+UajuD0qCXjRf3i0pTiRm
         JGTiyZ8a7wr/DcJa8PkSVg/qyWqNRvMh3P5YaVCfH4Z72JLk914uVOEUL2g4bDNMYrgW
         AiFXueKaWB0gsN5FWlep57dLMHBuFj26pKX07g8NH5Aid81hVJkslRqHPROe0tJ9MRKi
         KLu+zOrojRbVKI5zgUyoxMpqzgPsSjyX/TjKgeCqYdTcO9DJKhydj+6HTekeMTqn+9fs
         4HyaQ3FRIeTrHw7SQEA8c/SAa3YSzmC9cxw5qwGb0/HJrlyLsjRw/+wr9QdvwnpbEm0t
         bRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJqD3Ld7l3viyoQkm5VOgrbWfrIZ+ljq8B5I09iFpu0=;
        b=QbHkIURrcEPMM+x2h41Di2XGUfaJGKKsVHCJAgJ0xA9dy9GNuhR5jwWkDXbwOM5Cv0
         hDxGRtUvoUmtDLM5ssEIhpGwpPsG+lIrq07Umjvy1UlqVwEwzxh1QL39XCAU3elwMFYs
         Jd0FKlb1oL3EVeKlrX90+65cVVZCiVwKggJyv6Ad/Of7iv763fcVnvmUZwf7CqrS7IKB
         9fgNbxZQwLa+qvfzETaIr6wGF5F2aFxsabzSjqkejFrwSgS51R6+O8NrhL/ls+NJwndy
         vuvazPx5QXt3Zv4zb05vQ7/rae7mMp8s9l/C+VbvAWg82DK97MAaIntPLWehi0T7LjVW
         Dunw==
X-Gm-Message-State: AOAM531mis/N9skK3AauRXjzHtg/w0doePNz94dqMEpgZ07mTuXPp9rz
        Xb8/OVVz8fxFBMHsnyOMYad1dy/FAkdtaiToyanLIQ==
X-Google-Smtp-Source: ABdhPJzRwms83S1ZHvG0Toe7Sszv7JGr5sZrNJJxPBbsOFOue7lDNEQ8Rl9EZ/++/2MhvhleQzwxh9BUuxo0MiM2SRI=
X-Received: by 2002:a9f:2286:: with SMTP id 6mr2324760uan.66.1611614621837;
 Mon, 25 Jan 2021 14:43:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611263461.git.jpoimboe@redhat.com> <CA+icZUU6QBeahDWpgYPjkf_OmRC+4T4SAnCg=iObNq9+CGT6jA@mail.gmail.com>
 <20210122154158.lylubqugmcxehugg@treble> <CABCJKueaW1BEEBKLQzyp77VwTL+bE4x=kOLV3TWmc1s6-r3PeQ@mail.gmail.com>
 <CAKwvOdkcoCFKD63xtQzRdFikDk-GUUfUG5EEKiCTA3cueEZQNA@mail.gmail.com> <20210123022609.n7xsj2a4potoijz7@treble>
In-Reply-To: <20210123022609.n7xsj2a4potoijz7@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 25 Jan 2021 14:43:30 -0800
Message-ID: <CABCJKucsYknH2z8ypGoBEpNwhdy+LpT_8N2jw+14ToLJ5ps+HQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] objtool: vmlinux.o and CLANG LTO support
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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

On Fri, Jan 22, 2021 at 6:26 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Jan 22, 2021 at 05:32:43PM -0800, Nick Desaulniers wrote:
> > > In this specific case, find_func_by_offset returns NULL for
> > > .text..L.cfi.jumptable.43 at addend 0x8, because Clang doesn't emit
> > > jump table symbols for static functions:
> > >
> > > 0000000000000000 <__typeid__ZTSFjmiE_global_addr>:
> > >    0:   e9 00 00 00 00          jmpq   5 <__typeid__ZTSFjmiE_global_addr+0x5>
> > >                         1: R_X86_64_PLT32       io_serial_in-0x4
> > >    5:   cc                      int3
> > >    6:   cc                      int3
> > >    7:   cc                      int3
> > >    8:   e9 00 00 00 00          jmpq   d <__typeid__ZTSFjmiE_global_addr+0xd>
> > >                         9: R_X86_64_PLT32       mem32_serial_in-0x4
> > >    d:   cc                      int3
> > >    e:   cc                      int3
> > >    f:   cc                      int3
> > >
> > > Nick, do you remember if there were plans to change this?
> >
> > Do you have a link to any previous discussion to help jog my mind; I
> > don't really remember this one.
> >
> > Is it that `__typeid__ZTSFjmiE_global_addr` is the synthesized jump
> > table, and yet there is no `__typeid__ZTSFjmiE_global_addr` entry in
> > the symbol table?
>
> I think he means there's not a 'mem32_serial_in.cfi_jt' symbol at
> '__typeid__ZTSFjmiE_global_addr+8'.  Probably more aggressive symbol
> pruning from the assembler.

Correct, the compiler is not emitting mem32_serial_in.cfi_jt here. I
seem to recall that the missing jump table symbols also made stack
traces harder to follow (__typeid__ZTSFjmiE_global_addr+8 is not very
readable), so ideally they shouldn't be pruned.

> It's fine though.  I just need to rewrite the CFI support a bit.
>
> But that can come later.  For now I'll just drop the two CFI-related
> patches from this set so I can merge the others next week.

Sure, sounds good.

Sami
