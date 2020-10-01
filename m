Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBF7280879
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733079AbgJAU2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgJAU2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:28:15 -0400
Subject: Re: [GIT PULL] arm64 fix for 5.9-rc8/final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601584095;
        bh=BVqRvkbxIR9gU/ImNNb5oV/XpDIS+9otuWIgTrp0toI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aMIUg/pIzIb9z6d4vWyuqjPijTLOFMXUky456ZqBUkP144YF9FeO+cOaw6kPLYuGd
         dAh53hHLEpnkdIP7Wkcml8vcacumpzwJzS2VqslS9o/Aw+ypg0AL2h+Fkk9fPaGazR
         hBuSY0aEshUpbkf4F11M0MnCKnYAb+7VOCsCkUr8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201001173505.GA6432@gaia>
References: <20201001173505.GA6432@gaia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201001173505.GA6432@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: a509a66a9d0d4f4e304d58fad38c078d0336c445
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eed2ef4403de3d8937ccb624e15d3c5004e7dda5
Message-Id: <160158409536.27596.13571088370701238758.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Oct 2020 20:28:15 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 1 Oct 2020 18:35:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eed2ef4403de3d8937ccb624e15d3c5004e7dda5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
