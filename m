Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF5A28F874
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 20:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgJOSZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 14:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbgJOSZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 14:25:27 -0400
Subject: Re: [GIT PULL] sound updates for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602786326;
        bh=e79ttRmM7cRyG14E4hrjPakxhfdhCFT6cQ4ti5ZiFNU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cs3BfnLvW6LiT3CdSBC9I82soHEspvYTwM5ziIjsf+y4is2yYKTnngVrRBIKhlc/J
         ODOKa7+3XXL17qqbfMLAB59Tobn6IhcrJJ3I2Q6eA7/gHjSYdEcBVeK9X3z16UtIgV
         x5aFqO1qbOUJJN55z5g92+ow3+XD3dQp5hZsbszM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hblh3ittn.wl-tiwai@suse.de>
References: <s5hblh3ittn.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hblh3ittn.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.10-rc1
X-PR-Tracked-Commit-Id: ce1558c285f9ad04c03b46833a028230771cc0a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c48b75b7271db23c1b2d1204d6e8496d91f27711
Message-Id: <160278632657.10549.12653177199492554903.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Oct 2020 18:25:26 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Oct 2020 13:59:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c48b75b7271db23c1b2d1204d6e8496d91f27711

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
