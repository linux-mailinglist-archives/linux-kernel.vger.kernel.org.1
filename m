Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B54B20C683
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 08:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgF1GoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 02:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgF1GoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 02:44:11 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0602820720;
        Sun, 28 Jun 2020 06:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593326650;
        bh=zp+3MOyRJMHPpxNsawCvOr1Niz/qiZWLG0Gnl9vRNRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Q4vE9PbwfLwUXw6GM+IqC+NqKKGg9enwoUA7ZQ/dzw3/dwIEZ5kv2bHnOEHJiDYb
         CdsShh4/aLVaKk1CwaLXPnrcGy3vAck8556RV48QZkqGdDzavSJc0JN5ZVzZtMlriE
         ciRZokKyhZuIGH6OvMuEtybtG9DpeRQnWqCUlL+0=
Date:   Sun, 28 Jun 2020 09:44:03 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] sched: fix build with GCC_PLUGIN_RANDSTRUCT
Message-ID: <20200628064403.GA576120@kernel.org>
References: <20200620104136.12195-1-rppt@kernel.org>
 <20200627181214.3a4d4a42@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627181214.3a4d4a42@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 06:12:14PM -0400, Steven Rostedt wrote:
> On Sat, 20 Jun 2020 13:41:36 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Since the commit a148866489fb ("sched: Replace rq::wake_list")
> > task_struct and CSD_TYPE_TTWU objects can be on the same queue and this
> > requires that have "layout similar enough".
> > 
> > This assumption is broken when CONFIG_GCC_PLUGIN_RANDSTRUCT is enabled:
> 
> You forgot to Cc Kees, who's the one that is probably the most
> concerned about randomizing structures!

I was not concerned about randomizing, I was troubled by failing
allyesconfig builds :)

> >  	/*
> >  	 * This begins the randomizable portion of task_struct. Only
> >  	 * scheduling-critical items should be added above here.
> > @@ -654,8 +663,6 @@ struct task_struct {
> >  	unsigned int			ptrace;
> >  
> >  #ifdef CONFIG_SMP
> > -	struct llist_node		wake_entry;
> > -	unsigned int			wake_entry_type;
> 
> What about instead just create an anonymous structure of the two. That
> way they can still be randomized within the task struct and not be a
> target of attacks?
> 
> 	struct {
> 		struct llist_node	wake_entry;
> 		unsigned int		wake_entry_type;
> 	};
> 
> Would that work?

Yep, thanks, this works.
Will send v2 soon.

> -- Steve
> 
> 
> >  	int				on_cpu;
> >  #ifdef CONFIG_THREAD_INFO_IN_TASK
> >  	/* Current CPU: */
> 

-- 
Sincerely yours,
Mike.
