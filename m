Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145122D72DE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405633AbgLKJda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390353AbgLKJcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:32:54 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB35C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 01:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7OVhj6W6MkbLnBXMn6qYLE3zg+jhYzQkB5fOP6g9zFs=; b=OYF9TEoXIODxjXnYUsOpAeNBkV
        48Joy2f3GgfLb+Qol17GQ2eGAJR1fWwA2uB297gJYcPK6z8xdedAA6tT6YWgY3tcR8EXTQRisJpTX
        pBhy0H6anO6X5Fp4b6w5Wm9lToclajqfoOTamdgeTQuUhl1N31tPAgwv+RGiVU3aX8fbbAiAOHFkM
        AzoS4gchk7K2lGXbb18LXesinluRGaJoGBmoUMyePEOTnOXHR4F/aAa5S0tpRRoI/k9gI3zohwTty
        mET0UVNVfj7mwmzEjOr/yYY1CL7bt1m3Ywes75bdGJ2M+SNJt6XM4U8CH2BT3/ZpYPN7NUjZybZtZ
        /Idh7beg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knemV-0007zw-ST; Fri, 11 Dec 2020 09:32:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A21B3007CD;
        Fri, 11 Dec 2020 10:32:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52A2621AA28E6; Fri, 11 Dec 2020 10:32:05 +0100 (CET)
Date:   Fri, 11 Dec 2020 10:32:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: objtool crashes with some clang produced .o files
Message-ID: <20201211093205.GU2414@hirez.programming.kicks-ass.net>
References: <CAK8P3a20LXgEQkYSpbFFrJs1mdg19W72dp3pbebH9Pkpib2g-g@mail.gmail.com>
 <CAKwvOdn79V-jaTH0mEtKyc-O+=Hj22bGtjKkZ1jriY2YABj-Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn79V-jaTH0mEtKyc-O+=Hj22bGtjKkZ1jriY2YABj-Lw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 03:35:45PM -0800, Nick Desaulniers wrote:

> > $ echo "__SCK__tp_func_cdev_update() { __SCT__tp_func_cdev_update(); }" > file.c

> > $ clang-12 -S file.c -O2 -fno-asynchronous-unwind-tables -o-
> > .text
> > .file "file.c"
> > .globl __SCK__tp_func_cdev_update      # -- Begin function
> > __SCK__tp_func_cdev_update
> > .p2align 4, 0x90
> > .type __SCK__tp_func_cdev_update,@function
> > __SCK__tp_func_cdev_update:             # @__SCK__tp_func_cdev_update
> > # %bb.0:
> > xorl %eax, %eax
> > jmp __SCT__tp_func_cdev_update      # TAILCALL
> > .Lfunc_end0:
> > .size __SCK__tp_func_cdev_update, .Lfunc_end0-__SCK__tp_func_cdev_update
> >                                         # -- End function
> > .ident "Ubuntu clang version
> > 12.0.0-++20201129052612+ce134da4b18-1~exp1~20201129163253.238"
> > .section ".note.GNU-stack","",@progbits
> > .addrsig

> (gdb) b tools/objtool/check.c:475
> (gdb) r orc generate file.o
> Breakpoint 1, create_static_call_sections (file=0x41f478 <file>) at check.c:475
> 475                     reloc->sym = insn->sec->sym;
> (gdb) p insn->sec->sym
> $4 = (struct symbol *) 0x0
> (gdb) p insn->sec->name
> $5 = 0xc22d26 ".text"
> 
> So some instruction in .text that contained a relocation for, we could
> not determine a symbol for?

Ooh, cute that's weird. So it's trying to write a relocation to the
site that does (IOW fill static_call_site::addr):

  CALL/JMP __SCT*

and that's failing, because the instruction's section doesn't have a
symbol.

Both my GCC and clang-11 get me:

(gdb) p insn->sec->sym
$1 = (struct symbol *) 0x555555d83a70
(gdb) p insn->sec->sym->name
$2 = 0x555555d82f46 ".text"

Looking at elf.c, it seems we're missing an STT_SECTION symbol for
.text.

And indeed, when I add -fno-asynchronous-unwind-tables to clang-11, that
goes missing from the readelf .symtab listing. Help ?!
