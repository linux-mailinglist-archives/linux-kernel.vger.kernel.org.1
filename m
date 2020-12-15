Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9D12DA675
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 03:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgLOCxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 21:53:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgLOCsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 21:48:31 -0500
Subject: Re: [GIT pull] timers/core for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608000471;
        bh=32Fwtbwq/I6Hq/6gMPpKFYr41uXSEcpKKU9W6eRlGPc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Xe6s3cNFIWl1PczgY5cvXx51Jnf8Arqct2wDa82I5I84S0j8N22ViHAMfkmmk/PPI
         vsn86FZincm+x3REFNRQtPKRSw1XU9CnFso/eL1h+nWCX8LVZ26kd9nhMkxZb5vGv1
         VZsykqZk7DRZnpZEOoY4uZPhM1MxW/nbP0r9Cx0glSvSrfkh3Eo7RKySLwhi9ocl20
         A3rWVRQd/yRJ6ImL5ZOTZ9MRz0Gg0LkNdrI+boHAUDN6Yt+BXt2eG+WHnfKXqYqboT
         iYIPAVgwjgmSYTBfcOwBuIBP6esJ9JQRWuw7FKaRTiMhzfzpzzAMV19PwnfphIKVl7
         FZ6VNUOiYoCKQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160797733911.10793.4629796194957263398.tglx@nanos>
References: <160797732939.10793.9152151866806316627.tglx@nanos> <160797733911.10793.4629796194957263398.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160797733911.10793.4629796194957263398.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2020-12-14
X-PR-Tracked-Commit-Id: 3cabca87b329cbcbdf295be0094adbd72c7b1f67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 533369b145d8d1bc44b8ed7f0dd0ecffb16384cc
Message-Id: <160800047121.6499.10981520694427161113.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 02:47:51 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 20:22:19 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2020-12-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/533369b145d8d1bc44b8ed7f0dd0ecffb16384cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
