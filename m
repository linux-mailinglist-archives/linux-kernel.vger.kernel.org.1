Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F49B270490
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgIRTEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgIRTEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:04:30 -0400
Subject: Re: [GIT PULL] arch/sh important regression fixes 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600455869;
        bh=cKZKGy24nWDe5dq+vsOecV7B9iS44NqRpyX4EnfLKJ8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Jq06zuBR+3TCCGdUPEf5MLxD61wB9AnTlFuf5bTpu5PR2OweaiKPS9k9v/DQ05Erd
         8kMrSZ207jxkPideKbAFqOlftPbthu5G8uTrL+XRDBY/4VIc1imgsQcMPMALZ/gvus
         54E8Lrf7fCQ2Mx+dxQ+V/N8tM6Zbinw+UjIPRm9k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200918174528.GY3265@brightrain.aerifal.cx>
References: <20200918174528.GY3265@brightrain.aerifal.cx>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200918174528.GY3265@brightrain.aerifal.cx>
X-PR-Tracked-Remote: git://git.libc.org/linux-sh tags/sh-for-5.9-part2
X-PR-Tracked-Commit-Id: b0cfc315ff38c423a5ce9ce159bd5baa4135e688
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92ab97adeefccf375de7ebaad9d5b75d4125fe8b
Message-Id: <160045586956.18461.7838610619987360536.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Sep 2020 19:04:29 +0000
To:     Rich Felker <dalias@libc.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Sep 2020 13:45:35 -0400:

> git://git.libc.org/linux-sh tags/sh-for-5.9-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92ab97adeefccf375de7ebaad9d5b75d4125fe8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
