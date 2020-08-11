Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CA32419BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 12:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgHKK2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 06:28:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:56138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgHKK2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 06:28:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 21739AD6A;
        Tue, 11 Aug 2020 10:28:40 +0000 (UTC)
Date:   Tue, 11 Aug 2020 12:28:18 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200811102818.GJ4793@dhcp22.suse.cz>
References: <20200809204354.20137-1-urezki@gmail.com>
 <20200809204354.20137-2-urezki@gmail.com>
 <20200810123141.GF4773@dhcp22.suse.cz>
 <20200810160739.GA29884@pc636>
 <20200810192525.GG4773@dhcp22.suse.cz>
 <20200811081917.GG4793@dhcp22.suse.cz>
 <20200811093713.GB2634@pc636>
 <20200811094251.GA3767@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811094251.GA3767@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-08-20 11:42:51, Uladzislau Rezki wrote:
> On Tue, Aug 11, 2020 at 11:37:13AM +0200, Uladzislau Rezki wrote:
> > On Tue, Aug 11, 2020 at 10:19:17AM +0200, Michal Hocko wrote:
[...]
> > > Anyway, if the zone->lock is not a good fit for raw_spin_lock then the
> > > only way I can see forward is to detect real (RT) atomic contexts and
> > > bail out early before taking the lock in the allocator for NOWAIT/ATOMIC
> > > requests.
> > >
> This is similar what i have done with mm: Add __GFP_NO_LOCKS flag. I just
> did it for order-0 pages(other paths are impossible) and made it common for
> any kernel.
> 
> Because when you say "bail out early" i suspect that we would like to check
> the per-cpu-list cache.

Bail out early means to do as much as possible until a raw non-compliant
lock has to be taken.

-- 
Michal Hocko
SUSE Labs
