Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D422243F35
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 21:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHMTNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 15:13:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:40378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgHMTNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 15:13:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4D2CAF2F;
        Thu, 13 Aug 2020 19:14:10 +0000 (UTC)
Date:   Thu, 13 Aug 2020 21:13:47 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     peterz@infradead.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200813191347.GV9477@dhcp22.suse.cz>
References: <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813145335.GN9477@dhcp22.suse.cz>
 <20200813154159.GR4295@paulmck-ThinkPad-P72>
 <20200813155412.GP9477@dhcp22.suse.cz>
 <20200813160442.GV4295@paulmck-ThinkPad-P72>
 <20200813161357.GQ9477@dhcp22.suse.cz>
 <20200813162904.GX4295@paulmck-ThinkPad-P72>
 <20200813183121.GY2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813183121.GY2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-08-20 20:31:21, Peter Zijlstra wrote:
> On Thu, Aug 13, 2020 at 09:29:04AM -0700, Paul E. McKenney wrote:
[...]
> > 3.	Reusing existing GFP_ flags/values/whatever to communicate
> > 	the raw-context information that was to be communicated by
> > 	the new GFP_ flag.
> > 
> > 4.	Making lockdep forgive acquiring spinlocks while holding
> > 	raw spinlocks, but only in CONFIG_PREEMPT_NONE=y kernels.
> > 
> > Am I missing anything?
> 
> How would 4 solve anything?

Nothing on its own but along with http://lkml.kernel.org/r/20200813075027.GD9477@dhcp22.suse.cz
it would allow at least _some_ NOWAIT semantic for RT atomic contexts
and prevent from lockdep false positives for !RT trees.
-- 
Michal Hocko
SUSE Labs
