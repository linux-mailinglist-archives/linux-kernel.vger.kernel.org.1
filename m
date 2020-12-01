Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64ABC2CAC77
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392355AbgLATg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387432AbgLATg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:36:28 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDBAC0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R5SUCHQ8/qMgiIJHmUJrStDsWioTT1j3yJ0DpJ9zmSU=; b=HdBRnDEQiteQwPVOHhvT3zvcDy
        mmCd0JGSpuH3LgwPwv8wUiImHZ9c3fUx6J5JQGONMjRmUCYg+mp0ggmOFNXzTBtKV3A3/uxWoDI6q
        EJvdI+NRylkY/tO4JWqkheL8iiOaG9TzWexLWfFY02ksuf74WvnNrLSF0QjssuscWebSidmsaifiY
        4Ck6iZITkMLoIsP3OhepTBOBIAMK5Aj7xRGKNiiRSNQvcy1N/CMvsEXRoKPhuJcIc0FiAOpw7oh1r
        qcmhuQgHexEWpc4gwu8ZegZXVO5HPjZJwogtGMDLJlD6SWWQPDJavQFy7gynigSZXLfz2dXwR96bg
        tGcWMGfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkBQM-00068c-O6; Tue, 01 Dec 2020 19:34:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD853302753;
        Tue,  1 Dec 2020 20:34:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 981022C55544B; Tue,  1 Dec 2020 20:34:51 +0100 (CET)
Date:   Tue, 1 Dec 2020 20:34:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
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
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 22/32] sched: Split the cookie and setup per-task
 cookie on fork
Message-ID: <20201201193451.GY3040@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-23-joel@joelfernandes.org>
 <20201125111014.GS2414@hirez.programming.kicks-ass.net>
 <20201201192028.GA222419@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201192028.GA222419@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 02:20:28PM -0500, Joel Fernandes wrote:
> On Wed, Nov 25, 2020 at 12:10:14PM +0100, Peter Zijlstra wrote:
> > On Tue, Nov 17, 2020 at 06:19:52PM -0500, Joel Fernandes (Google) wrote:
> > > +void sched_core_tag_requeue(struct task_struct *p, unsigned long cookie, bool group)
> > > +{
> > > +	if (!p)
> > > +		return;
> > > +
> > > +	if (group)
> > > +		p->core_group_cookie = cookie;
> > > +	else
> > > +		p->core_task_cookie = cookie;
> > > +
> > > +	/* Use up half of the cookie's bits for task cookie and remaining for group cookie. */
> > > +	p->core_cookie = (p->core_task_cookie <<
> > > +				(sizeof(unsigned long) * 4)) + p->core_group_cookie;
> > 
> > This seems dangerous; afaict there is nothing that prevents cookie
> > collision.
> 
> This is fixed in a later patch by Josh "sched: Refactor core cookie into
> struct" where we are having independent fields for each type of cookie.

So I don't think that later patch is right... That is, it works, but
afaict it's massive overkill.

	COOKIE_CMP_RETURN(task_cookie);
	COOKIE_CMP_RETURN(group_cookie);
	COOKIE_CMP_RETURN(color);

So if task_cookie matches, we consider group_cookie, if that matches we
consider color.

Now, afaict that's semantically exactly the same as just using the
narrowest cookie. That is, use the task cookie if there is, and then,
walking the cgroup hierarchy (up) pick the first cgroup cookie.

(I don't understand the color thing, but lets have that discussion in
that subthread)

Which means you only need a single active cookie field.

IOW, you're just making things complicated and expensive.


