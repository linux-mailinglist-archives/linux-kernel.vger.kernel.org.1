Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071E11AAF73
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410920AbgDORXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410909AbgDORXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:23:42 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E167920784;
        Wed, 15 Apr 2020 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971421;
        bh=D7TBTILX71mxJ/G39+SJi/LEpI7HgDThUM+arZejPt0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ce0dVEwRUjcdQa1AQhypGcCw6AtRqrLvsPgK1G4m69dT+ZCRvRtBcBlSDL8EGjFov
         q51xfev0LwMONCNaF9lc+wr/p2vP+5iruosviI867n0k+WRxy3bWD7+GfA4nzvnYW2
         c0q5M7QfDi+zPbTOCDW4Ml7DZIzt4kkkkHx7CEjw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B39053522AD1; Wed, 15 Apr 2020 10:23:41 -0700 (PDT)
Date:   Wed, 15 Apr 2020 10:23:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/3] RCU stall-warning updates for v5.8
Message-ID: <20200415172341.GA9519@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides a few updates to RCU CPU stall-warning messages.

1.	Use data_race() for RCU expedited CPU stall-warning prints.

2.	When GP kthread is starved, tag idle threads as false positives.
	After all, it is not the idle threads' fault that the GP
	kthread hasn't reported their extended quiescent states!

3.	Remove self-stack-trace when all quiescent states seen.

							Thanx, Paul

------------------------------------------------------------------------

 tree_exp.h   |    8 ++++----
 tree_stall.h |   26 +++++++++++++++++++-------
 2 files changed, 23 insertions(+), 11 deletions(-)
