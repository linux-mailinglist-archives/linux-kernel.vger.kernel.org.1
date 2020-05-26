Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1A319CDE1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 02:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390440AbgDCAkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 20:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390427AbgDCAkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 20:40:18 -0400
Subject: Re: [GIT PULL] sound updates for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585874418;
        bh=32vyQkWbtmdLnzwog0XtAeKbHcfoZMUaKnuIVpw96VM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UPSLLeR34DCQEv9Nj7S3hv1lhIvAWpL2MReC+IsLyb9iyWp07eZgblzOyplOsv+5Q
         yv9LSpM3BZwz6kpTGkH+KPyRu3BvbHr1OFeU62w35LXQb0QL3uVD9Bhglvy1InJxpx
         DE1mld+fCI8PIkQfcoqd2eCh0iYczje6M+mSOMu8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5htv22uso8.wl-tiwai@suse.de>
References: <s5htv22uso8.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5htv22uso8.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.7-rc1
X-PR-Tracked-Commit-Id: 5c6cd7021a05a02fcf37f360592d7c18d4d807fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 848960e576dafc8ed54c691b2f70b92e1fdea9ba
Message-Id: <158587441796.31624.16943011436861424361.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 00:40:17 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 02 Apr 2020 11:45:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/848960e576dafc8ed54c691b2f70b92e1fdea9ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
