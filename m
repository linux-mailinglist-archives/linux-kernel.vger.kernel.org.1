Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CD325E30C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 22:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgIDUtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 16:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbgIDUth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:49:37 -0400
Subject: Re: [GIT PULL RESEND] thermal fixes for v5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599252576;
        bh=YDR9tvLTwPtrpLd+3WS2lPQNPP+z9SCw9muNTb3F1Hw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RlArBALqWvRYZLBhAQ0lESwvqc1T+oBwTJiuaOrASubn4sEJtaZ31P0hVHzC6UbjG
         yVs5pW94Diq5+wpl+fVA1WaP36rqx5NMd2vIIgtonH7rU2KoOX2FHWtpXvq3dMuy4m
         8se3L1BQO3+u1WSNW6kANDufCeCPV3LlPLCQzdwo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6b8dbaef-b288-4d44-1916-a10892e665bc@linaro.org>
References: <6b8dbaef-b288-4d44-1916-a10892e665bc@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6b8dbaef-b288-4d44-1916-a10892e665bc@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.9-rc4
X-PR-Tracked-Commit-Id: a5f785ce608cafc444cdf047d1791d5ad97943ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2fb547911ca54bc9ffa2709c55c9a7638ac50ae4
Message-Id: <159925257677.25529.3017888766072920886.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Sep 2020 20:49:36 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Veera Vegivada <vvegivad@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Sep 2020 13:11:41 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2fb547911ca54bc9ffa2709c55c9a7638ac50ae4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
