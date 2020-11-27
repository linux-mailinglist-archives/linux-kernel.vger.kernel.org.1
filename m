Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D34E2C6E20
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 02:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgK1BVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 20:21:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729486AbgK0UBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 15:01:24 -0500
Subject: Re: [GIT PULL] arm64 fixes for -rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606504791;
        bh=Iv0up2+HdJ2r1kJY0o+bDBFzGbDTbeBbB+T+Oz1q/zg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FCHCPmD9pBS054y6T4OHQ8s2Sy3CA/Oo70pXvkIcwurLdFTFLkuxJpJ4cxrP8wZrv
         AUX3dSiHvgdfFCUjboiUHrktPkPRIutUZDHrUS1v2upolTlyETWOn98Q+EZtUAvlDt
         GmgD3Z9/G9Lycs8SBrBYqTaDGOX86S2xNgHXC/d0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201127114027.GA20418@willie-the-truck>
References: <20201127114027.GA20418@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201127114027.GA20418@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: ff1712f953e27f0b0718762ec17d0adb15c9fd0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4e9458073ae7ab0e7c28e7380a26ad1fccf0296
Message-Id: <160650479115.7570.14782305885681965510.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Nov 2020 19:19:51 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Nov 2020 11:40:27 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4e9458073ae7ab0e7c28e7380a26ad1fccf0296

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
