Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F19420A2EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 18:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406127AbgFYQaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 12:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403828AbgFYQaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:30:19 -0400
Subject: Re: [GIT PULL] sound fixes for 5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593102619;
        bh=iCMLWTBVBI7rIXto/eRI/o3cw8o/bskeEzLtBqAX8iE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MhohqDlCC1rRXojAfELhtzcJcceh/1ed9Fzj6Sl4aKiFzm1eJHmFoPCgAYo+WNdAS
         NJRiFBgrw+lKJJVYCIfWVbk5T2b3HcW87LwTmkf2H6+pJbVvZ2QWWOqDnzBpihZIyU
         LCRuVGIHizlr4vDYiNW4FtUk/SFbVjQC0/hQernA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hr1u3gyzr.wl-tiwai@suse.de>
References: <s5hr1u3gyzr.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hr1u3gyzr.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.8-rc3
X-PR-Tracked-Commit-Id: 220345e98f1cdc768eeb6e3364a0fa7ab9647fe7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4d3712b510534ef2ab5b15429aa94283c233a31
Message-Id: <159310261896.15384.12625144754835516265.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Jun 2020 16:30:18 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 Jun 2020 13:34:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4d3712b510534ef2ab5b15429aa94283c233a31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
