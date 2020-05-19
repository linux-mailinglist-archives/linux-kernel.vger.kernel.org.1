Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8ADF1DA029
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 21:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgESTAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 15:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbgESTAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:00:05 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.7-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589914805;
        bh=xTku3DLD2Cqyb9orc9z8JFt9Anf0F4+etz1e19Pe1vQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o+USgD5SorsTOP4ol0Aoqz27Rks/wIt/Q9/I7lVAOnbxV87pfOitLQibhiIpRYlJg
         2f9jtgvAJvjNKN81vYd3JLaY6V7SHxL081e0+hGGy6EFWMDxEtQLsYpXbosGpAVGgF
         kJlTz9ExqDrjBBtn9qiqeFnD+xC9C0yNga7ferDE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200519154039.GA27645@8bytes.org>
References: <20200519154039.GA27645@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200519154039.GA27645@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.7-rc6
X-PR-Tracked-Commit-Id: bd421264ed307dd296eab036851221b225071a32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2b00cbda9f92820ddbe2ae8f97628dae84ccc37
Message-Id: <158991480518.4218.9012887006460437027.pr-tracker-bot@kernel.org>
Date:   Tue, 19 May 2020 19:00:05 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 19 May 2020 17:40:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2b00cbda9f92820ddbe2ae8f97628dae84ccc37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
