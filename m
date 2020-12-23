Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9829E2E22D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 00:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgLWXmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 18:42:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbgLWXmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 18:42:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9D01A224B1;
        Wed, 23 Dec 2020 23:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608766880;
        bh=iSPCUBipfR5Ed0KycDAZp3FJhncXpiVyfgX5DfYWbzw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ja7HzD0eCWU712u7zfRGrH88C4ueTWR2yh0VXS0QruWnV73Zy1sWXWuPcvp6iXuM5
         QORFO3Ll45xe00PN9PMuiXXXskogsir22nnD4qf2OqQ9DptU28OjRZkLbB/MHJszq+
         p9IexiCFSMYUkVk6OkYUNDyVK3mBkSYOlfy+GPayzgmok0BaXtVq5kTx84zMUMZ1Iw
         JSu4vmIzyZM+HooItOuO+A137oRequEAi7mGYiX3wb+bS5KOt4niW2DIHlnntOqbYL
         uzn5PTJO+RvWZPlZgGtt3EuFnSHBIbwvZg99/xBN6DvPQNuWWy1ok7qDMUmXXcO6At
         ybxp56ETC8Rhw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 9838B603F8;
        Wed, 23 Dec 2020 23:41:20 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.11-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hwnx8diuc.wl-tiwai@suse.de>
References: <s5hwnx8diuc.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hwnx8diuc.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.11-rc1
X-PR-Tracked-Commit-Id: 13be30f156fda725b168ac89fc91f78651575307
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58cf05f597b03a8212d9ecf2c79ee046d3ee8ad9
Message-Id: <160876688061.7832.3405701135911915691.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Dec 2020 23:41:20 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Dec 2020 09:31:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58cf05f597b03a8212d9ecf2c79ee046d3ee8ad9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
