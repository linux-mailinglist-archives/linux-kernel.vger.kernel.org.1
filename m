Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7668D28C3F7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732155AbgJLVZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732121AbgJLVZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:25:06 -0400
Subject: Re: [GIT PULL] scheduler changes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602537906;
        bh=S7ekBZ0GuN0U6SMQ6sbQD78G/FPbYd6HwOExOLoD4ME=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=C/i03u5JiZ6OyZONN0FBXdu9k1q27cjQl/WOokvdzPRzhXZaswit3MgHZSRSYFAGF
         aFTSUMXl/GmtzxHvyjtWK/3k3nbA9vVjY/ffbrOb68Q2CXMfNioJ8kxOACNFHLUIZk
         0csquKMZZQ+OtpnBMOUqAdfhFK5Y3ucfux1YpqwU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012133701.GA3206705@gmail.com>
References: <20201012133701.GA3206705@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012133701.GA3206705@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2020-10-12
X-PR-Tracked-Commit-Id: feff2e65efd8d84cf831668e182b2ce73c604bbb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: edaa5ddf3833669a25654d42c0fb653dfdd906df
Message-Id: <160253790651.926.8634591790843888306.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 21:25:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 15:37:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/edaa5ddf3833669a25654d42c0fb653dfdd906df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
