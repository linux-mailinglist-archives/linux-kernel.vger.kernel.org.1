Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB73B1EEA3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 20:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbgFDSZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 14:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730825AbgFDSZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:25:14 -0400
Subject: Re: [GIT PULL] sound updates for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591295114;
        bh=QBMVOI8+BZddcHrs2ltBBnI4efywplVp1fXwRmSqiBk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QoMht1WtsIYi1pPKanfrC4ljsSVSm5tevHQEKuNGHFCgisD8034eVyr7GS52TxVHM
         GLphvJXtQUTGfoUYw5wpHdQ9FmQ+B3s+PeFBmtFbF015D6hZnROASMdzWsWkpuOH4d
         +5Q3rc46ZUxMj4PcBT9yGd5zHXwTOaRMB39pHKa8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h367bawei.wl-tiwai@suse.de>
References: <s5h367bawei.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h367bawei.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.8-rc1
X-PR-Tracked-Commit-Id: d9b8fbf15d05350b36081eddafcf7b15aa1add50
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 631d6914085b4eea8d68a84f800974a6ad8fb5c0
Message-Id: <159129511446.18772.5371396980617513655.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 18:25:14 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 04 Jun 2020 13:43:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/631d6914085b4eea8d68a84f800974a6ad8fb5c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
