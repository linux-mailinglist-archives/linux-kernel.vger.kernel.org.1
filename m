Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB272EE6C8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 21:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbhAGUYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 15:24:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbhAGUYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 15:24:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 11DC323435;
        Thu,  7 Jan 2021 20:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610051041;
        bh=k39S9iplC0PEs6vOo2DHLdjGB+HsT3Df5GfFOdRxYbQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M3v0sOmkATsMuIQWjFpOiCu6G86HiMo+uAm0N1JGJVRN3Mbm/jgw9vu//hWE7hIom
         gKhZ4lxvBR4luUwjC+Iwt2SA0qZioJFmJf79MRHMu/IBjzSUMBuUZdiAsx455AJsFf
         PhBtx1S84JWrIYvFdDJrrGKF6z7eRs161rTs7o41nXFUmlLURfJu3527GOsf3HzSSY
         0/6X4juaHGBQjcB5P/sYJ9bN7kc3ToNfi/hjiORdnygbeCc+OrayKCgdIX9dommbXC
         xxwH+Xk0CwpO1gt26uZhHSquttit1KGjaJ6KPjUGBvgItSZHoeJ6UJCUqR4hb9XdtJ
         SdYFRtDtN6DGg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 0C07760508;
        Thu,  7 Jan 2021 20:24:01 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v5.11-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210107171015.38E792311E@mail.kernel.org>
References: <20210107171015.38E792311E@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210107171015.38E792311E@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.11-rc2
X-PR-Tracked-Commit-Id: f6bcb4c7f366905b66ce8ffca7190118244bb642
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc37784dc71bc9dd3a00a2f01906b3966e4034f2
Message-Id: <161005104104.19187.9428475469000513153.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Jan 2021 20:24:01 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 07 Jan 2021 17:09:30 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.11-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc37784dc71bc9dd3a00a2f01906b3966e4034f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
