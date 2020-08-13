Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4325F243EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 20:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgHMSbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 14:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMSbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 14:31:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7E6C061757;
        Thu, 13 Aug 2020 11:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SH9o16/Qf0/iPL9rM1LGxVVZdzQj3ynCJRzANMbMLh8=; b=OABqsCGbsESN3jXxQUyFvsjtkH
        Trbqm8qEElLJ+OBn/xH1496gay5z4y2bWGu+yakc/VBmK6oj1HYPkZEID8voaWSpzi5WstQDz9Ad9
        mcEeXP+y4WcGjuPCYmG7caPiU0Qhp3KMixtAtoLsYaEax+P/iPVYKrrHAfBjNGeMjRh0HRUfsfOOY
        E+rUEqRQQ2LcwdmvSiUdQ+LcaHY8TTrjkH5wFJJ3/oU/s1/PGZK2+51nfIi1W3zHQDzXIXASm4Qc7
        3DvNaqO++o1tXrkKZffjdR//a+dY2E2odqWzH0ZLqnb9tfuwo/KITb0YEnfUTQhxhu7MyJYUWM3GD
        xssnZqGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6I0Z-00020f-Fv; Thu, 13 Aug 2020 18:31:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C7E2B304D58;
        Thu, 13 Aug 2020 20:31:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5A0A2B929A4A; Thu, 13 Aug 2020 20:31:21 +0200 (CEST)
Date:   Thu, 13 Aug 2020 20:31:21 +0200
From:   peterz@infradead.org
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
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
Message-ID: <20200813183121.GY2674@hirez.programming.kicks-ass.net>
References: <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813145335.GN9477@dhcp22.suse.cz>
 <20200813154159.GR4295@paulmck-ThinkPad-P72>
 <20200813155412.GP9477@dhcp22.suse.cz>
 <20200813160442.GV4295@paulmck-ThinkPad-P72>
 <20200813161357.GQ9477@dhcp22.suse.cz>
 <20200813162904.GX4295@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813162904.GX4295@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 09:29:04AM -0700, Paul E. McKenney wrote:
> OK.  So the current situation requires a choice between these these
> alternatives, each of which has shortcomings that have been mentioned
> earlier in this thread:
> 
> 1.	Prohibit invoking allocators from raw atomic context, such
> 	as when holding a raw spinlock.

This! This has always been the case, why are we even considering change
here?

> 2.	Adding a GFP_ flag.

The patch 1/2 in this thread is horrendous crap.

> 3.	Reusing existing GFP_ flags/values/whatever to communicate
> 	the raw-context information that was to be communicated by
> 	the new GFP_ flag.
> 
> 4.	Making lockdep forgive acquiring spinlocks while holding
> 	raw spinlocks, but only in CONFIG_PREEMPT_NONE=y kernels.
> 
> Am I missing anything?

How would 4 solve anything?


In other words, what is the actual friggin problem? I've not seen one
described anywhere.
