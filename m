Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0E72C9EFE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbgLAKTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:19:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgLAKTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:19:06 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8161C20770;
        Tue,  1 Dec 2020 10:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606817905;
        bh=W6jlMe+K75QYDjHcjh8/5+Dk9y+mHxLaAbJkg1XPDlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRfS83SCUFPeZjIbDqQh7bQzM6RKSAiK951lxbvrrQltxKge7wesugnopwf8veCIL
         U3wZNcIZbkQ6HMPjgrkZM6Mxyw/149PtvtsDzRZe+HVl5/x0jOrWp3HZXUatgyv6aw
         D2CMxXvfg4hapjYsi8pbgjfKJirm6aAph84fIg4g=
Date:   Tue, 1 Dec 2020 10:18:19 +0000
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] arm64: scs: use vmapped IRQ and SDEI shadow stacks
Message-ID: <20201201101819.GA26471@willie-the-truck>
References: <20201124195940.27061-1-samitolvanen@google.com>
 <20201124195940.27061-3-samitolvanen@google.com>
 <20201130114940.GB24563@willie-the-truck>
 <CABCJKud6UiidpqqwJcghnqLKDkqM3pzMUUwe3_HH3ODDqOdANA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKud6UiidpqqwJcghnqLKDkqM3pzMUUwe3_HH3ODDqOdANA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 01:13:07PM -0800, Sami Tolvanen wrote:
> On Mon, Nov 30, 2020 at 3:49 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, Nov 24, 2020 at 11:59:40AM -0800, Sami Tolvanen wrote:
> > > Use scs_alloc() to allocate also IRQ and SDEI shadow stacks instead of
> > > using statically allocated stacks.
> > >
> > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > > ---
> > >  arch/arm64/kernel/Makefile |  1 -
> > >  arch/arm64/kernel/entry.S  |  6 ++--
> > >  arch/arm64/kernel/irq.c    | 19 ++++++++++
> > >  arch/arm64/kernel/scs.c    | 16 ---------
> > >  arch/arm64/kernel/sdei.c   | 71 +++++++++++++++++++++++++++++++-------
> > >  include/linux/scs.h        |  4 ---
> > >  6 files changed, 81 insertions(+), 36 deletions(-)
> > >  delete mode 100644 arch/arm64/kernel/scs.c
> >
> > [...]
> >
> > > @@ -70,18 +97,40 @@ static int _init_sdei_stack(unsigned long * __percpu *ptr, int cpu)
> > >       return 0;
> > >  }
> > >
> > > +static int _init_sdei_scs(unsigned long * __percpu *ptr, int cpu)
> > > +{
> > > +     void *s;
> > > +
> > > +     s = scs_alloc(cpu_to_node(cpu));
> > > +     if (!s)
> > > +             return -ENOMEM;
> > > +     per_cpu(*ptr, cpu) = s;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  static int init_sdei_stacks(void)
> > >  {
> > >       int cpu;
> > >       int err = 0;
> > >
> > >       for_each_possible_cpu(cpu) {
> > > -             err = _init_sdei_stack(&sdei_stack_normal_ptr, cpu);
> > > -             if (err)
> > > -                     break;
> > > -             err = _init_sdei_stack(&sdei_stack_critical_ptr, cpu);
> > > -             if (err)
> > > -                     break;
> > > +             if (IS_ENABLED(CONFIG_VMAP_STACK)) {
> > > +                     err = _init_sdei_stack(&sdei_stack_normal_ptr, cpu);
> > > +                     if (err)
> > > +                             break;
> > > +                     err = _init_sdei_stack(&sdei_stack_critical_ptr, cpu);
> > > +                     if (err)
> > > +                             break;
> > > +             }
> > > +             if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
> > > +                     err = _init_sdei_scs(&sdei_shadow_call_stack_normal_ptr, cpu);
> > > +                     if (err)
> > > +                             break;
> > > +                     err = _init_sdei_scs(&sdei_shadow_call_stack_critical_ptr, cpu);
> > > +                     if (err)
> > > +                             break;
> >
> > This looks ok to me, but I think it would be better to follow the same
> > approach as you have for the IRQ stacks and instead have a separate
> > init_sdei_scs() function (similarly for the free() path), which means
> > you can simply the IS_ENABLED() checks too.
> 
> OK, I can change this in v3. It makes error handling in
> sdei_arch_get_entry_point() a bit more awkward though. We'll need
> something like this:
> 
>         if (IS_ENABLED(CONFIG_VMAP_STACK)) {
>                 if (init_sdei_stacks())
>                         return 0;
>         }
> 
>         if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
>                 if (init_sdei_scs()) {
>                         if (IS_ENABLED(CONFIG_VMAP_STACK))
>                                 free_sdei_stacks();
>                         return 0;
>                 }

Can you push the IS_ENABLED() checks into their respective functions?
Then you can do something like:

	if (init_sdei_stacks())
		return 0;

	if (init_sdei_scs())
		goto out_free_stacks;

	...

out_free_stacks:
	free_sdei_stacks();
	return 0;


Will
