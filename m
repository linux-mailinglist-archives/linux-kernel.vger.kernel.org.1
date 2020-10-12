Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7095828B277
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbgJLKpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387568AbgJLKpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:45:21 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335E0C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 03:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=z5pzSV5nBQT8SxLlSdLOzbr7Kyh1DTeoSAzBFZne3gQ=; b=fVqmSQORpjIfktIa6KeeyDumA1
        M2YhWhOV4tEOpYdOX/rmk7+aGrLU3e4ZHMP6wAwDixCnWObMzp8iDVj5CQFc6fwNOnOtdxvX+tPvh
        U9cv4Ay5cZMAbsZUvjm0bXBwOqbnleDCuTudxxQoUjlw1FyZ4dDM8IDtXmAaSGvLL0qY9EeBfqSZJ
        fLsrdUSNIyaXt6zqrq3VAeG502NoG+2DIzhyGGUxplRgJy+d46bkcX86qaDDsipOsu4DNHlutWggV
        XJVFUch8HvPOVceoLhvlHmBBCsDTJ8xBT2Yin5OVz+H8HvPedxHs5hYSQaBRpH1ITTWQgBOcqXfwQ
        xtRyOjwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRvKI-0002rw-Te; Mon, 12 Oct 2020 10:45:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08611300DB4;
        Mon, 12 Oct 2020 12:45:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E95E920A2950E; Mon, 12 Oct 2020 12:45:08 +0200 (CEST)
Date:   Mon, 12 Oct 2020 12:45:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/alternative: don't call text_poke() in lazy TLB mode
Message-ID: <20201012104508.GS2628@hirez.programming.kicks-ass.net>
References: <20201009144225.12019-1-jgross@suse.com>
 <20201012101330.GR2628@hirez.programming.kicks-ass.net>
 <fc202e90-00ff-a635-f298-c3ca293e9182@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc202e90-00ff-a635-f298-c3ca293e9182@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 12:26:06PM +0200, Jürgen Groß wrote:

> > > @@ -807,6 +807,15 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
> > >   	temp_mm_state_t temp_state;
> > >   	lockdep_assert_irqs_disabled();
> > > +
> > > +	/*
> > > +	 * Make sure not to be in TLB lazy mode, as otherwise we'll end up
> > > +	 * with a stale address space WITHOUT being in lazy mode after
> > > +	 * restoring the previous mm.
> > > +	 */
> > > +	if (this_cpu_read(cpu_tlbstate.is_lazy))
> > > +		leave_mm(smp_processor_id());
> > > +
> > >   	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
> > >   	switch_mm_irqs_off(NULL, mm, current);
> > 
> > Would it make sense to write it like:
> > 
> > 	this_state.mm = this_cpu_read(cpu_tlbstate.is_lazy) ?
> > 			&init_mm : this_cpu_read(cpu_tlbstate.loaded_mm);
> > 
> > Possibly with that wrapped in a conveniently named helper function.
> 
> Fine with me, but I don't think it matters that much.
> 
> For each batch of text_poke() it will be hit only once, and I'm not sure
> it is really a good idea to use the knowledge that leave_mm() is just a
> switch to init_mm here.

Yeah, I'm not sure either. But it's something I came up with when
looking at all this.

Andy, what's your preference?
