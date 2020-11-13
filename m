Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1992B2290
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgKMRfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:35:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgKMRfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:35:13 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E0792222F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 17:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605288912;
        bh=bxbK8zR8Zhybiw99PztD7lzlkpVqbFB0+PyzeWoW/oo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IJfbQvlcGRX+nN4Qsdb/PuwxppzMSAoeZDVcXOPT24YeoZz+AOlg/ZIp1AtELleQk
         fH+jio1Qn5MLoH6lpnvujnnO6Y5ywV9WkW/aoFTP35usSjQJYfTMOXebUwwlbVl1xk
         0eD0+bP2/KLPs7/GZnBikHqjpk3BaQuKVDMTTN7A=
Received: by mail-wm1-f41.google.com with SMTP id d142so8930640wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:35:12 -0800 (PST)
X-Gm-Message-State: AOAM533k1w0b2ZDcsJjEX3zBsVe+xG2dhGDj2UwbkuK48MDrJhJzkbj+
        VwERMtPVGP07Fp0uB7H28Hh4HAiTpCTsruJwJmrg0A==
X-Google-Smtp-Source: ABdhPJwg2H2IxtNd1m8KyjKcLj/jnkfylVK/GcnrWypJcHPYF9099XrFtknG6tx4F7GcjIe6Cv6xyLcjzk2LWt6UYLA=
X-Received: by 2002:a1c:9c56:: with SMTP id f83mr3779383wme.49.1605288909975;
 Fri, 13 Nov 2020 09:35:09 -0800 (PST)
MIME-Version: 1.0
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
 <20201111170536.arx2zbn4ngvjoov7@treble> <20201111174736.GH2628@hirez.programming.kicks-ass.net>
 <20201111181328.mbxcz2uap2vnqpxq@treble> <33843b7f-ed8a-8fcb-19bc-c76cf00f453d@citrix.com>
 <20201111194206.GK2628@hirez.programming.kicks-ass.net> <20201111195900.2x7kfce2ejkmrzi3@treble>
 <20201111200730.GM2628@hirez.programming.kicks-ass.net> <20201111201506.bftpmx4svxn376tn@treble>
 <61b2538f-7be6-8f4a-9395-03071b5cc6f0@citrix.com>
In-Reply-To: <61b2538f-7be6-8f4a-9395-03071b5cc6f0@citrix.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 13 Nov 2020 09:34:57 -0800
X-Gmail-Original-Message-ID: <CALCETrXcTKB_j9MQC1mcZobKGt_cZ5ivDPjU3zwRBmj7DAUCsA@mail.gmail.com>
Message-ID: <CALCETrXcTKB_j9MQC1mcZobKGt_cZ5ivDPjU3zwRBmj7DAUCsA@mail.gmail.com>
Subject: Re: WARNING: can't access registers at asm_common_interrupt
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Juergen Gross <jgross@suse.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 12:25 PM Andrew Cooper
<andrew.cooper3@citrix.com> wrote:
>
> On 11/11/2020 20:15, Josh Poimboeuf wrote:
> > On Wed, Nov 11, 2020 at 09:07:30PM +0100, Peter Zijlstra wrote:
> >> On Wed, Nov 11, 2020 at 01:59:00PM -0600, Josh Poimboeuf wrote:
> >>> On Wed, Nov 11, 2020 at 08:42:06PM +0100, Peter Zijlstra wrote:
> >>>>> Would objtool have an easier time coping if this were implemented in
> >>>>> terms of a static call?
> >>>> I doubt it, the big problem is that there is no visibility into the
> >>>> actual alternative text. Runtime patching fragments into static call
> >>>> would have the exact same problem.
> >>>>
> >>>> Something that _might_ maybe work is trying to morph the immediate
> >>>> fragments into an alternative. That is, instead of this:
> >>>>
> >>>> static inline notrace unsigned long arch_local_save_flags(void)
> >>>> {
> >>>>    return PVOP_CALLEE0(unsigned long, irq.save_fl);
> >>>> }
> >>>>
> >>>> Write it something like:
> >>>>
> >>>> static inline notrace unsigned long arch_local_save_flags(void)
> >>>> {
> >>>>    PVOP_CALL_ARGS;
> >>>>    PVOP_TEST_NULL(irq.save_fl);
> >>>>    asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),
> >>>>                                    "PUSHF; POP _ASM_AX",
> >>>>                                    X86_FEATURE_NATIVE)
> >>>>                        : CLBR_RET_REG, ASM_CALL_CONSTRAINT
> >>>>                        : paravirt_type(irq.save_fl.func),
> >>>>                          paravirt_clobber(PVOP_CALLEE_CLOBBERS)
> >>>>                        : "memory", "cc");
> >>>>    return __eax;
> >>>> }
> >>>>
> >>>> And then we have to teach objtool how to deal with conflicting
> >>>> alternatives...
> >>>>
> >>>> That would remove most (all, if we can figure out a form that deals with
> >>>> the spinlock fragments) of paravirt_patch.c
> >>>>
> >>>> Hmm?
> >>> I was going to suggest something similar.  Though I would try to take it
> >>> further and replace paravirt_patch_default() with static calls.
> >> Possible, we just need to be _really_ careful to not allow changing
> >> those static_call()s. So maybe we need DEFINE_STATIC_CALL_RO() which
> >> does a __ro_after_init on the whole thing.
> > But what if you want to live migrate to another hypervisor ;-)
>
> The same as what happens currently.  The user gets to keep all the
> resulting pieces ;)
>
> >>> Either way it doesn't make objtool's job much easier.  But it would be
> >>> nice to consolidate runtime patching mechanisms and get rid of
> >>> .parainstructions.
> >> I think the above (combining alternative and paravirt/static_call) does
> >> make objtool's job easier, since then we at least have the actual
> >> alternative instructions available to inspect, or am I mis-understanding
> >> things?
> > Right, it makes objtool's job a _little_ easier, since it already knows
> > how to read alternatives.  But it still has to learn to deal with the
> > conflicting stack layouts.
>
> I suppose the needed abstraction is "these blocks will start and end
> with the same stack layout", while allowing the internals to diverge.
>

How much of this stuff is actually useful anymore?  I'm wondering if
we can move most or all of this crud to
cpu_feature_enabled(X86_FEATURE_XENPV) and its asm equivalent.  The
full list, annotated, appears to be:

        const unsigned char     irq_irq_disable[1];

This is CLI or CALL, right?

        const unsigned char     irq_irq_enable[1];

STI or CALL.

        const unsigned char     irq_save_fl[2];

PUSHF; POP %r/eax.  I *think* I read the paravirt mess correctly and
this also turns into CALL.

        const unsigned char     mmu_read_cr2[3];
        const unsigned char     mmu_read_cr3[3];
        const unsigned char     mmu_write_cr3[3];

The write CR3 is so slow that I can't imagine us caring.  Reading CR3
should already be fairly optimized because it's slow on old non-PV
hypervisors, too.  Reading CR2 is rare and lives in asm.  These also
appear to just switch between MOV and CALL, anyway.

        const unsigned char     irq_restore_fl[2];

Ugh, this one sucks.  IMO it should be, for native and PV:

if (flags & X86_EFLAGS_IF) {
  local_irq_enable();  /* or raw? */
} else {
  if (some debugging option) {
    WARN_ON_ONCE(save_fl() & X86_EFLAGS_IF);
  }
}

POPF is slooooow.

        const unsigned char     cpu_wbinvd[2];

This is hilariously slow no matter what.  static_call() or even just a
plain old indirect call should be fine.

        const unsigned char     cpu_usergs_sysret64[6];

This is in the asm and we shouldn't be doing it at all for Xen PV.
IOW we should just drop this patch site entirely.  I can possibly find
some time to get rid of it, and maybe someone from Xen land can help.
I bet that we can gain a lot of perf on Xen PV by cleaning this up,
and I bet it will simplify everything.

        const unsigned char     cpu_swapgs[3];

This is SWAPGS or nop, unless I've missed some subtlety.

        const unsigned char     mov64[3];

This is some PTE magic, and I haven't deciphered it yet.

So I think there is at most one of these that wants anything more
complicated than a plain ALTERNATIVE.  Any volunteers to make it so?
Juergen, if you do all of them except USERGS_SYSRET64, I hereby
volunteer to do that one.

BTW, if y'all want to live migrate between Xen PV and anything else,
you are nuts.
