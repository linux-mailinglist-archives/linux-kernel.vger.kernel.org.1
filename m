Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECA12AF7C6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgKKSNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:13:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbgKKSNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605118418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BzfSA1UIOUzYMmUrrNLsV0Zn7y194VWwPiSaU2NsQ7s=;
        b=OtumNEAS9BZy/8xqMncVZbxo1RJt43VxGKeQieSx9+LNqDA3XOhqqtOf1Xh3SL9bdQ0dtK
        W7mT2f7aS/xYP54TA57rbAj5xpHOcOjKWGBid3eHQ7vzNrgNlc8u8DB+sY2rqq+TEWbWUs
        wOQ/NKLrPVaJ+seP9W1Qhw5XqV7Cyf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-RxykxU2TOem2Yxp1g2uyQw-1; Wed, 11 Nov 2020 13:13:34 -0500
X-MC-Unique: RxykxU2TOem2Yxp1g2uyQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF9FD100831B;
        Wed, 11 Nov 2020 18:13:32 +0000 (UTC)
Received: from treble (ovpn-120-65.rdu2.redhat.com [10.10.120.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AFD36EF52;
        Wed, 11 Nov 2020 18:13:31 +0000 (UTC)
Date:   Wed, 11 Nov 2020 12:13:28 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        andrew.cooper3@citrix.com, jgross@suse.com
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Message-ID: <20201111181328.mbxcz2uap2vnqpxq@treble>
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
 <20201111170536.arx2zbn4ngvjoov7@treble>
 <20201111174736.GH2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111174736.GH2628@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 06:47:36PM +0100, Peter Zijlstra wrote:
> This is PARAVIRT_XXL only, which is a Xen special. My preference, as
> always, is to kill it... Sadly the Xen people have a different opinion.

That would be soooo nice... then we could get rid of paravirt patching
altogether and replace it with static calls.

> > Objtool doesn't know about the pushf/pop paravirt patch, so ORC gets
> > confused by the changed stack layout.
> > 
> > I'm thinking we either need to teach objtool how to deal with
> > save_fl/restore_fl patches, or we need to just get rid of those nasty
> > patches somehow.  Peter, any thoughts?
> 
> Don't use Xen? ;-)
> 
> So with PARAVIRT_XXL the compiler will emit something like:
> 
>   "CALL *pvops.save_fl"
> 
> Which we then overwrite at runtime with "pushf; pop %[re]ax" and a few
> NOPs.
> 
> Now, objtool understands alternatives, and ensures they have the same
> stack layout, it has no chance in hell of understanding this, simply
> because paravirt_patch.c is magic.
> 
> I don't have any immediate clever ideas, but let me ponder it a wee bit.
> 
> ....
> 
> Something really disguisting we could do is recognise the indirect call
> offset and emit an extra ORC entry for RIP+1. So the cases are:
> 
> 	CALL *pv_ops.save_fl	-- 7 bytes IIRC
> 	CALL $imm;		-- 5 bytes
> 	PUSHF; POP %[RE]AX	-- 2 bytes
> 
> so the RIP+1 (the POP insn) will only ever exist in this case. The
> indirect and direct call cases would never land on that IP.

I had a similar idea, and a bit of deja vu - we may have talked about
this before.  At least I know we talked about doing something similar
for alternatives which muck with the stack.

> > It looks like 044d0d6de9f5 ("lockdep: Only trace IRQ edges") is making
> > the problem more likely, by adding the irqs_disabled() check for every
> > local_irq_disable().
> > 
> > Also - Peter, Nicholas - is that irqs_disabled() check really necessary
> > in local_irq_disable()?  Presumably irqs would typically be be enabled
> > before calling it?
> 
> Yeah, so it's all a giant can of worms that; also see:
> 
>   https://lkml.kernel.org/r/20200821084738.508092956@infradead.org
> 
> The basic idea is to only trace edges, ie. when the hardware state
> actually changes. Sadly this means doing a pushf/pop before the cli.
> Ideally CLI would store the old IF in CF or something like that, but
> alas.

Right, that makes sense for save/restore, but is the disabled check
really needed for local_irq_disable()?  Wouldn't that always be an edge?

And anyway I don't see a similar check for local_irq_enable().

-- 
Josh

