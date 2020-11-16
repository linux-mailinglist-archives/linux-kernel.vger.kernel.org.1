Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDDF2B441C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgKPM6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:58:14 -0500
Received: from outbound-smtp55.blacknight.com ([46.22.136.239]:57543 "EHLO
        outbound-smtp55.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727740AbgKPM6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:58:14 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id 7F27DFA9A8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:58:12 +0000 (GMT)
Received: (qmail 17723 invoked from network); 16 Nov 2020 12:58:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Nov 2020 12:58:11 -0000
Date:   Mon, 16 Nov 2020 12:58:09 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Loadavg accounting error on arm64
Message-ID: <20201116125809.GP3371@techsingularity.net>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116124657.GA3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201116124657.GA3121392@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 01:46:57PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 16, 2020 at 09:10:54AM +0000, Mel Gorman wrote:
> > Similarly, it's not clear why the arm64 implementation
> > does not call smp_acquire__after_ctrl_dep in the smp_load_acquire
> > implementation. Even when it was introduced, the arm64 implementation
> > differed significantly from the arm implementation in terms of what
> > barriers it used for non-obvious reasons.
> 
> This is because ARM64's smp_cond_load_acquire() implementation uses
> smp_load_aquire() directly, as opposed to the generic version that uses
> READ_ONCE().
> 
> This is because ARM64 has a load-acquire instruction, which is highly
> optimized, and generally considered cheaper than the smp_rmb() from
> smp_acquire__after_ctrl_dep().
> 
> Or so I've been led to believe.

Fair enough. Either way, barriering sched_contributes_to_load "works"
but it's clumsy and may not be guaranteed to be correct. The bits
should have been protected by the rq lock but sched_remote_wakeup
updates outside of the lock which might be leading to the adject fields
(like sched_contributes_to_load) getting corrupted as per the "anti
guarantees" in memory-barriers.txt. The rq lock could be conditionally
acquired __ttwu_queue_wakelist for WF_MIGRATED and explicitly cleared in
sched_ttwu_pending (not tested if this works) but it would also suck to
acquire a remote lock when that's what we're explicitly trying to avoid
in that path.

-- 
Mel Gorman
SUSE Labs
