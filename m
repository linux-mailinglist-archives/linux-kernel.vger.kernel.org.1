Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B913F282E79
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 02:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgJEAS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 20:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:32814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgJEAS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 20:18:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2C55206B6;
        Mon,  5 Oct 2020 00:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601857136;
        bh=0PRbYKqOJWD7i8Tsch9Sw20KniYBGQmRVsBXM4bljJ8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SsS0uTOZ30Z5RUulBZ72nJTsbLZbrSL+vci59Wk/Ht4Z0Shk8QjPrYk7fkiWkFGuY
         O+5OXulMlOBBuuQZe/vANH6A/LTiRzV7qE2L6AU2ifXp/riwZhPjM9WiQknm71lm4k
         OOKfou8pHvXTDlFNTMF/cn25s/46N/to9mVbIw4I=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 74A4035225F2; Sun,  4 Oct 2020 17:18:56 -0700 (PDT)
Date:   Sun, 4 Oct 2020 17:18:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, kim.phillips@amd.com
Subject: Re: [PATCH] rcu,ftrace: Fix ftrace recursion
Message-ID: <20201005001856.GT29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200929113340.GN2628@hirez.programming.kicks-ass.net>
 <20200929103620.06762622@gandalf.local.home>
 <20200929144105.GU29330@paulmck-ThinkPad-P72>
 <20200929105416.757c47f0@gandalf.local.home>
 <20200929165640.GV29330@paulmck-ThinkPad-P72>
 <20200929130449.12c474a5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929130449.12c474a5@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 01:04:49PM -0400, Steven Rostedt wrote:
> On Tue, 29 Sep 2020 09:56:40 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > Well, I think we should actually apply both, but the comment needs to be
> > > updated, as it will no longer be outside recursion. And the comment is
> > > wrong now as well, as its only outside recursion protection for the
> > > assist_func(). 
> > > 
> > > But it does prevent it from being always called for perf.
> > > 
> > >  * Make notrace because it can be called by the internal functions of
> > >  * ftrace, and making this notrace removes unnecessary recursion calls.  
> > 
> > Fair enough.  ;-)
> > 
> > If I don't hear otherwise by late today (Tuesday), Pacific Time, I will
> > update the comment and pull it into -rcu.  If you guys have some other
> > route to mainline in mind, you have my Reviewed-by.  Either way, just
> > let me know.
> 
> I'm currently testing the recursion fix and will push that to Linus when
> done. But you can take the comment update through your tree.
> 
> Peter, are you OK if Paul changes your comment to what I suggested?

Hearing no objections, I have queued the patch with the comment updated
as suggested by Steven.  Thank you all!

							Thanx, Paul
