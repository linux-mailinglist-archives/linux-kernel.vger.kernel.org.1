Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCE6B1A4B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 22:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgDJUk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 16:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgDJUkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 16:40:25 -0400
Subject: Re: [GIT PULL] sound fixes for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586551225;
        bh=8yhGWbBlNuwLDJGgWdQH1Js7cmNmudrETKsU/1Ccf3A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jjIHXPv4W9TGGmPWNr3LOIEdkvJruSOzi8BoLcDZxnBZ6dOxGBUTPggwR0zL4esFl
         5zdK9dZ2YtewDXEbAXhFcGekutvVkYCOThXpKqNF+DZL07251RScc3aeiIvKqs8CnS
         Exsh4N40O6tAAR3tXanlu8HeTEdFsXgRSttOKNoA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hd08goieb.wl-tiwai@suse.de>
References: <s5hd08goieb.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hd08goieb.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-fix-5.7-rc1
X-PR-Tracked-Commit-Id: ddd5609fe8b682fbe81f71b27561f14d3611d856
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4aafdf688360bacd4b48c87e9a3d0c208baf31c4
Message-Id: <158655122587.24997.12603451192488007555.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Apr 2020 20:40:25 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 09 Apr 2020 16:14:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4aafdf688360bacd4b48c87e9a3d0c208baf31c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
