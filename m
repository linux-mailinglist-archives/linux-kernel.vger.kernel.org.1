Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D7E2BB42D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbgKTSlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:41:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730994AbgKTSkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:40:11 -0500
Subject: Re: [GIT PULL] MMC fixes for v5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897611;
        bh=02B3k6QjexeQA2cIKw9XCRvE4Hpb8lq480hhNevpsJw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c3zf11FzpcaBdGMpSkNrn0iD0f+cm8IQ0cleuzZpC0a68l1zrS6EucYYs5P7mwU/R
         t+lY2MA7cVysZF8+U6EibMBpt3p5BAgk5K2zILrrdGYxUVZ99dBeQxMZxVJSeSQkrY
         Cf+o0Sv8DF+NPTVMdPHNbmIvGNjZspwlF0fCpen8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201120105007.8184-1-ulf.hansson@linaro.org>
References: <20201120105007.8184-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201120105007.8184-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-rc4
X-PR-Tracked-Commit-Id: d06d60d52ec0b0eef702dd3e7b4699f0b589ad0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5de18678da02d893d2c1eb149583fca23c96584a
Message-Id: <160589761120.4306.20063113139135083.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Nov 2020 18:40:11 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Nov 2020 11:50:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5de18678da02d893d2c1eb149583fca23c96584a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
