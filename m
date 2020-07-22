Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2520A229ED9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 20:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbgGVSAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 14:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgGVSAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:00:06 -0400
Subject: Re: [GIT PULL] sound fixes for 5.8-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595440805;
        bh=eEVM5cw/0d4t8HkdV+ig1EQ5jYCcXmGzTEHTEzpzUKM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EGoC0dLy3RklK2mkjsGrni+75HTC8D8kR2aAXPwReZSsjLnBI/H+9lj0iy2T+N/R+
         KyVEv6ZDqq6bncoFRNBaPlCFc03tuZPm08q1nMrafib/65R+j5bWKXlVPaHgdQq71C
         J2j8NrKBrfbUZMPFbJ+pHFK9SKuGtj77uFCLFd0w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h4kq1yygw.wl-tiwai@suse.de>
References: <s5h4kq1yygw.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h4kq1yygw.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.8-rc7
X-PR-Tracked-Commit-Id: 568e4e82128aac2c62c2c359ebebb6007fd794f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c26c87b05323a7ccdc632820b85253e0bf47fd9
Message-Id: <159544080565.19516.1126362727457093790.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Jul 2020 18:00:05 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 Jul 2020 12:05:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c26c87b05323a7ccdc632820b85253e0bf47fd9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
