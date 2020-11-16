Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F67D2B4DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbgKPRl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:41:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733295AbgKPRlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:24 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ED0620575;
        Mon, 16 Nov 2020 17:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605548484;
        bh=BUdpGhQR6uvQ1UiDPnz3BIXkl0WyChUt637AGhwILLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PqmyS1s6Xkb7owRE7Xh7P+XzYqPQ0k/xDZnr3WzJCMvp8brRHsGn4Wfl3rf1RfId1
         N7HzSdqDZ6lrzKe1zmYv/R7PkeWA7zJ6YKVIB6TJiHT2D10rxyGsjjYhJjtIuy3v0m
         24wvqkbaYM6SorYbYhP3MylRUHPtj65YdjjRhd+I=
Date:   Mon, 16 Nov 2020 17:41:20 +0000
From:   Will Deacon <will@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Loadavg accounting error on arm64
Message-ID: <20201116174119.GB30723@willie-the-truck>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116114938.GN3371@techsingularity.net>
 <20201116125355.GB3121392@hirez.programming.kicks-ass.net>
 <20201116125803.GB3121429@hirez.programming.kicks-ass.net>
 <20201116152946.GR3371@techsingularity.net>
 <20201116164928.GF3121392@hirez.programming.kicks-ass.net>
 <20201116172444.GV3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116172444.GV3371@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 05:24:44PM +0000, Mel Gorman wrote:
> On Mon, Nov 16, 2020 at 05:49:28PM +0100, Peter Zijlstra wrote:
> > > So while we might be able to avoid a smp_rmb() before the read of
> > > sched_contributes_to_load and rely on p->on_cpu ordering there,
> > > we may still need a smp_wmb() after nr_interruptible() increments
> > > instead of waiting until the smp_store_release() is hit while a task
> > > is scheduling. That would be a real memory barrier on arm64 and a plain
> > > compiler barrier on x86-64.
> > 
> 
> Wish I read this before sending the changelog
> 
> > I'm mighty confused by your words here; and the patch below. What actual
> > scenario are you worried about?
> > 
> 
> The wrong one apparently. Even if the IRQ is released, the IPI would
> deliver to the CPU that should observe the correct value or take the
> other path when smp_cond_load_acquire(&p->on_cpu, !VAL) waits for the
> schedule to finish so I'm now both confused and wondering why smp_wmb
> made a difference at all.

Probably still worth trying Peter's hack to pad the bitfields though, as I
think that's still a plausible issue (and one which would appear to be
fixed by that smp_wmb() too).

Will
