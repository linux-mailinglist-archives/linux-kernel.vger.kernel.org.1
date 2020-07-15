Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B203220EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 16:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgGOOM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 10:12:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgGOOM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:12:27 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC1C1205CB;
        Wed, 15 Jul 2020 14:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594822346;
        bh=Sd6qj++/pkBAkKGOFyJiYesklyaJ3nNkMOOe9MXP87o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Y6XFF7zosG3rUgD7k/npIlm0M8ZCPkRW5lg20eQBa4lgw63mAaSUffcxXPSm0vAfL
         esm5PvwNNUWOY9lXkF6cu2uk6ytbupHoktP+lRFjeoLXAu59RwjuQt7F1cEFh0iPvq
         6FZqc3dJ41E5uJgEC7vFV39XE+ZZveJIqxncz8w8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B1FF23522636; Wed, 15 Jul 2020 07:12:26 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:12:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, arnd@arndb.de, elver@google.com, ethp@qq.com,
        frederic@kernel.org, jbi.octave@gmail.com, joel@joelfernandes.org,
        lihaoliang@google.com, madhuparnabhowmik10@gmail.com,
        mchehab+huawei@kernel.org, peter.enderborg@sony.com,
        rdunlap@infradead.org, richard.weiyang@linux.alibaba.com,
        zou_wei@huawei.com, tglx@linutronix.de
Subject: Re: [GIT PULL tip/core/rcu] RCU commits for v5.9
Message-ID: <20200715141226.GB9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200714172701.GA31369@paulmck-ThinkPad-P72>
 <20200714181426.hhguqzrcqdubyvae@linutronix.de>
 <20200714182732.GU9247@paulmck-ThinkPad-P72>
 <20200714201734.GA20470@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714201734.GA20470@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:17:34PM +0200, Uladzislau Rezki wrote:
> On Tue, Jul 14, 2020 at 11:27:32AM -0700, Paul E. McKenney wrote:
> > On Tue, Jul 14, 2020 at 08:14:26PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2020-07-14 10:27:01 [-0700], Paul E. McKenney wrote:
> > > > Joel Fernandes (Google) (5):
> > > >       rcu/tree: Skip entry into the page allocator for PREEMPT_RT
> > > 
> > > If it is too late to drop this then I am going send a revert okay?
> > 
> > I believe that Ulad and Joel are working on an update.
> > 
> > Now that you mention it Ulad and Joel, how is this coming along?
> > 
> Yes. I have made a proposal with dropping the lock. I do not see
> any issues by doing that. I will upload a patch soon.

Looking forward to seeing it!

							Thanx, Paul
