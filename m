Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FFE2E28F3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 23:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgLXWAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 17:00:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbgLXWAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 17:00:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id BF1DB22D57;
        Thu, 24 Dec 2020 21:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608847178;
        bh=ir1fWJzx4MuESEkR6YzscwrlaK6XV2Re6s6cTHIvnV8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HsKMeELfD9RFkl08kkQXQ0Ojy8uPf37p4r6HmRFWbKOdYzNobbnExscBdrNC/bYCY
         JSmzj86zYV462uYGxbp3dMd9IyHrf8lJjsti6Sd5LxpBO9sBAT85AVwrtm7FJbcnM1
         1/a+GVdyvC20PFnelwY9i5t6Y4bC/yHtSlsZ/4MXzz5T+2X46AVh6X6WqgyfLcJDlv
         34Sd4SC4cGaaod6gGReAWLGf18Ax6kbJ2ph2QY4FwbAYQxGRisKpc780gT2jyc3uwb
         pybZ4v/0VBXGM3RYRmbUoeVyaDa0Rdb/X2cAc5b9d+xkrxf3t6N3dymvw+36tpLkkb
         FohE435qZertA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id BA98860159;
        Thu, 24 Dec 2020 21:59:38 +0000 (UTC)
Subject: Re: [GIT pull] efi/core for v5.11-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160797733182.10793.8402797805442982544.tglx@nanos>
References: <160797732939.10793.9152151866806316627.tglx@nanos> <160797733182.10793.8402797805442982544.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160797733182.10793.8402797805442982544.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-2020-12-14
X-PR-Tracked-Commit-Id: 54649911f31b6e7c2a79a1426ca98259139e4c35
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0a6aa30504cb8179d07609fb6386705e8f00663
Message-Id: <160884717875.31605.13022894634840344781.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Dec 2020 21:59:38 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 20:22:11 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-2020-12-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0a6aa30504cb8179d07609fb6386705e8f00663

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
