Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F55930124A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 03:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbhAWCcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 21:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbhAWCcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 21:32:14 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9DCC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 18:31:32 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id u8so2117309ior.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 18:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=aLpw1LHQsTr697eUnxuw9pSJGbdpbEVLuAyBGxjgo50=;
        b=Lqv7dKFco2O7bq9WL5UMFhEGscEa/nA+tMqF9YN/yObvhWLEM7RoXsJXOtAg1ODdl9
         nnPiyCBYr8XunF5zDb0O/IyfoBBH1ISzayaMTsMd/00i6QL/cNv5DQWzXE/hsaW5oUkc
         ukiVHEymR9Cezm3eTqm25uyo9zqE3R6K+9cuWqhxovJURU6wAAuQr9FPE8kzl5n8hn2L
         AuLm7sl7yiqbLcK+1xxWtvDSrQyEvj6U6480cr96krKeRWGJ9NQAGescuX4AQMc/rfG3
         VuCCN6eNa/H5ANrKrW9N213T7tNcZMHogFEBvSUu+JuzC5Hf2qR2u/FRE9c12lXcWs59
         FoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=aLpw1LHQsTr697eUnxuw9pSJGbdpbEVLuAyBGxjgo50=;
        b=WSzfepmmlmQFrieJLjankkdCFmq1Ysgg0rwmyDbMxNamQ+2KAT9wzyG9RXDInG2Erv
         Db+fCoCO5lMBlK1hLnFe0Hm+mIPngzO/WJ8tjCF/broF1Gw9x7XAqaFsLcX/df4GzCox
         5nCz5qKl8X5FioXZKy1HO3Sfr+1ogQZxeuBH1x7caTvfoQcDNAsiyJ1IPBOzVoDLPkqU
         DJB2dP8UD845Vgmu6o/cFV6t1MwWtSp9PYt8FfiiqeoKpDLNY1zbFulbnz5C5dh9Llc7
         Zfjz6hj536jjLjzZNy4DQGuq2inTQf/pl8NRy1Q/0qBgMV5k6QbTjV+t/hjMJkxaGNOr
         GbuA==
X-Gm-Message-State: AOAM531WIjGnabCy9QOxNsCFYX9nqv39Y57lbwLTZkhzus4wjKYcI/Ub
        1Qhxej0HeWJ8w481pg+j5BBneqD5wxgCmixtOao=
X-Google-Smtp-Source: ABdhPJxBZkpLa8xhqDbOjSeQLEYm2ZE+1RxwEOXL7xq2+NRSiVOLhaSgNKUt6rHQTHDA5DjMHG+9tSg7sAXjSLHcXfk=
X-Received: by 2002:a5e:970c:: with SMTP id w12mr2421225ioj.171.1611369091823;
 Fri, 22 Jan 2021 18:31:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611263461.git.jpoimboe@redhat.com> <CA+icZUU6QBeahDWpgYPjkf_OmRC+4T4SAnCg=iObNq9+CGT6jA@mail.gmail.com>
 <20210122154158.lylubqugmcxehugg@treble> <CABCJKueaW1BEEBKLQzyp77VwTL+bE4x=kOLV3TWmc1s6-r3PeQ@mail.gmail.com>
 <CAKwvOdkcoCFKD63xtQzRdFikDk-GUUfUG5EEKiCTA3cueEZQNA@mail.gmail.com> <20210123022609.n7xsj2a4potoijz7@treble>
In-Reply-To: <20210123022609.n7xsj2a4potoijz7@treble>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 23 Jan 2021 03:31:20 +0100
Message-ID: <CA+icZUX9mYAFE6aFdmGS+rnJbeBMMMeVBrSs_pC6ragzXCjT7w@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] objtool: vmlinux.o and CLANG LTO support
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
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

On Sat, Jan 23, 2021 at 3:26 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
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
>
> It's fine though.  I just need to rewrite the CFI support a bit.
>
> But that can come later.  For now I'll just drop the two CFI-related
> patches from this set so I can merge the others next week.
>

Two CFI-related patches?

What's the other than "objtool: Add CONFIG_CFI_CLANG support"?

Do you plan (or offer) a v3 of objtool-vmlinux?

Thanks.

- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?h=objtool-vmlinux-v2&id=d743f4b36e120c06506567a9f87a062ae03da47f
