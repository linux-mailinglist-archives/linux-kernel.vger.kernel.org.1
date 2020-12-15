Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816DA2DB689
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 23:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgLOWXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 17:23:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730236AbgLOWW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:22:59 -0500
Subject: Re: [GIT PULL] sound updates for 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608070939;
        bh=m9nt2keuXOn5cxkw/vorbMWGjpR+v+eepAzeOOGuo+M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=V2xgbbEkrHKw0IrHcdLKAq2DXhMN8VrthWoLSxT0AlufyT+6beRCLjWJrgQ/AUQKL
         1Z5ATDMbO1nsnzsWIw9OrBuQ+LWu6PWQ67qLf6psGNuIC1APzja+V1cGQTdD3xSmbD
         H9FuXv2/L5+aLpMZ39vMkqlJB5pqZjzzBmIQV56QtqkMkbkFh7ORnNRu9ihppB3Zql
         mWy1Qv6fTSHr3drp+FWg0hmMftDMoaGH1nThhiD7IpTlexbcQBRzCzcgCgG3HQ2d6n
         uwyTBHdIFmImJ2cXQTEip+uKBqNNNZdR6ZGHUFOtTMOU/0j0136znTdZB5cDpXUZSV
         G1SJI5hNTiRfA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hy2hzpa04.wl-tiwai@suse.de>
References: <s5hy2hzpa04.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hy2hzpa04.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.11-rc1
X-PR-Tracked-Commit-Id: 598100be3053fef628adf3ad6ee4f828ad308f64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c367caf1a38b6f0a1aababafd88b00fefa625f9e
Message-Id: <160807093955.3012.3213188578569362620.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 22:22:19 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 12:46:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c367caf1a38b6f0a1aababafd88b00fefa625f9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
