Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76D62A9EF1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgKFVNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:13:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbgKFVNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:13:25 -0500
Subject: Re: [GIT PULL] arm64 fixes for -rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604697205;
        bh=jgaFfYq43om07pQjtDb95Dj0rUxwyfl+Kdvg30u2Es4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ud5y0hk+T33JTeMydp3iOKI9IApRXtAECX0cCyyEgG3sLwhovPgdQJCUXa5Ob7H43
         tcD59JuSgHHpyV+mITLNjFkxU2vQDiMIaLK06Za19LA8pktmrZSdN0HXInt+I0IHu0
         /o+bmfaV81tPDI2a/hNGWmgyGw86KTGdgl08aGp8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201106132035.GA10755@willie-the-truck>
References: <20201106132035.GA10755@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201106132035.GA10755@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 108aa503657ee2fe8aa071dc620d96372c252ecd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30f3f68e27d14a237acc339975e18670e58927ca
Message-Id: <160469720504.14190.6975734530676551749.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Nov 2020 21:13:25 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Nov 2020 13:20:35 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30f3f68e27d14a237acc339975e18670e58927ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
