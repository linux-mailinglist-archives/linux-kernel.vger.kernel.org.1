Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547932970F0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465161AbgJWNzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464793AbgJWNza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:55:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103FAC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DUM2mNQ4emo0v/3jqiFibKilR7KsDiF+au+361QHlpM=; b=MMuFyIj5elfx3kGM3uwhDp50uJ
        geYYk7luFdjZiJ43Jyw2RMXEdjF6tL6fn8s6hJUzGA+UJEGWcYw+GFVSClI6dGKHVSOWB17kruDUc
        HVL0QB0tRYOs3RoXQOCPQJu0BRcn35nENOLPe5DP9yWuVtOTPM5A8TwfGGlOj8g0CKhubjLTG/pUT
        LpTki7Rg64PH34z6LBWHJaGgjPl2RjugHYGLYTqSmRMNk022AxgTYaEO6CPkYkGHDUTDl53+UaF3g
        ts0e1Uqg/o8O37499KZB+4WoDkJGBIgayqSWbEeNkSmvXGlmnlVdHhvFPKXZ/CCDWRYxC5WCJcX3N
        nsAvOOdw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVxW5-0007mP-Jm; Fri, 23 Oct 2020 13:54:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66F7F304D2B;
        Fri, 23 Oct 2020 15:54:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5576C2B82561F; Fri, 23 Oct 2020 15:54:00 +0200 (CEST)
Date:   Fri, 23 Oct 2020 15:54:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 06/26] sched: Add core wide task selection and
 scheduling.
Message-ID: <20201023135400.GA2651@hirez.programming.kicks-ass.net>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-7-joel@joelfernandes.org>
 <20201023135129.GS2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023135129.GS2611@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 03:51:29PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 19, 2020 at 09:43:16PM -0400, Joel Fernandes (Google) wrote:
> > +			/*
> > +			 * If this sibling doesn't yet have a suitable task to
> > +			 * run; ask for the most elegible task, given the
> > +			 * highest priority task already selected for this
> > +			 * core.
> > +			 */
> > +			p = pick_task(rq_i, class, max);
> > +			if (!p) {
> > +				/*
> > +				 * If there weren't no cookies; we don't need to
> > +				 * bother with the other siblings.
> > +				 * If the rest of the core is not running a tagged
> > +				 * task, i.e.  need_sync == 0, and the current CPU
> > +				 * which called into the schedule() loop does not
> > +				 * have any tasks for this class, skip selecting for
> > +				 * other siblings since there's no point. We don't skip
> > +				 * for RT/DL because that could make CFS force-idle RT.
> > +				 */
> > +				if (i == cpu && !need_sync && class == &fair_sched_class)
> > +					goto next_class;
> > +
> > +				continue;
> > +			}
> 
> I'm failing to understand the class == &fair_sched_class bit.
> 
> IIRC the condition is such that the core doesn't have a cookie (we don't
> need to sync the threads) so we'll only do a pick for our local CPU.
> 
> That should be invariant of class.

That is; it should be the exact counterpart of this bit:

> +			/*
> +			 * Optimize the 'normal' case where there aren't any
> +			 * cookies and we don't need to sync up.
> +			 */
> +			if (i == cpu && !need_sync && !p->core_cookie) {
> +				next = p;
> +				goto done;
> +			}

If there is no task found in this class, try the next class, if there
is, we done.
