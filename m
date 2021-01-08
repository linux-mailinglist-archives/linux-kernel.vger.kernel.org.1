Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B639C2EFBDB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 00:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbhAHXto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 18:49:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbhAHXtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 18:49:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1A23023A9D;
        Fri,  8 Jan 2021 23:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610149742;
        bh=kVuMIv3ezT4SphLrIQOHZyCrYXc4poJVk7uyKGKQ/c8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j94WOsYdYQSTI6fr9IhsyeGlaIiIRgYp2CFvpMJO34BjHRlzPqiGJPJ2Lg/zJ0bxl
         q9As4op4Pv+IgA+IJkxP18a78dDorPMkj6mCPJ56FaRCHMUhr2xjWiH4KCzwV+FfFJ
         0RKHdjN8kCkNoisk0M3oEQtQRgTiDZtWQzKEFWVQwgjDaOra7ahtufnxgiwG1iqVjB
         +4M2gP3S605sSqcuQanNntwq4KQfMfcTWMkL4fD9Appv+6cxHdrHWsob6SOIyPsYer
         hAkt7tZOjDbV25gedJIgPawr35Nzq2VGai+s7PJOIPHw2+GvB5u9Xmv607M0LgBZWA
         yzehjvju9+IYg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 116D160157;
        Fri,  8 Jan 2021 23:49:02 +0000 (UTC)
Subject: Re: [GIT PULL] IOMMU fixes for -rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210108143951.GA4867@willie-the-truck>
References: <20210108143951.GA4867@willie-the-truck>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20210108143951.GA4867@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes
X-PR-Tracked-Commit-Id: 7c29ada5e70083805bc3a68daa23441df421fbee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e2a590acbed38a6908a5c4df7754dcb65f6fd37
Message-Id: <161014974206.3246.14661746099090491156.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Jan 2021 23:49:02 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Jan 2021 14:39:51 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e2a590acbed38a6908a5c4df7754dcb65f6fd37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
