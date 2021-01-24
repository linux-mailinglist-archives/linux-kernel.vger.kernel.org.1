Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8741C301E2E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 19:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbhAXSgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 13:36:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbhAXSgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 13:36:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A1D5022EBF;
        Sun, 24 Jan 2021 18:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611513293;
        bh=KzuPm+nd2rjJSNzb+d+/zKXQCTWyqKJ10Uwy04U38FQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iAdhRx96DL37NAncg+cBeS5n1dkqQt4TfrHNHnlVhfqyII9M4+T4qFR4oabhvDsTv
         fb1qIOzl2NPoxiRVNnUosW2b/qQcTHhcKEibYEZLuJrGZ0XAUYp1rXd7aNvbETRsw0
         qVMUmo5py0vNmNF4/efCVelz47vwG0DBmATzVLKcyJSsVebRt/6n0QM/3gp+XPH488
         8zvz48+Tmbc89kCQXsNSzo+dXbt7ukhzCut56oO05n/WzOAhVYou31V4TJk8dHG/1o
         1NBh58y9wZYx0AvRrAm6ip9uQFeINpsUCphIgkaC0iqoWa5chJDA+2f8LMuggIodEA
         X9X9zxDbVn+Gw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9D6EC652F2;
        Sun, 24 Jan 2021 18:34:53 +0000 (UTC)
Subject: Re: [GIT PULL] misc fixes for v5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210124125121.3969248-1-christian.brauner@ubuntu.com>
References: <20210124125121.3969248-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210124125121.3969248-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2021-01-24
X-PR-Tracked-Commit-Id: cb5021ca622fe83923e0789f99fe7227cbcd3f68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c509ce2378e196758095c292f7a1df826d971796
Message-Id: <161151329363.2223.2404868023238243321.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Jan 2021 18:34:53 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Jan 2021 13:51:22 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2021-01-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c509ce2378e196758095c292f7a1df826d971796

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
