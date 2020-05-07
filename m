Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36221C973F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 19:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEGROX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 13:14:23 -0400
Received: from foss.arm.com ([217.140.110.172]:35844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGROW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:14:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38B0330E;
        Thu,  7 May 2020 10:14:22 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B9683F305;
        Thu,  7 May 2020 10:14:21 -0700 (PDT)
Date:   Thu, 7 May 2020 18:14:19 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Kmemleak infrastructure improvement for task_struct leaks and
 call_rcu()
Message-ID: <20200507171418.GC3180@gaia>
References: <45D2D811-C3B0-442B-9744-415B4AC5CCDB@lca.pw>
 <20200506174019.GA2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506174019.GA2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 10:40:19AM -0700, Paul E. McKenney wrote:
> On Wed, May 06, 2020 at 12:22:37PM -0400, Qian Cai wrote:
> > == call_rcu() leaks ==
> > Another issue that might be relevant is that it seems sometimes,
> > kmemleak will give a lot of false positives (hundreds) because the
> > memory was supposed to be freed by call_rcu()  (for example, in
> > dst_release()) but for some reasons, it takes a long time probably
> > waiting for grace periods or some kind of RCU self-stall, but the
> > memory had already became an orphan. I am not sure how we are going
> > to resolve this properly until we have to figure out why call_rcu()
> > is taking so long to finish?
> 
> I know nothing about kmemleak, but I won't let that stop me from making
> random suggestions...
> 
> One approach is to do an rcu_barrier() inside kmemleak just before
> printing leaked blocks, and check to see if any are still leaked after
> the rcu_barrier().

The main issue is that kmemleak doesn't stop the world when scanning
(which can take over a minute, depending on your hardware), so we get
lots of transient pointer misses. There are some heuristics but
obviously they don't always work.

With RCU, objects are queued for RCU freeing later and chained via
rcu_head.next (IIUC). Under load, this list can be pretty volatile and
if this happen during kmemleak scanning, it's sufficient to lose track
of a next pointer and the rest of the list would be reported as a leak.

I think rcu_barrier() just before the starting the kmemleak scanning may
help if it reduces the number of objects queued.

Now, I wonder whether kmemleak itself can break this RCU chain. The
kmemleak metadata is allocated on a slab alloc callback. The freeing,
however, is done using call_rcu() because originally calling back into
the slab freeing from kmemleak_free() didn't go well. Since the
kmemleak_object structure is not tracked by kmemleak, I wonder whether
its rcu_head would break this directed pointer reference graph.

Let's try the rcu_barrier() first and I'll think about the metadata case
over the weekend.

Thanks.

-- 
Catalin
