Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB532AF959
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgKKT7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:59:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbgKKT7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605124748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PG41NygxP92YtBFg6qsustq9xvkioCNPzBcc5qMp8JM=;
        b=TtZtl6MeKsvU0nQy7GlzwEJNd6iXnGmcckagaA5qXlR/uXpeNyZJBkni+cTw2soebPqhA6
        S+iTGFrxNTDxp2WuFR2Jmt7ZSS1lmLQtGhjeLZx+pyMRaqdBb33LKE6FEjLWL6PChbanqM
        ti07wZtD7owmbBdiLMMWXZGDyuh8NWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-88Xe-UVQPJy-Xxmv-25dtw-1; Wed, 11 Nov 2020 14:59:06 -0500
X-MC-Unique: 88Xe-UVQPJy-Xxmv-25dtw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32CEA1084D68;
        Wed, 11 Nov 2020 19:59:05 +0000 (UTC)
Received: from treble (ovpn-120-65.rdu2.redhat.com [10.10.120.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BE306EF52;
        Wed, 11 Nov 2020 19:59:03 +0000 (UTC)
Date:   Wed, 11 Nov 2020 13:59:00 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>, jgross@suse.com,
        x86@kernel.org
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Message-ID: <20201111195900.2x7kfce2ejkmrzi3@treble>
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
 <20201111170536.arx2zbn4ngvjoov7@treble>
 <20201111174736.GH2628@hirez.programming.kicks-ass.net>
 <20201111181328.mbxcz2uap2vnqpxq@treble>
 <33843b7f-ed8a-8fcb-19bc-c76cf00f453d@citrix.com>
 <20201111194206.GK2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111194206.GK2628@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 08:42:06PM +0100, Peter Zijlstra wrote:
> > Would objtool have an easier time coping if this were implemented in
> > terms of a static call?
> 
> I doubt it, the big problem is that there is no visibility into the
> actual alternative text. Runtime patching fragments into static call
> would have the exact same problem.
> 
> Something that _might_ maybe work is trying to morph the immediate
> fragments into an alternative. That is, instead of this:
> 
> static inline notrace unsigned long arch_local_save_flags(void)
> {
> 	return PVOP_CALLEE0(unsigned long, irq.save_fl);
> }
> 
> Write it something like:
> 
> static inline notrace unsigned long arch_local_save_flags(void)
> {
> 	PVOP_CALL_ARGS;
> 	PVOP_TEST_NULL(irq.save_fl);
> 	asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),
> 					"PUSHF; POP _ASM_AX",
> 					X86_FEATURE_NATIVE)
> 			    : CLBR_RET_REG, ASM_CALL_CONSTRAINT
> 			    : paravirt_type(irq.save_fl.func),
> 			      paravirt_clobber(PVOP_CALLEE_CLOBBERS)
> 			    : "memory", "cc");
> 	return __eax;
> }
> 
> And then we have to teach objtool how to deal with conflicting
> alternatives...
> 
> That would remove most (all, if we can figure out a form that deals with
> the spinlock fragments) of paravirt_patch.c
> 
> Hmm?

I was going to suggest something similar.  Though I would try to take it
further and replace paravirt_patch_default() with static calls.

Either way it doesn't make objtool's job much easier.  But it would be
nice to consolidate runtime patching mechanisms and get rid of
.parainstructions.

-- 
Josh

