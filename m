Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251802AF9D3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 21:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgKKUft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 15:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgKKUft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 15:35:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD89C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dgXCjKGBt/mXh3REDlqg6FKMBu6tSua5dmepdSOWDrM=; b=VbHl+v+/u33GvlwUFPvaAQtuwL
        dYui/9xqmyT9GsUJOc9yuKurvmJIUpVYMBExMtV9pKHCwTkBddJXyDSf3OUeIXJsub18gT6XPyMEv
        gD3FjOeO8pzzT8PVi4Ke1ikRNGphJCpJ/sqQ0MVUsLlDLq709PDEoOcg4SB1iQkQmc+0ajmX7sxXV
        YVl/Oj5MCpIpuhpwZGEiKUsxZPwi/dsX4svAhp83SxNWymJQEGMMJD5irq25eMn0fEcJccQL01avt
        R+E671rPZd9dTWsLRlDRk+iEy+zTJtY/RCBeKmCEQ2UCGpvNnLGNlv8JBfyhi9EHs+JSVyaj1UU0e
        lA159UWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcwqB-0007pb-7D; Wed, 11 Nov 2020 20:35:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 18A9D301A42;
        Wed, 11 Nov 2020 21:35:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3F772BCE962A; Wed, 11 Nov 2020 21:35:37 +0100 (CET)
Date:   Wed, 11 Nov 2020 21:35:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>, jgross@suse.com,
        x86@kernel.org
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Message-ID: <20201111203537.GO2628@hirez.programming.kicks-ass.net>
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
 <20201111170536.arx2zbn4ngvjoov7@treble>
 <20201111174736.GH2628@hirez.programming.kicks-ass.net>
 <20201111181328.mbxcz2uap2vnqpxq@treble>
 <33843b7f-ed8a-8fcb-19bc-c76cf00f453d@citrix.com>
 <20201111194206.GK2628@hirez.programming.kicks-ass.net>
 <20201111195900.2x7kfce2ejkmrzi3@treble>
 <20201111200730.GM2628@hirez.programming.kicks-ass.net>
 <20201111201506.bftpmx4svxn376tn@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111201506.bftpmx4svxn376tn@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 02:15:06PM -0600, Josh Poimboeuf wrote:
> On Wed, Nov 11, 2020 at 09:07:30PM +0100, Peter Zijlstra wrote:

> > Possible, we just need to be _really_ careful to not allow changing
> > those static_call()s. So maybe we need DEFINE_STATIC_CALL_RO() which
> > does a __ro_after_init on the whole thing.
> 
> But what if you want to live migrate to another hypervisor ;-)

Then you get to keep the pieces ;-)

> > > Either way it doesn't make objtool's job much easier.  But it would be
> > > nice to consolidate runtime patching mechanisms and get rid of
> > > .parainstructions.
> > 
> > I think the above (combining alternative and paravirt/static_call) does
> > make objtool's job easier, since then we at least have the actual
> > alternative instructions available to inspect, or am I mis-understanding
> > things?
> 
> Right, it makes objtool's job a _little_ easier, since it already knows
> how to read alternatives.  But it still has to learn to deal with the
> conflicting stack layouts.

Right, but at least now it can see the instructions. Which is a lot
better than: `add a magic +1 ORC entry when you see an indirect call to
$magic`.

Anyway, __orc_find(addr) looks for the ORC entry with the highest IP <=
@addr. So if we have:

	alt0			alt1

	0x00 CALL *foo		0x00 PUSHF
	0x07 insn		0x01 POP %rax
				0x02 .nops 5
				0x07 insn

we have ORC entries for alt1.0x00 and alt1.0x01. Then if we hit insn,
it'll find the alt1.0x01 entry, but that had better be the same as the
state at 0x00.

This means that for every alt, we have to unwind using the CFI of every
other alt and match for every instruction. Which should be doable I
think.

Certainly more complicated that outright disallowing CFI changes inside
alt groups though :/
