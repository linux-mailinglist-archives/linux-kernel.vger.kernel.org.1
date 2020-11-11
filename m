Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420D42AF9DE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 21:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgKKUjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 15:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKUjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 15:39:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239E6C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+xuKYc0X+UN/uYD5LNznUOLcd4BbelJ9pcfJxobTWf8=; b=ZvdQIxRDcDVreTfUZpwVhiNEFJ
        5qV1CT9de2hFKXm2ckHMZPEMyzTF759KfYhLLhiV6bNgXNB3DUGZivkBzvTwrBA+jLZ5LsCkdV7/X
        kRfq3QuKvbRDzyf7li86dLmFrwI2bRbIBRluJdPaUVkKH7rWMLpLxXdDOBirSSVbrECTdYBis9fmh
        UrSjuWg/lLvHgvrZn8GAOeQ7fIhZ71AHFgQIo0EBDn/LNP6IIEmL2oR/U3YLzCDb7GlorOuaUxL0V
        Yvbzb6YZbX9MHqr7rDs6DTx1N8Ot+0kDbCAcRaLKT79VInE/7ppSxeu6G4DBckyLL5oCaXnrnimAF
        93zdWtRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcwu6-0007yl-B6; Wed, 11 Nov 2020 20:39:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB4C3301EE3;
        Wed, 11 Nov 2020 21:39:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C78CD2BCE964C; Wed, 11 Nov 2020 21:39:41 +0100 (CET)
Date:   Wed, 11 Nov 2020 21:39:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>, jgross@suse.com,
        x86@kernel.org
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Message-ID: <20201111203941.GP2628@hirez.programming.kicks-ass.net>
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
 <20201111170536.arx2zbn4ngvjoov7@treble>
 <20201111174736.GH2628@hirez.programming.kicks-ass.net>
 <20201111181328.mbxcz2uap2vnqpxq@treble>
 <33843b7f-ed8a-8fcb-19bc-c76cf00f453d@citrix.com>
 <20201111194206.GK2628@hirez.programming.kicks-ass.net>
 <20201111195900.2x7kfce2ejkmrzi3@treble>
 <20201111200730.GM2628@hirez.programming.kicks-ass.net>
 <20201111201506.bftpmx4svxn376tn@treble>
 <61b2538f-7be6-8f4a-9395-03071b5cc6f0@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b2538f-7be6-8f4a-9395-03071b5cc6f0@citrix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 08:25:36PM +0000, Andrew Cooper wrote:

> > Right, it makes objtool's job a _little_ easier, since it already knows
> > how to read alternatives.  But it still has to learn to deal with the
> > conflicting stack layouts.
> 
> I suppose the needed abstraction is "these blocks will start and end
> with the same stack layout", while allowing the internals to diverge.

It's a little more complicated than that due to the fact that there is
only a single ORC table.

So something like:

	alt0		alt1
	0x00 push	0x00 nop
	0x01 nop	0x01 push

is impossible to correctly unwind.
