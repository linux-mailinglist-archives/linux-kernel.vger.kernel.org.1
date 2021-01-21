Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC342FF517
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbhAUTtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:49:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbhAUTtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:49:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4699923A3A;
        Thu, 21 Jan 2021 19:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611258518;
        bh=rgPatf50yNhkU47T6WoASl5vZDdWR0pVspe0rorXwtk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Rpn96l8koGLwMNbdJTroS0+MvqDSFW7f5sdNuUEnD5IYDxaang1z/prJlCr5jU3+l
         2Ctna0r/VStyq5QmIwj4vqW8XlkZPsFPMC7/k2s9hi5EcSNVGqRTMi00rxaIBIKkz/
         Tucl6L2389FMWAMqwdz/nhG2ZOkrPKMBM1j12qae5I6FP7f1WLZLAzA+t0ZaOcbTiW
         ZcaWmZdP/GCfKzF3S4jQD+TgIpDZYPQ32u0OahcMc05dYqh7ofoi9mos0shA2ESoDq
         S45Z0+7Wgpf9We9amkAu8rEkF8fvUF5ApvRDqO2qzY9z8km7qk8/HL4SdQqeBnrPkq
         C/l9R5EDlGGfw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 4119660584;
        Thu, 21 Jan 2021 19:48:38 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hmtx29uaa.wl-tiwai@suse.de>
References: <s5hmtx29uaa.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hmtx29uaa.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.11-rc5
X-PR-Tracked-Commit-Id: 506c203cc3de6e26666b8476d287dee81595d6dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 120fbdb84f339ca3c358e4ac3fb1ffe663669d28
Message-Id: <161125851825.32181.10058256520954906727.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Jan 2021 19:48:38 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Jan 2021 16:36:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/120fbdb84f339ca3c358e4ac3fb1ffe663669d28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
