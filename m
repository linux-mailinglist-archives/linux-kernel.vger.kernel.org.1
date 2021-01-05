Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9173A2EB513
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 22:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbhAEVyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 16:54:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727414AbhAEVyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 16:54:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B762022D75;
        Tue,  5 Jan 2021 21:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609883637;
        bh=4YncPnDYm0OeA7aSTmNQ1xs8ty3RL7Ko3Y3Cy+VRjfg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Tb/96Uh7AfDy/gSDn9bm1jkmDQRQHTReXy+VGT6tQr+PFWzAG8zYsFplsx9m0h59o
         UCJAHNC+lD2ZOU6240Ki359afwSIwY3raeuZdTMUSHeWJyIIVuweDJ8iBTRMHH5L/h
         iD5hO7AWOgFkUJaP1PxhDRLorlBxvRvqGSaDACreGQ+01OOaTFdijqsMMjC0A5xzne
         A5gHlksBcq7gxkHIohBLaoPMIbyvU1XN0CS6itY2csl8LB8kIrxDvb3SazwB597qVI
         4P6I6icXAR+SIz7s0Gcm/n8w/bfPcqblHNxDvxKu3wBNS28dgmlmUm6s2dKLDJ8hYc
         tw9j8HrkqKjzg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id AFE776012A;
        Tue,  5 Jan 2021 21:53:57 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.11-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hturv63jv.wl-tiwai@suse.de>
References: <s5hturv63jv.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hturv63jv.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.11-rc3
X-PR-Tracked-Commit-Id: 4bfd6247fa9164c8e193a55ef9c0ea3ee22f82d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d011777cdbe7ae38a854a0cbeb6bdfbf724cce0
Message-Id: <160988363771.4244.16616749279927556.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Jan 2021 21:53:57 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 05 Jan 2021 12:12:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d011777cdbe7ae38a854a0cbeb6bdfbf724cce0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
