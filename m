Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF902DF1C2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 22:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgLSVH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 16:07:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgLSVH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 16:07:58 -0500
Subject: Re: [GIT PULL] close_range fix v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608412001;
        bh=VNT1nPw3djPNb7eyjVvRdIizdOFMLTXGquov+KPTBFc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EtCtUWLk5MJRBAlUP8n7+c2HWldJCycbC+4OKWnWUoFroL1nIdXCPQN9k3HYzsQ3X
         rPQ+9ZaRXXjgvdJ4500pF3O0TuX5I3sIOcZnxeV0rK+ObT3tNJ3B8TpV8kgbzBtsJl
         O8+S16pSKQ71gFIfv2d4Tw/LiDiC6kbbCN1wSGDqZbm0yuejeRmXLPPE56pBFKBtL/
         6LDMui5bYayBJ0zpoOVHfzWipNN9IZOiBaixA2g9VQzUgyoT97m9TKwffzImBzB1rI
         8odpaqb7DSw5oVGUAJ2LWRiJuV0kxG+pRYdEVpzJAH78fxikHYqWYKcXenIuXpkIIp
         5ZU6otiSCodsw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201219155821.891607-1-christian.brauner@ubuntu.com>
References: <20201219155821.891607-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201219155821.891607-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/close-range-cloexec-unshare-v5.11
X-PR-Tracked-Commit-Id: 6abc20f8f879d891930f37186b19c9dc3ecc34dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 467f8165a2b0e6accf3d0dd9c8089b1dbde29f7f
Message-Id: <160841200179.20285.7535392095294540087.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Dec 2020 21:06:41 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Dec 2020 16:58:21 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/close-range-cloexec-unshare-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/467f8165a2b0e6accf3d0dd9c8089b1dbde29f7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
