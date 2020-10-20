Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C37293449
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 07:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391646AbgJTFcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 01:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391634AbgJTFcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 01:32:41 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E920C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 22:32:41 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 140so594830qko.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 22:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tRhg7Fh12SyPVOFGorlDmCBp88Lp1yUZv3xhgXyFBzI=;
        b=AUOM4Zio3a90+wklb77MbeVZ7Lll43wASaYbgxrkV/UhuFQiOVmD1b2j5GyrJ6Ueee
         uaesKLavD6mOOe9kQ/687n2ccD9LfB989X0yPAu77nM4bB9K3PcRLBy8dWDtU+S86ch4
         exiebVp2XiEXG3KMFdPBCCp3YvXxSB7TdPPOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRhg7Fh12SyPVOFGorlDmCBp88Lp1yUZv3xhgXyFBzI=;
        b=HRxvknZk425Vx1xKXwUgC1dvYa/NMX2iZyqErMA3EOJlxdvE4ylOuRYHvbuFRSIvor
         v6OyCKZuCollteSVzD/1/lmB2hmUcsg8O3JCOP1JLRd+NAqxdE4YwI+/9nLnLb1uQdJv
         V2nCrGJ0q4gQdMMvrMYQw+cNCs2stFz76C3TrL8Odgye/95uGOWP958b3QYV2FpaHQ8M
         EFe7elJ1K91zZ/XTkl7fKlIk2qEN9tfGE0Tt/oAQa+eZejeYXjx5wbSIOOIL4M/M2B6E
         mp4IGNDMI93fWn5/nY96SRUUiGy/amJuv1AjlpbeByAfCGxqYBPSdzLypyHQBErdlobd
         7D3Q==
X-Gm-Message-State: AOAM530UO5dTB26YojWprHx3t7GDIcdgvCh9NKugbDS5IaS0R2/WSRgk
        ChCuN/7jYPZwjDhFBCHoyW5yng9fEa//6PYfYGo=
X-Google-Smtp-Source: ABdhPJzYczjyTqPBcO5wcx6pKvhWIwF29gqVQ9pIRmq93o/d7ql9w2T41TNu7cJ4WAyvowwA2W0DcN1zLXYtHyF1XbE=
X-Received: by 2002:a37:48cc:: with SMTP id v195mr1293930qka.66.1603171960110;
 Mon, 19 Oct 2020 22:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201001042927.2147800-1-andrew@aj.id.au> <CACPK8XcFhnnY8Q_DYRGo-AuRMxnVzUfCyjxRyAuFO=RSGyK=Sg@mail.gmail.com>
In-Reply-To: <CACPK8XcFhnnY8Q_DYRGo-AuRMxnVzUfCyjxRyAuFO=RSGyK=Sg@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 20 Oct 2020 05:32:26 +0000
Message-ID: <CACPK8XeJzHOH-ErWB8ZZS1rMVcPJx0exjnB-va-vhuvGvwFWCQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: kprobes: Avoid fortify_panic() when copying
 optprobe template
To:     Andrew Jeffery <andrew@aj.id.au>,
        Russell King <linux@armlinux.org.uk>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        mhiramat@kernel.org, labbott@redhat.com,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Oct 2020 at 05:20, Joel Stanley <joel@jms.id.au> wrote:
>
> On Thu, 1 Oct 2020 at 04:30, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Setting both CONFIG_KPROBES=y and CONFIG_FORTIFY_SOURCE=y on ARM leads
> > to a panic in memcpy() when injecting a kprobe despite the fixes found
> > in commit e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with
> > FORTIFY_SOURCE") and commit 0ac569bf6a79 ("ARM: 8834/1: Fix: kprobes:
> > optimized kprobes illegal instruction").
> >
> > arch/arm/include/asm/kprobes.h effectively declares
> > the target type of the optprobe_template_entry assembly label as a u32
> > which leads memcpy()'s __builtin_object_size() call to determine that
> > the pointed-to object is of size four. However, the symbol is used as a handle
> > for the optimised probe assembly template that is at least 96 bytes in size.
> > The symbol's use despite its type blows up the memcpy() in ARM's
> > arch_prepare_optimized_kprobe() with a false-positive fortify_panic() when it
> > should instead copy the optimised probe template into place:
> >
> > ```
> > $ sudo perf probe -a aspeed_g6_pinctrl_probe
> > [  158.457252] detected buffer overflow in memcpy
> >
> > Fixes: e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE")
> > Fixes: 0ac569bf6a79 ("ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction")
> > Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
> > Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>
> Tested-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
>
> Thanks Andrew.
>
> > ---
> > v1 was sent some time back, in May:
> >
> > https://lore.kernel.org/linux-arm-kernel/20200517153959.293224-1-andrew@aj.id.au/

Russell, are you picking this fix up?

Would you prefer it to go through someone else's tree?

Cheers,

Joel

> >
> > I've taken the patch that Kees' suggested in the replies and tested it.
> > ---
> >  arch/arm/include/asm/kprobes.h    | 22 +++++++++++-----------
> >  arch/arm/probes/kprobes/opt-arm.c | 18 +++++++++---------
> >  2 files changed, 20 insertions(+), 20 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
> > index 213607a1f45c..e26a278d301a 100644
> > --- a/arch/arm/include/asm/kprobes.h
> > +++ b/arch/arm/include/asm/kprobes.h
> > @@ -44,20 +44,20 @@ int kprobe_exceptions_notify(struct notifier_block *self,
> >                              unsigned long val, void *data);
> >
> >  /* optinsn template addresses */
> > -extern __visible kprobe_opcode_t optprobe_template_entry;
> > -extern __visible kprobe_opcode_t optprobe_template_val;
> > -extern __visible kprobe_opcode_t optprobe_template_call;
> > -extern __visible kprobe_opcode_t optprobe_template_end;
> > -extern __visible kprobe_opcode_t optprobe_template_sub_sp;
> > -extern __visible kprobe_opcode_t optprobe_template_add_sp;
> > -extern __visible kprobe_opcode_t optprobe_template_restore_begin;
> > -extern __visible kprobe_opcode_t optprobe_template_restore_orig_insn;
> > -extern __visible kprobe_opcode_t optprobe_template_restore_end;
> > +extern __visible kprobe_opcode_t optprobe_template_entry[];
> > +extern __visible kprobe_opcode_t optprobe_template_val[];
> > +extern __visible kprobe_opcode_t optprobe_template_call[];
> > +extern __visible kprobe_opcode_t optprobe_template_end[];
> > +extern __visible kprobe_opcode_t optprobe_template_sub_sp[];
> > +extern __visible kprobe_opcode_t optprobe_template_add_sp[];
> > +extern __visible kprobe_opcode_t optprobe_template_restore_begin[];
> > +extern __visible kprobe_opcode_t optprobe_template_restore_orig_insn[];
> > +extern __visible kprobe_opcode_t optprobe_template_restore_end[];
> >
> >  #define MAX_OPTIMIZED_LENGTH   4
> >  #define MAX_OPTINSN_SIZE                               \
> > -       ((unsigned long)&optprobe_template_end -        \
> > -        (unsigned long)&optprobe_template_entry)
> > +       ((unsigned long)optprobe_template_end - \
> > +        (unsigned long)optprobe_template_entry)
> >  #define RELATIVEJUMP_SIZE      4
> >
> >  struct arch_optimized_insn {
> > diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
> > index 7a449df0b359..c78180172120 100644
> > --- a/arch/arm/probes/kprobes/opt-arm.c
> > +++ b/arch/arm/probes/kprobes/opt-arm.c
> > @@ -85,21 +85,21 @@ asm (
> >                         "optprobe_template_end:\n");
> >
> >  #define TMPL_VAL_IDX \
> > -       ((unsigned long *)&optprobe_template_val - (unsigned long *)&optprobe_template_entry)
> > +       ((unsigned long *)optprobe_template_val - (unsigned long *)optprobe_template_entry)
> >  #define TMPL_CALL_IDX \
> > -       ((unsigned long *)&optprobe_template_call - (unsigned long *)&optprobe_template_entry)
> > +       ((unsigned long *)optprobe_template_call - (unsigned long *)optprobe_template_entry)
> >  #define TMPL_END_IDX \
> > -       ((unsigned long *)&optprobe_template_end - (unsigned long *)&optprobe_template_entry)
> > +       ((unsigned long *)optprobe_template_end - (unsigned long *)optprobe_template_entry)
> >  #define TMPL_ADD_SP \
> > -       ((unsigned long *)&optprobe_template_add_sp - (unsigned long *)&optprobe_template_entry)
> > +       ((unsigned long *)optprobe_template_add_sp - (unsigned long *)optprobe_template_entry)
> >  #define TMPL_SUB_SP \
> > -       ((unsigned long *)&optprobe_template_sub_sp - (unsigned long *)&optprobe_template_entry)
> > +       ((unsigned long *)optprobe_template_sub_sp - (unsigned long *)optprobe_template_entry)
> >  #define TMPL_RESTORE_BEGIN \
> > -       ((unsigned long *)&optprobe_template_restore_begin - (unsigned long *)&optprobe_template_entry)
> > +       ((unsigned long *)optprobe_template_restore_begin - (unsigned long *)optprobe_template_entry)
> >  #define TMPL_RESTORE_ORIGN_INSN \
> > -       ((unsigned long *)&optprobe_template_restore_orig_insn - (unsigned long *)&optprobe_template_entry)
> > +       ((unsigned long *)optprobe_template_restore_orig_insn - (unsigned long *)optprobe_template_entry)
> >  #define TMPL_RESTORE_END \
> > -       ((unsigned long *)&optprobe_template_restore_end - (unsigned long *)&optprobe_template_entry)
> > +       ((unsigned long *)optprobe_template_restore_end - (unsigned long *)optprobe_template_entry)
> >
> >  /*
> >   * ARM can always optimize an instruction when using ARM ISA, except
> > @@ -234,7 +234,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *or
> >         }
> >
> >         /* Copy arch-dep-instance from template. */
> > -       memcpy(code, (unsigned long *)&optprobe_template_entry,
> > +       memcpy(code, (unsigned long *)optprobe_template_entry,
> >                         TMPL_END_IDX * sizeof(kprobe_opcode_t));
> >
> >         /* Adjust buffer according to instruction. */
> > --
> > 2.25.1
> >
