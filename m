Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47A329789E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 23:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751802AbgJWVBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 17:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463673AbgJWVBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 17:01:22 -0400
Subject: Re: [GIT PULL] sound fixes for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603486881;
        bh=dKYhhy1R+O3KrVKtj+V4cW2TCszSaJEA9ziZb0SgB18=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LftRTQufFHvqjfOpdyiK4CGQqPwnZV9QOtmS0wtXj8JCG5sxC9dgmicGVpxlBVczd
         6EsPFmMTdwnq73rZYZzaeDelfJBsXGevdWiMoVKWVMrEX7bxttw/MmCBbFSTA9QCz3
         GdxekV9pdSruyRfO5qdGCVee0d7eOyeM6HisaAmc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h4kml9wwy.wl-tiwai@suse.de>
References: <s5h4kml9wwy.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h4kml9wwy.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.10-rc1
X-PR-Tracked-Commit-Id: 033e4040d453f1f7111e5957a54f3019eb089cc6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40a03b750bb3ded71a0f21a0b7dfbf3b24068dcb
Message-Id: <160348688190.3049.11249590154516847749.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Oct 2020 21:01:21 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Oct 2020 10:19:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40a03b750bb3ded71a0f21a0b7dfbf3b24068dcb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
