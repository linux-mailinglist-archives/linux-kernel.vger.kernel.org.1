Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AE22D06E8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 20:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgLFTb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 14:31:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgLFTbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 14:31:25 -0500
Subject: Re: [GIT pull] x86/urgent for v5.10-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607283044;
        bh=0eJV7eGcBro3uuby5MkFDQ1OfWRhJPxbAabuKpbfj+M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pBWJ1dN4R7SvCsaPW4RtWsNbaT48voIIzCLehNwCwrGKZG1kNdT1wwKL6Uc7/Nyag
         j15l1Q7XVlNJsIOgMP9jwzcHs44Lbwnp2e8X+cFvtn/SWfFrJDajWEdHt7vdRzZoIu
         NW5bLIfIFhhIVgFA/KTyhSItgHV9j1touqcJmz9QtptC82M/Xg+aibmycecpMhh+J4
         BxSHlUKyD1b6zIZpqNOUoR0YL8aIXTvZlGpkMJAHcaDWeeqTI2m5+Kps2ePvt/yemq
         ScO+k8PUlNrxxkxfAS5BLjb3deabcpn0PFguhuvSH7RG8thSYw+YDWw/3gfj7NG0zc
         oc3Y7P1/Sx3Gw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160726030175.10836.15260456457411664701.tglx@nanos>
References: <160726029814.10836.11636935433736940390.tglx@nanos> <160726030175.10836.15260456457411664701.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160726030175.10836.15260456457411664701.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-12-06
X-PR-Tracked-Commit-Id: 84da009f06e60cf59d5e861f8e2101d2d3885517
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8100a58044f8f502a53d90af96d6030767df0fbd
Message-Id: <160728304474.10233.12190601839834450961.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Dec 2020 19:30:44 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 06 Dec 2020 13:11:41 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-12-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8100a58044f8f502a53d90af96d6030767df0fbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
