Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AC82AF982
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 21:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgKKUHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 15:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKUHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 15:07:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE69DC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2ST2r5WnetY2RquWgw15GPzxl3IPqx3s4bHU/aEd59M=; b=D5/Uyz2z/qPyuGRyI1Aq6cufhu
        2hu1GI91+9tgYH6JdDAztmurVzGWG6Xf67QrUwhqgZxDGksVYil4SYzfbU4MSx4WDXFxV3D0dQS4D
        wnqwSQwKTLDceSADGBGCl1fPtHoZqDiJrjx6P7esTJ432prqlc281UsiEoxZLp+K6RD5jYBB/5KF6
        /636p9QnhED5rTd2oUDo8SN50Bgb1RRsIovaXIVGOGBMBx8Wg37JZd25VsG81nZwmojcmUyAQ1XEj
        1/eEbiPZTZT8feF95cjMJQS21myF2YXWxDJDJ0B1Z+7JBQr7GdITa5RLVLgDwgqi/yLCqPIvATh4S
        zJcCowdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcwOx-00068J-LL; Wed, 11 Nov 2020 20:07:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 055CA301324;
        Wed, 11 Nov 2020 21:07:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DCA0B2BCE933C; Wed, 11 Nov 2020 21:07:30 +0100 (CET)
Date:   Wed, 11 Nov 2020 21:07:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>, jgross@suse.com,
        x86@kernel.org
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Message-ID: <20201111200730.GM2628@hirez.programming.kicks-ass.net>
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
 <20201111170536.arx2zbn4ngvjoov7@treble>
 <20201111174736.GH2628@hirez.programming.kicks-ass.net>
 <20201111181328.mbxcz2uap2vnqpxq@treble>
 <33843b7f-ed8a-8fcb-19bc-c76cf00f453d@citrix.com>
 <20201111194206.GK2628@hirez.programming.kicks-ass.net>
 <20201111195900.2x7kfce2ejkmrzi3@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111195900.2x7kfce2ejkmrzi3@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 01:59:00PM -0600, Josh Poimboeuf wrote:
> On Wed, Nov 11, 2020 at 08:42:06PM +0100, Peter Zijlstra wrote:
> > > Would objtool have an easier time coping if this were implemented in
> > > terms of a static call?
> > 
> > I doubt it, the big problem is that there is no visibility into the
> > actual alternative text. Runtime patching fragments into static call
> > would have the exact same problem.
> > 
> > Something that _might_ maybe work is trying to morph the immediate
> > fragments into an alternative. That is, instead of this:
> > 
> > static inline notrace unsigned long arch_local_save_flags(void)
> > {
> > 	return PVOP_CALLEE0(unsigned long, irq.save_fl);
> > }
> > 
> > Write it something like:
> > 
> > static inline notrace unsigned long arch_local_save_flags(void)
> > {
> > 	PVOP_CALL_ARGS;
> > 	PVOP_TEST_NULL(irq.save_fl);
> > 	asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),
> > 					"PUSHF; POP _ASM_AX",
> > 					X86_FEATURE_NATIVE)
> > 			    : CLBR_RET_REG, ASM_CALL_CONSTRAINT
> > 			    : paravirt_type(irq.save_fl.func),
> > 			      paravirt_clobber(PVOP_CALLEE_CLOBBERS)
> > 			    : "memory", "cc");
> > 	return __eax;
> > }
> > 
> > And then we have to teach objtool how to deal with conflicting
> > alternatives...
> > 
> > That would remove most (all, if we can figure out a form that deals with
> > the spinlock fragments) of paravirt_patch.c
> > 
> > Hmm?
> 
> I was going to suggest something similar.  Though I would try to take it
> further and replace paravirt_patch_default() with static calls.

Possible, we just need to be _really_ careful to not allow changing
those static_call()s. So maybe we need DEFINE_STATIC_CALL_RO() which
does a __ro_after_init on the whole thing.

> Either way it doesn't make objtool's job much easier.  But it would be
> nice to consolidate runtime patching mechanisms and get rid of
> .parainstructions.

I think the above (combining alternative and paravirt/static_call) does
make objtool's job easier, since then we at least have the actual
alternative instructions available to inspect, or am I mis-understanding
things?
