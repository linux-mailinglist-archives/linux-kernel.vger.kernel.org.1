Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3172C6E1A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 02:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbgK1Agp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 19:36:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:38386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729459AbgK0UBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 15:01:24 -0500
Subject: Re: [GIT PULL] IOMMU fixes for -rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606504791;
        bh=Nr5BvFLHb4Qmc/0zhtcVQYgSAZ5EMHTvFIVuupVSDOE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HEaDHW6KCt8mtWULbL00GpCaTcMHJKYRJxHFcqbSaxVJjbQPOr0cUA5gi/MlRTNxX
         myoQiWzS0U2mFTvesM7YGMS3+W829yG9csNwhqxiiP1/CFZdYo4DOa8FPt4ToaPUho
         4yrMOAMdnk3qsIDsnygx8ygN0SsaRw6CKlVLiQsU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201127114529.GB20418@willie-the-truck>
References: <20201127114529.GB20418@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201127114529.GB20418@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes
X-PR-Tracked-Commit-Id: d76b42e92780c3587c1a998a3a943b501c137553
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6adf33a5e42feada39d52eebd389d2019202e993
Message-Id: <160650479150.7570.9422474572706414701.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Nov 2020 19:19:51 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, joro@8bytes.org, tglx@linutronix.de,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Nov 2020 11:45:29 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6adf33a5e42feada39d52eebd389d2019202e993

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
