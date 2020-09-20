Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAB927186B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 00:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgITWkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 18:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgITWkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 18:40:20 -0400
Subject: Re: [GIT PULL] x86/urgent for v5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600641620;
        bh=c/NJhRPwB6Gj94RXq1wDb+As1go0VZ61gDpm0+eoMY8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pwpnXO7pdPfIkRxqV4aTufIMayQGwGv6glIED5tNY6kBZRrf1Sk147+0h0eToAr+l
         UgmPMQw51l7m0krGpwxKERtDwmaW/gNBQU7WPra5exAEPIaaCu8SYgpaUruqBvT3vc
         ANXwi/OFi/bDxfncDcupnRblYeA8q7oEzvymhZxA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200920192315.GC13044@zn.tnic>
References: <20200920192315.GC13044@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200920192315.GC13044@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.9_rc6
X-PR-Tracked-Commit-Id: 6f9885a36c006d798319661fa849f9c2922223b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 217eee7231e4b70995bfc24d279c61f6fefbf5d6
Message-Id: <160064162042.32524.15310583997962003597.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Sep 2020 22:40:20 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Sep 2020 21:23:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.9_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/217eee7231e4b70995bfc24d279c61f6fefbf5d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
