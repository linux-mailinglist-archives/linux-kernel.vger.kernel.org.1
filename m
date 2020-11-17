Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD632B6EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgKQTec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:34:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgKQTeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:34:31 -0500
Subject: Re: [GIT RFC PULL rcu/urgent] Fix lockdep issue in rcu_print_task_stall()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605641670;
        bh=9u2alr/eBIBnLGYgAkHHCiSootQTi9UxUpbgiCTXTtA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kLxcKM5g0ppLRootxDlxJkmL+h1OExOvHbFNAdHAN7ScWYxrKMEudGoZ8JNpYwJrP
         uJ5YLr2MM2hMwQTiQk3YnKIRozM++ELNZHqYfCK658BNnOYEFx+kEed59f4M7+UU8B
         o/IROqyF3j7PMc0bKQsgmW35l7mu58usN+Kmnhxs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201116220153.GA22623@paulmck-ThinkPad-P72>
References: <20201116220153.GA22623@paulmck-ThinkPad-P72>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201116220153.GA22623@paulmck-ThinkPad-P72>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git urgent-fixes
X-PR-Tracked-Commit-Id: c583bcb8f5edd48c1798798e341f78afb9bf4f6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9dacf44c3837b7f1cf460de904f352714e7cd107
Message-Id: <160564167056.32053.951909977465298481.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Nov 2020 19:34:30 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, kernel-team@fb.com, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, bigeasy@linutronix.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Nov 2020 14:01:53 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git urgent-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9dacf44c3837b7f1cf460de904f352714e7cd107

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
