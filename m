Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBD620CADE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 00:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgF1WFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 18:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgF1WFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 18:05:15 -0400
Subject: Re: [GIT PULL] perf fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593381914;
        bh=cawQOtmyuk51sj6DP9MmBQhH8A8uaxRQZAQti52v2HM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kiySRo9szAbQRDZ1SZlk0JGGoy4Zd09QqqXf6trw9ZxwaJYOYB+6t9sncOiECBtz1
         b53uy/QrsSoTppo5mCw4l66powXPY14Cvls1BAS2dFu+o3qSaaKxjQwx2CLMpFaGOX
         BFdZtkb9eAOESmjivx4HYBlTKFvp4x0L7TY5iiGw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200628183323.GA127831@gmail.com>
References: <20200628183323.GA127831@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200628183323.GA127831@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-2020-06-28
X-PR-Tracked-Commit-Id: 16accae3d97f97d7f61c4ee5d0002bccdef59088
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae71d4bf0074a81cc04255c96e3de0a49b1d95fa
Message-Id: <159338191470.4690.3078221347882632930.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jun 2020 22:05:14 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Jun 2020 20:33:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae71d4bf0074a81cc04255c96e3de0a49b1d95fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
