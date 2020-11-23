Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC882C12D7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 19:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390485AbgKWSB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:01:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50221 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728717AbgKWSB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606154516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dY1mghQ8s5wvu5GP9IjiMDQt/Oip4lglbTbH7hUAgQc=;
        b=hyNPUQb7f3S3BDCyrfgK1XT5sE8TWftOOY5muFGvFhu5VQL/XRwwPfi1GP26hW3BCl56v1
        0lxNodk9RuNLHXYx7mTbZsszyz/VOuFN7Uue7n6E0ohV6KZdqqXnv17BKhGVx2HsZl1dG2
        gCLVtoRKqA3Akx38bz3xGBh6q1ecoSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-H8lW_4lcOYO-tNc5FXKnQA-1; Mon, 23 Nov 2020 13:01:54 -0500
X-MC-Unique: H8lW_4lcOYO-tNc5FXKnQA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B35B87952B;
        Mon, 23 Nov 2020 18:01:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.134])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2FD3760864;
        Mon, 23 Nov 2020 18:01:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 23 Nov 2020 19:01:51 +0100 (CET)
Date:   Mon, 23 Nov 2020 19:01:43 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] powerpc/ptrace: Hard wire PT_SOFTE value to 1 in
 gpr_get() too
Message-ID: <20201123180142.GB20279@redhat.com>
References: <20201119160154.GA5183@redhat.com>
 <20201119160247.GB5188@redhat.com>
 <20201119221033.Horde.be-msjDTeIW4XeXARjUu7g1@messagerie.c-s.fr>
 <20201119224347.GC5138@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119224347.GC5138@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe, et al,

So what?

Are you going to push your change or should I re-send 1-2 without
whitespace cleanups?

On 11/19, Oleg Nesterov wrote:
>
> On 11/19, Christophe Leroy wrote:
> >
> > I think the following should work, and not require the first patch (compile
> > tested only).
> >
> > --- a/arch/powerpc/kernel/ptrace/ptrace-view.c
> > +++ b/arch/powerpc/kernel/ptrace/ptrace-view.c
> > @@ -234,9 +234,21 @@ static int gpr_get(struct task_struct *target, const
> > struct user_regset *regset,
> >  	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
> >  		     offsetof(struct pt_regs, msr) + sizeof(long));
> > 
> > +#ifdef CONFIG_PPC64
> > +	membuf_write(&to, &target->thread.regs->orig_gpr3,
> > +		     offsetof(struct pt_regs, softe) - offsetof(struct pt_regs,
> > orig_gpr3));
> > +	membuf_store(&to, 1UL);
> > +
> > +	BUILD_BUG_ON(offsetof(struct pt_regs, trap) !=
> > +		     offsetof(struct pt_regs, softe) + sizeof(long));
> > +
> > +	membuf_write(&to, &target->thread.regs->trap,
> > +		     sizeof(struct user_pt_regs) - offsetof(struct pt_regs, trap));
> > +#else
> >  	membuf_write(&to, &target->thread.regs->orig_gpr3,
> >  			sizeof(struct user_pt_regs) -
> >  			offsetof(struct pt_regs, orig_gpr3));
> > +#endif
> >  	return membuf_zero(&to, ELF_NGREG * sizeof(unsigned long) -
> >  				 sizeof(struct user_pt_regs));
> >  }
> 
> Probably yes.
> 
> This mirrors the previous patch I sent (https://lore.kernel.org/lkml/20190917143753.GA12300@redhat.com/)
> and this is exactly what I tried to avoid, we can make a simpler fix now.
> 
> But let me repeat, I agree with any fix even if imp my version simplifies the code, just
> commit this change and lets forget this problem.
> 
> Oleg.

