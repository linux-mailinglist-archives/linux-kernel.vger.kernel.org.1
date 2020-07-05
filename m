Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379A4214E2E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 19:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgGERfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 13:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgGERfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 13:35:05 -0400
Subject: Re: [GIT PULL] arm64 fixes for -rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593970505;
        bh=uGtJm25Ba/CfmyQpWD74TYj/A+N5Xc4QaXEHZPCiAyo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TLgbEBhmDlVdtViSgqaUHkGv2c2sKCbv4wGYmOxHoz9JQUEsMUTjra3//p/o/SdPN
         teEcjrvX38CGMzLck0yiR3ZPinuSNYyx8v87noWkgojlBf1gBEwk1AmGYekjHda3UC
         oaj387uTQ9XpVKzGfWMCQ4vNTItXS5Zr1V4bAJlc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200704130505.GA21333@willie-the-truck>
References: <20200704130505.GA21333@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200704130505.GA21333@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 9b23d95c539ebc5d6d6b5d6f20d2d7922384e76e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec84c3f6ef710661c8d14e3f63e540b795dc0a51
Message-Id: <159397050498.12702.16374251588141270725.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jul 2020 17:35:04 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Jul 2020 14:05:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec84c3f6ef710661c8d14e3f63e540b795dc0a51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
