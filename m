Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6221A2FD88D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404610AbhATSfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:35:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53178 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403917AbhATS3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:29:13 -0500
Received: from zn.tnic (p200300ec2f0bb000f815c9e084808a0b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:b000:f815:c9e0:8480:8a0b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 10B561EC047D;
        Wed, 20 Jan 2021 19:28:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611167307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yTe7+9OLxA3YUHLXRkKOfc+ewTCD8K5ne5cWHKLrA6U=;
        b=f58gEdXx6bo5UfsJeTiqZNKlb1sh15D5pN7zDB8oQs8iVHRCJyHOHKuWzSgLG7sDjGfkZA
        afczGOPHg7g9lFsFs3DgjaC9+zqYmb/B2+cQ/1PWXoiIgPjwJf+PxkA8ZDI7PTibkcmFVj
        qeZr7pVVDLHe0bhynrmlqMGjD9BzZyQ=
Date:   Wed, 20 Jan 2021 19:28:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 4/4] x86/fpu/64: Don't FNINIT in kernel_fpu_begin()
Message-ID: <20210120182821.GI825@zn.tnic>
References: <cover.1611077835.git.luto@kernel.org>
 <803d45a172a25314fdaec0a01aada8333d55df4e.1611077835.git.luto@kernel.org>
 <YAgAz4qYESIv8iNR@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YAgAz4qYESIv8iNR@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:07:11AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 19, 2021 at 09:39:02AM -0800, Andy Lutomirski wrote:
> > The remaining callers of kernel_fpu_begin() in 64-bit kernels don't use 387
> > instructions, so there's no need to sanitize the FPU state.  Skip it to get
> > most of the performance we lost back.
> > 
> > Reported-by: Krzysztof Olędzki <ole@ans.pl>
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > ---
> >  arch/x86/include/asm/fpu/api.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
> > index 38f4936045ab..435bc59d539b 100644
> > --- a/arch/x86/include/asm/fpu/api.h
> > +++ b/arch/x86/include/asm/fpu/api.h
> > @@ -32,7 +32,19 @@ extern void fpregs_mark_activate(void);
> >  /* Code that is unaware of kernel_fpu_begin_mask() can use this */
> >  static inline void kernel_fpu_begin(void)
> >  {
> > +#ifdef CONFIG_X86_64
> > +	/*
> > +	 * Any 64-bit code that uses 387 instructions must explicitly request
> > +	 * KFPU_387.
> > +	 */
> > +	kernel_fpu_begin_mask(KFPU_MXCSR);
> 
> I'm also still sitting on this:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/fpu
> 
> what do we do with that?

Yah, I'd prefer an actual explicit check infra for stuff like that
instead of us expecting callers to know what bits they would need to
supply in the mask and then inadvertently goofing it up, leading to
funky context corruption bugs...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
