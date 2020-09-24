Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8B5276FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgIXLQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgIXLQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:16:50 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D76C0613CE;
        Thu, 24 Sep 2020 04:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L0W7Y57hfB+sKNmMyauoXW4J1vjmTW/bBWQCemTSomo=; b=EFQMCtvpz0VPW66XEnnTwBcq8N
        tYhRh2uod3w6Q7FSpDE1sn4xQKpv3KWg1K2QSNaFTj/QggNtOG6Q2UKK3YRHEMeELGs//+iv0UV7l
        tUtjpxTIfrVajvIMBrYTB4c6spS91ujrobtXG6oyhGNCMYaFB8+qGNAEOS/BVhrBQP5tTeFOS8PkI
        MDSyq8HctjRptuqLmOJm0AjpcrbgDaBqrQovXwppvzhfXlUjtf81lCF7R5BMB8i0T7f1MrLOX7HyQ
        Ff00LG5TQsqIpfKn4rmUIDJY5XbouPeCo+pYDMLXfl0iBwgL13whg+w3+InWaTvsMsMiyu8fyGqsM
        DoytgZJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLPEo-0004PT-6z; Thu, 24 Sep 2020 11:16:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 61F27303DA0;
        Thu, 24 Sep 2020 13:16:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AD32203161DB; Thu, 24 Sep 2020 13:16:32 +0200 (CEST)
Date:   Thu, 24 Sep 2020 13:16:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200924111632.GD2628@hirez.programming.kicks-ass.net>
References: <20200921074716.GC12990@dhcp22.suse.cz>
 <20200921154558.GD29330@paulmck-ThinkPad-P72>
 <20200921160318.GO12990@dhcp22.suse.cz>
 <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924081614.GA14819@pc636>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 10:16:14AM +0200, Uladzislau Rezki wrote:
> Other option is if we had unconditionally enabled PREEMPT_COUNT config.
> It would be easy to identify a context type and invoke a page allocator
> if a context is preemtale. But as of now preemptable() is "half" working.
> Thomas uploaded patches to make it unconditional. But it can be blocked.

While I in principle support Thomas' patch, I think this is an abuse and
still complete wrong.

Not all preemptible() context can deal with GFP_KERNEL (GFP_NOFS
existing should be a clue). !preemptible context cannot unconditionally
deal with GFP_NOWAIT, consider using it while holding zone->lock.

The preemption context does not say antying much useful about the
allocation context.
