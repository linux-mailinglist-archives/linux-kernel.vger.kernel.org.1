Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672B62DA50F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 01:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgLOAuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 19:50:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgLOAuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 19:50:18 -0500
Subject: Re: [GIT PULL] arm64 updates for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607993378;
        bh=CbrF9a5nfuYDl4lK8KT8FIAsGocEdDRGgRuz4L/TlWY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=k124Uy5hhTV3CWqdbZQQujK3yjdeFWIbY9UMJr25DBphPIqDLlD5b1gIhLCMpDGVP
         VOWGvsCzUnruzDGH/91Vb5XMZ/OttGZqfPuYY1NUQKidbSfiPyF8/690LXGl7Q1RoY
         rwLaeM9mnzfvQaIfX8xagHozRqC282ORsRPalcIwiYWEDY7ItI0vvTh9s/k5L5dHEj
         iac7gXgJGyR0JXu57g83RwF/kraqu6xEiCixsDi0ezzugCgGd/KQc+Ft+nvlBjRvTd
         hPWY6EIqFHqzvcZPlPyXv0y19hRtl81uBPfiyQX3gMdpAoNs0KlJpaRPELTXKOpk8x
         AWq4LiD0gtDXQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214182854.14862-1-catalin.marinas@arm.com>
References: <20201214182854.14862-1-catalin.marinas@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20201214182854.14862-1-catalin.marinas@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: d889797530c66f699170233474eab3361471e808
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ca2ce81eb8ee30f3ba8ac7967fef9cfbb44dbdb
Message-Id: <160799337782.8612.11468203804945480355.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 00:49:37 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 18:28:54 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ca2ce81eb8ee30f3ba8ac7967fef9cfbb44dbdb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
