Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A28243E39
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 19:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHMRWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 13:22:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:35918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgHMRWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:22:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 83168B676;
        Thu, 13 Aug 2020 17:23:00 +0000 (UTC)
Date:   Thu, 13 Aug 2020 19:22:37 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200813172237.GU9477@dhcp22.suse.cz>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813145335.GN9477@dhcp22.suse.cz>
 <87lfiitquu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfiitquu.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-08-20 19:09:29, Thomas Gleixner wrote:
> Michal Hocko <mhocko@suse.com> writes:
> > On Thu 13-08-20 16:34:57, Thomas Gleixner wrote:
[...]

I will go though the rest of the email tomorrow.

> >> Really, if your primary lockless caches are empty then any allocation
> >> which comes from deep atomic context should simply always fail. Being
> >> stuck in an interrupt handler or even deeper for 200+ microseconds
> >> waiting for zone lock is just bonkers IMO.
> >
> > That would require changing NOWAIT/ATOMIC allocations semantic quite
> > drastically for !RT kernels as well. I am not sure this is something we
> > can do. Or maybe I am just missing your point.
> 
> I really do not understand why you think that it affects everything. 

We are likely not on the same page here. Are you talking about the
original proposal in this thread (aka a new flag) or a way to reuse
existing gfp space (http://lkml.kernel.org/r/20200813075027.GD9477@dhcp22.suse.cz)
with a modification that would both silence the lockdep and keep the
existing NOWAIT semantic?

Sorry bear with me but I am getting lost in this thread.
-- 
Michal Hocko
SUSE Labs
