Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49E42F84EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbhAOS6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:58:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbhAOS6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:58:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EE7A623A6C;
        Fri, 15 Jan 2021 18:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610737082;
        bh=4JjoI0+xHLeSfQpYYCNlnGBtgj7Hl02nV+poDWdHDew=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=chk4b/cPZEVM3GJ/sN8YA7Si7rGdTxemSf9XxpjYMYNFz3OoN3iX6rwX4PnkWuC8p
         FI4Xxhm1warQQPpGSvQOwlJsBwUuFWfw3MTyYJzpaB7m6KZ0JSycKXep1wIgnltqn9
         8n7XMRuMk0rOWAJ6DIa27RefGe8OhwYmH9YvYiJewMW3YtwQh9nqGM48PfFaXTBzLS
         zsWy0IjcwcehaFdzZe/7nnkE74sJ3fRUbX3wtFZpp7yduyTzq5Yj6RKj8yG+QOou3X
         9TpvjSozw2zQevTARuLfzgvLUEDjG6I5f9MjiBpIcaw61C6kCerLVOGc9qc9trLaU2
         kRaDVEbPDE6lw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id E76E460156;
        Fri, 15 Jan 2021 18:58:01 +0000 (UTC)
Subject: Re: [GIT PULL] IOMMU fixes for -rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210115112619.GA14253@willie-the-truck>
References: <20210115112619.GA14253@willie-the-truck>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20210115112619.GA14253@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes
X-PR-Tracked-Commit-Id: 694a1c0adebee9152a9ba0320468f7921aca647d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7aec71cd9c1f251ef17eae5f898c10133d49421d
Message-Id: <161073708194.18503.10792478323149655072.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Jan 2021 18:58:01 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Jan 2021 11:26:20 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7aec71cd9c1f251ef17eae5f898c10133d49421d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
