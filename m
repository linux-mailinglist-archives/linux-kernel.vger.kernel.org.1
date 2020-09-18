Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCB9270491
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIRTEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgIRTE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:04:29 -0400
Subject: Re: [GIT PULL] sound fixes for 5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600455869;
        bh=lS/0LQNAT55R4OxBoIugEw458vTgaimIdEwoIPStgJs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=v4MPlWVqCw/gVqEExEJuH3MiNC+yIaEl6Rst5yl8MT8V0JT39dQOHHYoRxhsQxB0h
         pSiWQH+5W2Z/J1+zsbDFLjfROwEBhM14Hyp02jbNnPNUgrIKFLlUtmOeHJKdcAIrdi
         2zfmyLt2J5pWQmZ75ByCdr+WDlj1wv/yH7pOYYwQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h5z8bqa9z.wl-tiwai@suse.de>
References: <s5h5z8bqa9z.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h5z8bqa9z.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.9-rc6
X-PR-Tracked-Commit-Id: 8949b6660c3c7947a9b696c97eb85a32abe4a2d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 343b529a00d43d38f753d8221bd9fcd9bbc73d5f
Message-Id: <160045586935.18461.14671707738416812934.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Sep 2020 19:04:29 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Sep 2020 19:12:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/343b529a00d43d38f753d8221bd9fcd9bbc73d5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
