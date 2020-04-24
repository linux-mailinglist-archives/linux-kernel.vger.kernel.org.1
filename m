Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB241B7DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 20:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgDXSk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 14:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgDXSkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:40:20 -0400
Subject: Re: [GIT PULL] sound fixes for 5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587753620;
        bh=21TRuDQSu3zgtDqTuwaueaFdFFtj0bOoy62PnWy78pE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=b2Ol9U8OBtVzfjsds8CRe7YhM6NyihrPwqAlT0g0gU4kkXfbSYpfbhbZZxde9jE16
         o+p2GRQw5PT6cpeN9plKjGUHUgu3ymLXUBK13d2Fjzwr128G5uFm+7jjy+b+1q1c1S
         nuSmJG2K98x8pb/nDgp8V0Sl/rwGXfadVMdbBlC8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hwo65s2ld.wl-tiwai@suse.de>
References: <s5hwo65s2ld.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hwo65s2ld.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.7-rc3
X-PR-Tracked-Commit-Id: 8d6762af302d69f76fa788a277a56a9d9cd275d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4ecf26ea2ed744715753ae11e6928fbda9b65ad
Message-Id: <158775362015.26557.4784338963020534501.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Apr 2020 18:40:20 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Apr 2020 10:35:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4ecf26ea2ed744715753ae11e6928fbda9b65ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
