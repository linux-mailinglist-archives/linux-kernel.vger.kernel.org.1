Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FF1273324
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgIUTtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgIUTtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:49:22 -0400
Subject: Re: [GIT RFC PULL rcu/urgent] Fix rcu-tasks compilation warning
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600717762;
        bh=fIJX4iLM9IINp3omTvJPa6lNLy0ndHj4JbsM3gJs0bA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QKKeg5yA1HYiLMyUk6Xo8gZNRTJKpAAjIgj0Gi1GNCFQpni+NYDZQXEbxys2au3Ns
         W8rbSzHAUFn3qVdKo6pb4MLyiowhq7XxdU34ACJOlttOIIXP7srwmXN6muE/I+SSMB
         54UqWoJ4gvm/YbrlyTLKJGsB9GpjxI5KvJcvUEkI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200921193703.GA20208@paulmck-ThinkPad-P72>
References: <20200921193703.GA20208@paulmck-ThinkPad-P72>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200921193703.GA20208@paulmck-ThinkPad-P72>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/urgent
X-PR-Tracked-Commit-Id: 78edc005f477a4987ee0a5d96bfe117295c231fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98477740630f270aecf648f1d6a9dbc6027d4ff1
Message-Id: <160071776212.12936.11918766034750605828.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Sep 2020 19:49:22 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, laurent.pinchart@ideasonboard.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Sep 2020 12:37:03 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/urgent

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98477740630f270aecf648f1d6a9dbc6027d4ff1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
