Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745FC2BB431
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbgKTSmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:42:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:58210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731537AbgKTSkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:40:07 -0500
Subject: Re: [GIT PULL] IOMMU fixes for -rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897606;
        bh=xRx6RqsdmIAKpMlYuagEJPIDByc9uZZlrGJ8/Qp5Ph4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aLZtlF3H/kTqSRDcGRfrm4KI16QYjBycpMtFNE2fEpmtw9KsRF2KxmER84m+u04JT
         a5tMrV6EXWpBPmC93ZqSdNET6yjrBqtgWQ1HbIUzE6sUS2qn2aKUZ9EgGjks06JVLW
         IyMSaS+NKXUA9xBi4eWwN+uZkI8D+Cj4KD8l8W9s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201120115034.GA6386@willie-the-truck>
References: <20201120115034.GA6386@willie-the-truck>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20201120115034.GA6386@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes
X-PR-Tracked-Commit-Id: 91c2c28d8de34815ea9bb4d16e9db7308ad33d3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc8299f9f3b9f3b0e1c8c9f719b5deb2a74ab314
Message-Id: <160589760669.4306.2459935976027998516.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Nov 2020 18:40:06 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        tglx@linutronix.de, Robin Murphy <robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Nov 2020 11:50:35 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc8299f9f3b9f3b0e1c8c9f719b5deb2a74ab314

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
