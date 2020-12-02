Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9171B2CC84B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbgLBUta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:49:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387492AbgLBUt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:49:27 -0500
Subject: Re: [GIT PULL] sound fixes for 5.10-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606942126;
        bh=4f5mQ9R3JPP9K49Vwwn2hOw/J+2NbTSt3J1u4qCIYeM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rgMcYyC/vH6kRzkSlCV0EbwzHynuYd2A1qujk8xG+OwjhaGGUft9U8t9HLgqVieYb
         58Hoca3O0l4jAofolKBv2vq8BUOUX7Ppnh2QQSEWkxae9WQDIhcRgLxOmMM2UH28/g
         mDmZddgrEKba3qHG+j3EAdBbm5cP+ZcWSpQBC2FK9ls6sHClPHUeVUzZyIMGdEiYjM
         HJ6e1qKl8yCQlMs713IJ24U2BfI9glxYzWSLuLPqEXw77T3+6+f1AeiMD8GLCZ6NPj
         bQTbomIBbugRxP9BzBQnjq5zsO8IIyhUFeST9vfS+KP34SaszmIUQnIAoD7aZbHIlx
         da1a+j0pg/XMQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5him9ka859.wl-tiwai@suse.de>
References: <s5him9ka859.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5him9ka859.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.10-rc7
X-PR-Tracked-Commit-Id: aeedad2504997be262c98f6e3228173225a8d868
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb95d60783f1ac85883c7ae33cafa85236b6179e
Message-Id: <160694212672.5087.8140282547876308415.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Dec 2020 20:48:46 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 02 Dec 2020 10:07:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.10-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb95d60783f1ac85883c7ae33cafa85236b6179e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
