Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC0A27A2C9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgI0TeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgI0TeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:34:01 -0400
Subject: Re: [GIT pull] x86/urgent for for
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601235241;
        bh=AwIjSaBSkj4hL6OXysRZgVjNF3+COsRicWdKydwxBUw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qa335TRsDudDRVTGDnxPUSTQ81gSmPBet1winwQsNciYaqabudr9sQFOpvBGuaKEI
         mappGd8mosTKkw7lcse3f5oLvkcoSNll6yaPDn5iALJdFsUwmZNL3fAI9L4NWxcf27
         qf1U7+A3usY5p43d+KWA+XFrCvng+l4qCglb5yAk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160121921315.23623.17643308720426244416.tglx@nanos>
References: <160121921194.23623.5568205948074131939.tglx@nanos> <160121921315.23623.17643308720426244416.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160121921315.23623.17643308720426244416.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-09-27
X-PR-Tracked-Commit-Id: 86a82ae0b5095ea24c55898a3f025791e7958b21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8818559ca6251adbcd9408dc1ebe3b832f3e1d7
Message-Id: <160123524135.14460.23254243613571110.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Sep 2020 19:34:01 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Sep 2020 15:06:53 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-09-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8818559ca6251adbcd9408dc1ebe3b832f3e1d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
