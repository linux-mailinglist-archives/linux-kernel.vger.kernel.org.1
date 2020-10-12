Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC1628B858
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389984AbgJLNvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389796AbgJLNuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:50:03 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBAF220679;
        Mon, 12 Oct 2020 13:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602510603;
        bh=7X8bVdnQgnIMzhQQANV8paL2JOnyHOjTZlmsrZklMVc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XAugCkaRzTdRLkMSYNvaddNMFMx4h/puIWOU9hkx5tYisS/v49Pkx7k7z6Ioa9fm9
         rF9CqiVNKmPRRgFoh+YReZfZ6iueuKUT+pvVn3NJskyItQCI5V8IoDF7qIBgxdJCeq
         4gI2YQU0Ba7UwXmUq7Z8G1RmuxprcMSOrMY8GcwU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9E2CC352272C; Mon, 12 Oct 2020 06:50:02 -0700 (PDT)
Date:   Mon, 12 Oct 2020 06:50:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH v6 1/4] rcu/tree: Make rcu_do_batch count how many
 callbacks were executed
Message-ID: <20201012135002.GB3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200923152211.2403352-1-joel@joelfernandes.org>
 <20200923152211.2403352-2-joel@joelfernandes.org>
 <20201009231409.GA120772@lothringen>
 <CAEXW_YQPFM81EXi+7c6ed9b2ULw4YmtfGzmT1GKUGVu5v6CyGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQPFM81EXi+7c6ed9b2ULw4YmtfGzmT1GKUGVu5v6CyGg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 09:35:37AM -0700, Joel Fernandes wrote:
> On Fri, Oct 9, 2020 at 4:14 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > On Wed, Sep 23, 2020 at 11:22:08AM -0400, Joel Fernandes (Google) wrote:
> > > Currently, rcu_do_batch() depends on the unsegmented callback list's len field
> > > to know how many CBs are executed. This fields counts down from 0 as CBs are
> > > dequeued.  It is possible that all CBs could not be run because of reaching
> > > limits in which case the remaining unexecuted callbacks are requeued in the
> > > CPU's segcblist.
> > >
> > > The number of callbacks that were not requeued are then the negative count (how
> > > many CBs were run) stored in the rcl->len which has been counting down on every
> > > dequeue. This negative count is then added to the per-cpu segmented callback
> > > list's to correct its count.
> > >
> > > Such a design works against future efforts to track the length of each segment
> > > of the segmented callback list. The reason is because
> > > rcu_segcblist_extract_done_cbs() will be populating the unsegmented callback
> > > list's length field (rcl->len) during extraction.
> > > Also, the design of counting down from 0 is confusing and error-prone IMHO.
> >
> > Right :)
> 
> :)
> 
> > > This commit therefore explicitly counts have many callbacks were executed in
> >
> > s/have/how
> >
> > > rcu_do_batch() itself, and uses that to update the per-CPU segcb list's ->len
> > > field, without relying on the negativity of rcl->len.
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Thanks! Paul would be Ok to make the minor fixup s/have/how/ that
> Frederic pointed?

But of course!  I was waiting until Frederic gets them all reviewed,
with an eye to applying and wordsmithing them as a set.

> - Joel
> (Due to COVID issues at home, I'm intermittently working so advance
> apologies for slow replies.)

And I hope that this is going as well as it possibly can!

							Thanx, Paul
