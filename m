Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F84B2BB418
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbgKTSkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:40:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731548AbgKTSkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:40:11 -0500
Subject: Re: [GIT PULL] sound fixes for 5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897611;
        bh=NUJe2ajfYgjuEJtDOcyIipJzwAHOaEPDJ7OZHZTAudg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Arom+XT/LGB3IN8mP5GQ29O0Eo8Tvy0iHRbpJg3GwNJvyu7DS1Yy1qIahfRtDmB/Q
         jxamsxwdJUiE9f+d9/7VfRTqjJuVsC+QD85SgWg81q2U0iVuTLyY/oXx8J5atXq9Hm
         mqML9xwhNjPzHM5Rx9HCWThkCrQh2apiIjz4iYv0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hwnygh1bc.wl-tiwai@suse.de>
References: <s5hwnygh1bc.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hwnygh1bc.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.10-rc5
X-PR-Tracked-Commit-Id: aecd1fbe7784e75226682afe7a9c3a34af35aa3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e65b30951e50708cb306eb75231329a3a3029a7d
Message-Id: <160589761099.4306.9341312018145386829.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Nov 2020 18:40:10 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Nov 2020 09:36:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e65b30951e50708cb306eb75231329a3a3029a7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
