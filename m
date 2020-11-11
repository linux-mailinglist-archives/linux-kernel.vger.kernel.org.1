Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022902AF99D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 21:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgKKUP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 15:15:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbgKKUP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 15:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605125725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JpRkl5+vsWXIs7CNuFJmsCnDy55m6W35mOUG4Lg8vTo=;
        b=fmbX1NDHHRVe5bEn5NJt7yRVmrwLWcYyZNwtKrnVkbxnhoPM6/rAbSKNE99W5zRsNpH6sB
        EqNV9SoQVq8C7RhlTM65U7chECB1uWEr1XQSP3VfHRL3wPo+gpWAnqdcTll7hk/a2AwFG3
        wsvRDPQ7yNMzKkufuJQwrkM3FjX62L4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-yKTMK7KPO6qtrD6ljA9kMg-1; Wed, 11 Nov 2020 15:15:15 -0500
X-MC-Unique: yKTMK7KPO6qtrD6ljA9kMg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33CB8100855E;
        Wed, 11 Nov 2020 20:15:14 +0000 (UTC)
Received: from treble (ovpn-120-65.rdu2.redhat.com [10.10.120.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 206C15C1C4;
        Wed, 11 Nov 2020 20:15:09 +0000 (UTC)
Date:   Wed, 11 Nov 2020 14:15:06 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>, jgross@suse.com,
        x86@kernel.org
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Message-ID: <20201111201506.bftpmx4svxn376tn@treble>
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
 <20201111170536.arx2zbn4ngvjoov7@treble>
 <20201111174736.GH2628@hirez.programming.kicks-ass.net>
 <20201111181328.mbxcz2uap2vnqpxq@treble>
 <33843b7f-ed8a-8fcb-19bc-c76cf00f453d@citrix.com>
 <20201111194206.GK2628@hirez.programming.kicks-ass.net>
 <20201111195900.2x7kfce2ejkmrzi3@treble>
 <20201111200730.GM2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111200730.GM2628@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 09:07:30PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 11, 2020 at 01:59:00PM -0600, Josh Poimboeuf wrote:
> > On Wed, Nov 11, 2020 at 08:42:06PM +0100, Peter Zijlstra wrote:
> > > > Would objtool have an easier time coping if this were implemented in
> > > > terms of a static call?
> > > 
> > > I doubt it, the big problem is that there is no visibility into the
> > > actual alternative text. Runtime patching fragments into static call
> > > would have the exact same problem.
> > > 
> > > Something that _might_ maybe work is trying to morph the immediate
> > > fragments into an alternative. That is, instead of this:
> > > 
> > > static inline notrace unsigned long arch_local_save_flags(void)
> > > {
> > > 	return PVOP_CALLEE0(unsigned long, irq.save_fl);
> > > }
> > > 
> > > Write it something like:
> > > 
> > > static inline notrace unsigned long arch_local_save_flags(void)
> > > {
> > > 	PVOP_CALL_ARGS;
> > > 	PVOP_TEST_NULL(irq.save_fl);
> > > 	asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),
> > > 					"PUSHF; POP _ASM_AX",
> > > 					X86_FEATURE_NATIVE)
> > > 			    : CLBR_RET_REG, ASM_CALL_CONSTRAINT
> > > 			    : paravirt_type(irq.save_fl.func),
> > > 			      paravirt_clobber(PVOP_CALLEE_CLOBBERS)
> > > 			    : "memory", "cc");
> > > 	return __eax;
> > > }
> > > 
> > > And then we have to teach objtool how to deal with conflicting
> > > alternatives...
> > > 
> > > That would remove most (all, if we can figure out a form that deals with
> > > the spinlock fragments) of paravirt_patch.c
> > > 
> > > Hmm?
> > 
> > I was going to suggest something similar.  Though I would try to take it
> > further and replace paravirt_patch_default() with static calls.
> 
> Possible, we just need to be _really_ careful to not allow changing
> those static_call()s. So maybe we need DEFINE_STATIC_CALL_RO() which
> does a __ro_after_init on the whole thing.

But what if you want to live migrate to another hypervisor ;-)

> > Either way it doesn't make objtool's job much easier.  But it would be
> > nice to consolidate runtime patching mechanisms and get rid of
> > .parainstructions.
> 
> I think the above (combining alternative and paravirt/static_call) does
> make objtool's job easier, since then we at least have the actual
> alternative instructions available to inspect, or am I mis-understanding
> things?

Right, it makes objtool's job a _little_ easier, since it already knows
how to read alternatives.  But it still has to learn to deal with the
conflicting stack layouts.

-- 
Josh

