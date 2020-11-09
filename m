Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422022AC0A8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgKIQUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:20:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgKIQUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:20:07 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A53B1206CB;
        Mon,  9 Nov 2020 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604938806;
        bh=oqLUZkDJovPnphDNZNNfXtQR+B26RG6pDlvnApy5MHQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l3IWgbhDy1rVVerCwZSglLg4bgbYQHx6Y+06kRROZy1RDdKRBJBc6kV7DGkEMogP9
         Vc+YcT+TMAoNbHcpjY6+Cw56kQ2Wdxy9dvnBVBQZoxirIIcgntok2+dpUmNhpmbLux
         VLwYF784LhGFQoHxGF5twyWQ0kUZpwnzyl+DadoE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5012F352264D; Mon,  9 Nov 2020 08:20:06 -0800 (PST)
Date:   Mon, 9 Nov 2020 08:20:06 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/4] doc: Present the role of READ_ONCE()
Message-ID: <20201109162006.GJ3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201105230444.GA18574@paulmck-ThinkPad-P72>
 <20201105230510.18660-1-paulmck@kernel.org>
 <20201109122133.GL2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109122133.GL2594@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 01:21:33PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 05, 2020 at 03:05:07PM -0800, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > This commit adds an explanation of the special cases where READ_ONCE()
> > may be used in place of a member of the rcu_dereference() family.
> 
> I am confused, there is no actual difference between rcu_dereference()
> and READ_ONCE() today. So we _may_ use READ_ONCE() at all times.
> 
> Now granted, we probably don't want that, but that does leave me
> somewhat confused vs the wording here.

There is a difference from the viewpoint of both lockdep and sparse.

Or am I missing your point?

							Thanx, Paul
