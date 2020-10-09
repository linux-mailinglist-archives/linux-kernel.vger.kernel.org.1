Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FAB289C0C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 01:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgJIXON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 19:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgJIXOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 19:14:12 -0400
Received: from localhost (unknown [176.164.200.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EA0D222EB;
        Fri,  9 Oct 2020 23:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602285251;
        bh=l2U6CjZx9TygARxZeTvKgdT2J+ZVJfnAffaUI+8Mcl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BkWm7XSkhPu3t6TfNTM6e+Ps02BvK52EEcJneG+zNGknefoB4ktuGpByNQ4EFzcEw
         KFpIq3nrbL3zaS/TXM6QQHHbTjQbNngqq/H6qUUYQguTd1hs2f4Achc/IPcK5U9wUc
         rTh42TGz5y4MRBLElKLZC1T2KAXVzmDP3PQzwVBs=
Date:   Sat, 10 Oct 2020 01:14:09 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH v6 1/4] rcu/tree: Make rcu_do_batch count how many
 callbacks were executed
Message-ID: <20201009231409.GA120772@lothringen>
References: <20200923152211.2403352-1-joel@joelfernandes.org>
 <20200923152211.2403352-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923152211.2403352-2-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 11:22:08AM -0400, Joel Fernandes (Google) wrote:
> Currently, rcu_do_batch() depends on the unsegmented callback list's len field
> to know how many CBs are executed. This fields counts down from 0 as CBs are
> dequeued.  It is possible that all CBs could not be run because of reaching
> limits in which case the remaining unexecuted callbacks are requeued in the
> CPU's segcblist.
> 
> The number of callbacks that were not requeued are then the negative count (how
> many CBs were run) stored in the rcl->len which has been counting down on every
> dequeue. This negative count is then added to the per-cpu segmented callback
> list's to correct its count.
> 
> Such a design works against future efforts to track the length of each segment
> of the segmented callback list. The reason is because
> rcu_segcblist_extract_done_cbs() will be populating the unsegmented callback
> list's length field (rcl->len) during extraction.
> Also, the design of counting down from 0 is confusing and error-prone IMHO.

Right :)

> 
> This commit therefore explicitly counts have many callbacks were executed in

s/have/how

> rcu_do_batch() itself, and uses that to update the per-CPU segcb list's ->len
> field, without relying on the negativity of rcl->len.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks.
