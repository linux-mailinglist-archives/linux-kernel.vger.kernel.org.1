Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3324214F15
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 21:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgGETzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 15:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbgGETzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 15:55:09 -0400
Subject: Re: [GIT pull] x86/urgent for v5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593978908;
        bh=aiBWfMzkl37lCkWbe7TZ1Aqsn5YpyZyaHsCKVcjpFo8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PvoQ92BgWQH4XcuhI15qR8Wm5KzglgXSkRo4NiJJoQGXpuFt0padlF8WyNqEJmY7R
         pyTPEwvUEPG9hn1qC43ZIHR9R2amd/QbGlMataaGezV+5bRCeoyhbBB9Dv09eXC3fG
         KN/82xo8o8AgkyblHUwtN2fsivlXG5iEMTjRX3J0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159396401656.28963.9621378879403780463.tglx@nanos.tec.linutronix.de>
References: <159396401414.28963.18435590961866091585.tglx@nanos.tec.linutronix.de>
 <159396401656.28963.9621378879403780463.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159396401656.28963.9621378879403780463.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-2020-07-05
X-PR-Tracked-Commit-Id: cc801833a171163edb6385425349ba8903bd1b20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72674d480076067d627e708c0a062dd900438bd7
Message-Id: <159397890864.7489.753240432174147350.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jul 2020 19:55:08 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 05 Jul 2020 15:46:56 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-07-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72674d480076067d627e708c0a062dd900438bd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
