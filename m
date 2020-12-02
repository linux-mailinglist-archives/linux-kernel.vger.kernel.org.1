Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D212CC84C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387466AbgLBUt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:49:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729825AbgLBUtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:49:25 -0500
Subject: Re: [GIT PULL] arm64 fixes for -rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606942125;
        bh=u8DgX5dJriNH0RIYB0H2MelkdFjKcwtN9niIdi5vKsY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BL9qTJjCq1jZtWW8JmZJ5HLY1dlsc6zLRfiFOYgTEil6Wc4psbS35ePWdrGyNA/uw
         TnIUEuM6fKQC2AlrmXD6YkVOGadnpT2IA3BwYk5H8ahG4eRfM3luXo7gi2lVwfHpYi
         x1bpA9hS0vCaD924GSPXTKWZcyWvAe8XCsK2VJvB4FVV/ZmcjWqO/j6giMPqEhShf1
         DttJPrLBHzDIqpBatQ7uAF8i02UiNQYSSgXNYEihivJLzMoaZjsiGwb2hXfseSup4c
         eT12lC4PfJM3FxakcJ0JAuKk2MYU83xZJVNPzt2oMXPPDVU3nXCNk5/3xutbBE24FB
         r3ywe2sTNO7Og==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201202171750.GA29813@willie-the-truck>
References: <20201202171750.GA29813@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20201202171750.GA29813@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 9e5344e0ffc33f4fee899f98b6939a0682b1d9c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bb61aa61828499a7d0f5e560051625fd02ae7e4
Message-Id: <160694212489.5087.2480409779405501777.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Dec 2020 20:48:44 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, mark.rutland@arm.com,
        peterz@infradead.org, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        linux-arm-kernel@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 2 Dec 2020 17:17:51 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bb61aa61828499a7d0f5e560051625fd02ae7e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
