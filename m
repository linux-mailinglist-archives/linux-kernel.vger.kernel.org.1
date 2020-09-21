Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9986271C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 09:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgIUHrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:47:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:47510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgIUHrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:47:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600674438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9i0kIJxHfcUjwHDlDqQFWcrJLdfDzO+qklY0v++fUcM=;
        b=f9awOxBIS+NYd8MBmsXro8e9poIUcVJyAN6gV8CcgrcuElzeDdmJp+h3+N/vXQRnY1kX3m
        bhL04Z1Wbx/Qh730kRMUS8CZtKUMkyQg4PvPPTgWg0D//j+KNshfsl118IrzsbQMtK73PQ
        SFNVYue3YGwLeGtMFOXSqsb4crubwow=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08BE8AFC0;
        Mon, 21 Sep 2020 07:47:54 +0000 (UTC)
Date:   Mon, 21 Sep 2020 09:47:16 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200921074716.GC12990@dhcp22.suse.cz>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918194817.48921-3-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18-09-20 21:48:15, Uladzislau Rezki (Sony) wrote:
[...]
> Proposal
> ========
> Introduce a lock-free function that obtain a page from the per-cpu-lists
> on current CPU. It returns NULL rather than acquiring any non-raw spinlock.

I was not happy about this solution when we have discussed this
last time and I have to say I am still not happy. This is exposing
an internal allocator optimization and allows a hard to estimate
consumption of pcp free pages. IIUC this run on pcp cache can be
controled directly from userspace (close(open) loop IIRC) which makes it
even bigger no-no.

I strongly agree with Thomas http://lkml.kernel.org/r/87tux4kefm.fsf@nanos.tec.linutronix.de
that this optimization is not aiming at reasonable workloads. Really, go
with pre-allocated buffer and fallback to whatever slow path you have
already. Exposing more internals of the allocator is not going to do any
good for long term maintainability.
-- 
Michal Hocko
SUSE Labs
