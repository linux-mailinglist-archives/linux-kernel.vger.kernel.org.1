Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC331F6E45
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 21:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgFKTue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 15:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgFKTu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:50:27 -0400
Subject: Re: [GIT PULL] sound fixes for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591905026;
        bh=picItZI32OOXCwXaOp7Q18ShS6dEIiVlz/9TMLqVgxc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Xf12dUpCgYQXjUHv9aLHO+wpUlgfD4sVBBOKnEttFP1SMF61PvX7A4wCRaghNsR8J
         rrPSF9vwHa12uCQM1BPuB6C/JZ5rdoJ4w4emBgnyO6l1IY3yNM3NSLXIisjC/J3Lj1
         pnmHAEfl5m7DuJsI3g+nT1weT+Ts32i7Mir5c0Z0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5himfxet1c.wl-tiwai@suse.de>
References: <s5himfxet1c.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5himfxet1c.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-fix-5.8-rc1
X-PR-Tracked-Commit-Id: a4f55d927d33accd6eb535ce0db031e2df47714a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0154bd478897b277aeb7195bf9088e9ce05bbb0
Message-Id: <159190502693.20905.5929173901463188092.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 19:50:26 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jun 2020 13:33:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0154bd478897b277aeb7195bf9088e9ce05bbb0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
