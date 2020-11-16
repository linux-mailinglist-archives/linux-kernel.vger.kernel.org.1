Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A252B4CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbgKPRYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:24:48 -0500
Received: from outbound-smtp57.blacknight.com ([46.22.136.241]:44161 "EHLO
        outbound-smtp57.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732793AbgKPRYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:24:48 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp57.blacknight.com (Postfix) with ESMTPS id CC399FB14B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 17:24:46 +0000 (GMT)
Received: (qmail 1921 invoked from network); 16 Nov 2020 17:24:46 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Nov 2020 17:24:46 -0000
Date:   Mon, 16 Nov 2020 17:24:44 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Loadavg accounting error on arm64
Message-ID: <20201116172444.GV3371@techsingularity.net>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116114938.GN3371@techsingularity.net>
 <20201116125355.GB3121392@hirez.programming.kicks-ass.net>
 <20201116125803.GB3121429@hirez.programming.kicks-ass.net>
 <20201116152946.GR3371@techsingularity.net>
 <20201116164928.GF3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201116164928.GF3121392@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 05:49:28PM +0100, Peter Zijlstra wrote:
> > So while we might be able to avoid a smp_rmb() before the read of
> > sched_contributes_to_load and rely on p->on_cpu ordering there,
> > we may still need a smp_wmb() after nr_interruptible() increments
> > instead of waiting until the smp_store_release() is hit while a task
> > is scheduling. That would be a real memory barrier on arm64 and a plain
> > compiler barrier on x86-64.
> 

Wish I read this before sending the changelog

> I'm mighty confused by your words here; and the patch below. What actual
> scenario are you worried about?
> 

The wrong one apparently. Even if the IRQ is released, the IPI would
deliver to the CPU that should observe the correct value or take the
other path when smp_cond_load_acquire(&p->on_cpu, !VAL) waits for the
schedule to finish so I'm now both confused and wondering why smp_wmb
made a difference at all.

-- 
Mel Gorman
SUSE Labs
