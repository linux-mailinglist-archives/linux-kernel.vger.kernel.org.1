Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB8B301F06
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 22:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbhAXV42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 16:56:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbhAXV41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 16:56:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D241A222BB;
        Sun, 24 Jan 2021 21:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611525346;
        bh=U4Uo88QRVqikkKZmCBVV+LbP8bI5j8J9J0WP1Q++NRI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ls2qQN4hKoyOfPd+YSfbQSL0I8JUARIXjszyRkotgf+nICLMI0TK5apG1dA9kGMaI
         ByFavTfw91Tn5W2nnOTV0rD5PKiRKuHa61F7Dn1Mz41RMSnKGH3YYECkP/bN7r1LZY
         7Y6kaplMIk/FsNYH/04LE3RuRDZ1zxKfdZrb4SHo1Ita3V0xXr3rkpn5DSCh0y/zhI
         arh7SVCzZKJ12IKAZyPEeYHQrOj1ki0Agojg9y++UYmhfeeFhvdTTaCaRx/jIbvBRn
         H3GpSKO9z7GZNKamc42193iSamJJwDmBoEt0Aj43athihHwEh2r9xYdqhhbywTsp4X
         tNhci3StXNpFg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B97F4652E1;
        Sun, 24 Jan 2021 21:55:46 +0000 (UTC)
Subject: Re: Re: [GIT PULL] arch/sh updates for 5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210124203936.GU23432@brightrain.aerifal.cx>
References: <20210124203936.GU23432@brightrain.aerifal.cx>
X-PR-Tracked-List-Id: <linux-sh.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210124203936.GU23432@brightrain.aerifal.cx>
X-PR-Tracked-Remote: git://git.libc.org/linux-sh tags/sh-for-5.11
X-PR-Tracked-Commit-Id: b89bc060b53e7054e5c8ca11feea4bc884d83611
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 228a65d4544af5086bd167dcc5a0cb4fae2c42b4
Message-Id: <161152534667.9853.728051871636165433.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Jan 2021 21:55:46 +0000
To:     Rich Felker <dalias@libc.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Jan 2021 15:39:38 -0500:

> git://git.libc.org/linux-sh tags/sh-for-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/228a65d4544af5086bd167dcc5a0cb4fae2c42b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
