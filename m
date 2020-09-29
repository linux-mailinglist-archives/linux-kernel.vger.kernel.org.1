Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B1427D41C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgI2REw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgI2REw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:04:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5DB2208B8;
        Tue, 29 Sep 2020 17:04:50 +0000 (UTC)
Date:   Tue, 29 Sep 2020 13:04:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, kim.phillips@amd.com
Subject: Re: [PATCH] rcu,ftrace: Fix ftrace recursion
Message-ID: <20200929130449.12c474a5@gandalf.local.home>
In-Reply-To: <20200929165640.GV29330@paulmck-ThinkPad-P72>
References: <20200929113340.GN2628@hirez.programming.kicks-ass.net>
        <20200929103620.06762622@gandalf.local.home>
        <20200929144105.GU29330@paulmck-ThinkPad-P72>
        <20200929105416.757c47f0@gandalf.local.home>
        <20200929165640.GV29330@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 09:56:40 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > Well, I think we should actually apply both, but the comment needs to be
> > updated, as it will no longer be outside recursion. And the comment is
> > wrong now as well, as its only outside recursion protection for the
> > assist_func(). 
> > 
> > But it does prevent it from being always called for perf.
> > 
> >  * Make notrace because it can be called by the internal functions of
> >  * ftrace, and making this notrace removes unnecessary recursion calls.  
> 
> Fair enough.  ;-)
> 
> If I don't hear otherwise by late today (Tuesday), Pacific Time, I will
> update the comment and pull it into -rcu.  If you guys have some other
> route to mainline in mind, you have my Reviewed-by.  Either way, just
> let me know.

I'm currently testing the recursion fix and will push that to Linus when
done. But you can take the comment update through your tree.

Peter, are you OK if Paul changes your comment to what I suggested?

-- Steve
