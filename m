Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1FC2A9EEC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgKFVNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:13:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbgKFVNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:13:25 -0500
Subject: Re: [GIT PULL] sound fixes for 5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604697204;
        bh=98R1CZbPzaKml+rhWRfEGCE5ZSR7G4CWCBo5Rns3nkI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zM1GLHSK8zHbMDI5nQadPgPj9j7r8LoQow1LycFb/ei+e/eDz1rX71soEd/yWntMv
         mg69u8O8o+Dg+hczQxNH1EZst8+gI0SEknHUv0ZyM27sQupbIT+nW52MyjXxvgreQO
         reSMXSaHjuk2ywj2kEzW8pBT/njrdzMkwOTXI+gs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hd00qrj4t.wl-tiwai@suse.de>
References: <s5hd00qrj4t.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hd00qrj4t.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.10-rc3
X-PR-Tracked-Commit-Id: a6c96672a64f4f0e1bac9f37b5bb57d8ab551b4b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb72bbe8f6c70e67c85d773e5c9b04c7fe36a0ab
Message-Id: <160469720485.14190.650258184498798587.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Nov 2020 21:13:24 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 06 Nov 2020 09:20:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb72bbe8f6c70e67c85d773e5c9b04c7fe36a0ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
