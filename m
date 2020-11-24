Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F083D2C1A43
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgKXAxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgKXAxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:53:13 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0C8C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:53:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Cg59H3239z9s1l;
        Tue, 24 Nov 2020 11:53:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1606179188;
        bh=lyVOjIkSY5dqLzPZNvbMZ38Ji4ioww1+hvQxiSUQm3Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=n18IzvBWw2TV142EFQEjejJW7/FqYCmtDMxgjeVIyiVy1SevKBgYP5TmkR63a64hK
         LRWMxRUBR2ZOQRXhBYqjzuN2PFrl6VigEQ6gnJH0UT0Of8Ujkb4w5eNs07U1B1dEfp
         DrHLTr5A6SglsJ+b5Js3pIWtN0Om0clhQJm/tvrTd/YRpsDNavh9V9NV/WSW7nuSwn
         Ngoa5rpHPiutfEVtD/GSEqwWvdv3GILXN5Ca4/7eb1fscPfRRc1zCyCmvN0aKdxJzH
         VHzfXi8nikZ4SZkVGyksLHcAy/v3klnQvWX4uCEJUHpnwA1HFVCnyEx9vzhGG6YZcY
         kWzUeSbjru6ng==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Oleg Nesterov <oleg@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] powerpc/ptrace: Hard wire PT_SOFTE value to 1 in gpr_get() too
In-Reply-To: <20201123180142.GB20279@redhat.com>
References: <20201119160154.GA5183@redhat.com> <20201119160247.GB5188@redhat.com> <20201119221033.Horde.be-msjDTeIW4XeXARjUu7g1@messagerie.c-s.fr> <20201119224347.GC5138@redhat.com> <20201123180142.GB20279@redhat.com>
Date:   Tue, 24 Nov 2020 11:53:03 +1100
Message-ID: <87360z1spc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:
> Christophe, et al,
>
> So what?
>
> Are you going to push your change or should I re-send 1-2 without
> whitespace cleanups?

I'll take your 1 & 2 and fixup the whitespace issues when applying.

cheers

> On 11/19, Oleg Nesterov wrote:
>>
>> On 11/19, Christophe Leroy wrote:
>> >
>> > I think the following should work, and not require the first patch (compile
>> > tested only).
>> >
>> > --- a/arch/powerpc/kernel/ptrace/ptrace-view.c
>> > +++ b/arch/powerpc/kernel/ptrace/ptrace-view.c
>> > @@ -234,9 +234,21 @@ static int gpr_get(struct task_struct *target, const
>> > struct user_regset *regset,
>> >  	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
>> >  		     offsetof(struct pt_regs, msr) + sizeof(long));
>> > 
>> > +#ifdef CONFIG_PPC64
>> > +	membuf_write(&to, &target->thread.regs->orig_gpr3,
>> > +		     offsetof(struct pt_regs, softe) - offsetof(struct pt_regs,
>> > orig_gpr3));
>> > +	membuf_store(&to, 1UL);
>> > +
>> > +	BUILD_BUG_ON(offsetof(struct pt_regs, trap) !=
>> > +		     offsetof(struct pt_regs, softe) + sizeof(long));
>> > +
>> > +	membuf_write(&to, &target->thread.regs->trap,
>> > +		     sizeof(struct user_pt_regs) - offsetof(struct pt_regs, trap));
>> > +#else
>> >  	membuf_write(&to, &target->thread.regs->orig_gpr3,
>> >  			sizeof(struct user_pt_regs) -
>> >  			offsetof(struct pt_regs, orig_gpr3));
>> > +#endif
>> >  	return membuf_zero(&to, ELF_NGREG * sizeof(unsigned long) -
>> >  				 sizeof(struct user_pt_regs));
>> >  }
>> 
>> Probably yes.
>> 
>> This mirrors the previous patch I sent (https://lore.kernel.org/lkml/20190917143753.GA12300@redhat.com/)
>> and this is exactly what I tried to avoid, we can make a simpler fix now.
>> 
>> But let me repeat, I agree with any fix even if imp my version simplifies the code, just
>> commit this change and lets forget this problem.
>> 
>> Oleg.
