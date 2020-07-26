Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62DD22E11E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 18:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgGZQGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 12:06:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgGZQGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:06:33 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF0002078E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 16:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595779592;
        bh=jOlSd937RAl4IikqYHXqep9iyrxRMosx470QDWX0F5o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HMnGZGZ8zFPNbKdaNkL5nkkSM8jRMIAHhiqCpnnztcLsnfOizEu4MyxHX3/PY48kQ
         OKSriRyt3KRRiQEY7MQd/UvJ5SEe1uW/4kpCx6/OlGtmxNSrIN7a+JuuZitRc8QarT
         57nOy9ojB0zNJZSlav9+3RAnApxBHr7GhgYpBqNU=
Received: by mail-ot1-f53.google.com with SMTP id n24so10540623otr.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 09:06:32 -0700 (PDT)
X-Gm-Message-State: AOAM5326FiEvrjQMz//MgdiLTLU2VJnZgMnF0yXYXAnxx/faujWBxxF4
        562fyR84P5h9Yg9m3upyk38drFU5xogW7ieXPqE=
X-Google-Smtp-Source: ABdhPJyLC8hHAzofnQu2h1FVAUiDveA5YPbaDCm/F/ft2ehbXBb05JTdDqOZFfW7sdjm1unxLObM5+FL1usYgX7CE+k=
X-Received: by 2002:a05:6830:1094:: with SMTP id y20mr5572348oto.90.1595779591988;
 Sun, 26 Jul 2020 09:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-6-jarkko.sakkinen@linux.intel.com>
 <20200724092746.GD517988@gmail.com> <20200725031648.GG17052@linux.intel.com> <20200726081408.GB2927915@kernel.org>
In-Reply-To: <20200726081408.GB2927915@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 26 Jul 2020 19:06:20 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHDK5RSbTu3SG1AzbLRJD_FsdAmCnjmf31P=Db6J0ktww@mail.gmail.com>
Message-ID: <CAMj1kXHDK5RSbTu3SG1AzbLRJD_FsdAmCnjmf31P=Db6J0ktww@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] kprobes: Use text_alloc() and text_free()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020 at 11:14, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Sat, Jul 25, 2020 at 06:16:48AM +0300, Jarkko Sakkinen wrote:
> > On Fri, Jul 24, 2020 at 11:27:46AM +0200, Ingo Molnar wrote:
> > >
> > > * Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > >
> > > > Use text_alloc() and text_free() instead of module_alloc() and
> > > > module_memfree() when an arch provides them.
> > > >
> > > > Cc: linux-mm@kvack.org
> > > > Cc: Andi Kleen <ak@linux.intel.com>
> > > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > ---
> > > >  kernel/kprobes.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > > index 4e46d96d4e16..611fcda9f6bf 100644
> > > > --- a/kernel/kprobes.c
> > > > +++ b/kernel/kprobes.c
> > > > @@ -40,6 +40,7 @@
> > > >  #include <asm/cacheflush.h>
> > > >  #include <asm/errno.h>
> > > >  #include <linux/uaccess.h>
> > > > +#include <linux/vmalloc.h>
> > > >
> > > >  #define KPROBE_HASH_BITS 6
> > > >  #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
> > > > @@ -111,12 +112,20 @@ enum kprobe_slot_state {
> > > >
> > > >  void __weak *alloc_insn_page(void)
> > > >  {
> > > > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > > > + return text_alloc(PAGE_SIZE);
> > > > +#else
> > > >   return module_alloc(PAGE_SIZE);
> > > > +#endif
> > > >  }
> > > >
> > > >  void __weak free_insn_page(void *page)
> > > >  {
> > > > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > > > + text_free(page);
> > > > +#else
> > > >   module_memfree(page);
> > > > +#endif
> > > >  }
> > >
> > > I've read the observations in the other threads, but this #ifdef
> > > jungle is silly, it's a de-facto open coded text_alloc() with a
> > > module_alloc() fallback...
> >
> > In the previous version I had:
> >
> >   https://lore.kernel.org/lkml/20200717030422.679972-4-jarkko.sakkinen@linux.intel.com/
> >
> > and I had just calls to text_alloc() and text_free() in corresponding
> > snippet to the above.
> >
> > I got this feedback from Mike:
> >
> >   https://lore.kernel.org/lkml/20200718162359.GA2919062@kernel.org/
> >
> > I'm not still sure that I fully understand this feedback as I don't see
> > any inherent and obvious difference to the v4. In that version fallbacks
> > are to module_alloc() and module_memfree() and text_alloc() and
> > text_memfree() can be overridden by arch.
>
> Let me try to elaborate.
>
> There are several subsystems that need to allocate memory for executable
> text. As it happens, they use module_alloc() with some abilities for
> architectures to override this behaviour.
>
> For many architectures, it would be enough to rename modules_alloc() to
> text_alloc(), make it built-in and this way allow removing dependency on
> MODULES.
>
> Yet, some architectures have different restrictions for code allocation
> for different subsystems so it would make sense to have more than one
> variant of text_alloc() and a single config option ARCH_HAS_TEXT_ALLOC
> won't be sufficient.
>
> I liked Mark's suggestion to have text_alloc_<something>() and proposed
> a way to introduce text_alloc_kprobes() along with
> HAVE_KPROBES_TEXT_ALLOC to enable arch overrides of this function.
>
> The major difference between your v4 and my suggestion is that I'm not
> trying to impose a single ARCH_HAS_TEXT_ALLOC as an alternative to
> MODULES but rather to use per subsystem config option, e.g.
> HAVE_KPROBES_TEXT_ALLOC.
>
> Another thing, which might be worth doing regardless of the outcome of
> this discussion is to rename alloc_insn_pages() to text_alloc_kprobes()
> because the former is way too generic and does not emphasize that the
> instruction page is actually used by kprobes only.
>

Masami or Peter should correct me if I am wrong, but it seems to me
that the way kprobes uses these pages does not require them to be in
relative branching range of the core kernel on any architecture, given
that they are populated with individual instruction opcodes that are
executed in single step mode, and relative branches are emulated (when
needed)

So for kprobes in particular, we should be able to come up with a
generic sequence that does not involve module_alloc(), and therefore
removes the kprobes dependency on module support entirely (with the
exception of power which maps the vmalloc space nx when module support
is disabled). Renaming alloc_insn_page() to something more descriptive
makes sense imo, but is a separate issue.
