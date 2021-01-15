Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B282F87C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 22:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbhAOVhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 16:37:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbhAOVho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 16:37:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 42707239FC;
        Fri, 15 Jan 2021 21:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610746624;
        bh=DWKpwOCZuqWxQR1DrOISId7eHotSoxZp2G8kKiV6KsM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KlAFEUDODLPs0MjPPClJzF56GLaPcmWHv7hzUH2piiZL2/CPSB7HD0UspvLzkTwEv
         fWeNmGTQWki2xDisMGYcJd7mh9skMoxRN9Ux3WNGMe1ZxI/fnD3ksntyTPOvrmdh14
         VhWhf5WQ355PeIt8WzeFQ13hcvCvoikotT/1nzN74d/4Mb6e9wnUXayorXd30z1cPq
         yQ51FM7iptl8qBchtx/jWYEINowB26pHjExBJQdD3FCGzC58KFjlBqcVD25U+pHcDk
         FAe5c3QNsen0k8LQgYyTkcI82CKp5uuq/RA5UzSzt7z6k1Syo6uYkUmwD1SijLwI6A
         GI684SsiJep7A==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 3C2B760156;
        Fri, 15 Jan 2021 21:37:04 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.11-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210115181544.GA8353@gaia>
References: <20210115181544.GA8353@gaia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210115181544.GA8353@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 3a57a643a851dbb1c4a1819394ca009e3bfa4813
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82821be8a2e14bdf359be577400be88b2f1eb8a7
Message-Id: <161074662423.20929.3177008628194297256.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Jan 2021 21:37:04 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Jan 2021 18:15:46 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82821be8a2e14bdf359be577400be88b2f1eb8a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
