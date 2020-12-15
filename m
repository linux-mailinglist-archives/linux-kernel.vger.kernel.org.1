Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28EE2DA630
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 03:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgLOCW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 21:22:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgLOCWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 21:22:30 -0500
Subject: Re: [GIT pull] core/rcu for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607998910;
        bh=PsPwuetWbM2v2nJsEoaKIBpK0heC6SlaeV51UmxKdl8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lNyDcFgbSnIC9H76hNA9wXMKGsStU9B8C7TY8itdPAbjmPTsrRPGCU4lw4hZiVLY0
         dFbiR/gMcdEIhfb/NMuZM1SyLfiM0idtAIMdeXJ7xN9WPp/4nTsR2kDF+SfN61oRcw
         9JVnTpASE/82F/Fo4icKzR+HxNEtqshdtEmxJ0xm1FA1qlzCW2gm5UlKOc/9XinfDA
         2k51DU8P5pk47TZ88uwqIFQvzRnxgiKM/YO24NSvuQtXp2QvtXqCatTd6GmJzOnuzj
         l/bHOJQI0mTE4sdjdxaaL8gEbZ3g2Sz7cz/0FlaeRXyCac0Pxp/bQ1AC6BP9yLcrbM
         T/6rjZNATglbw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160797733061.10793.14355556994633266637.tglx@nanos>
References: <160797732939.10793.9152151866806316627.tglx@nanos> <160797733061.10793.14355556994633266637.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160797733061.10793.14355556994633266637.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-2020-12-14
X-PR-Tracked-Commit-Id: 50df51d12c3175573de9c94968639bdd625ec549
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c1dccc80380fca8db09c2a81f5deb3c49b112b2
Message-Id: <160799891031.23883.8192784969461999416.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 02:21:50 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 20:22:10 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-2020-12-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c1dccc80380fca8db09c2a81f5deb3c49b112b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
