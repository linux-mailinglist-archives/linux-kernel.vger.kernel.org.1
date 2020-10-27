Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F7029CB77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 22:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505727AbgJ0Vrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 17:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503853AbgJ0Vra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 17:47:30 -0400
Subject: Re: [GIT pull] x86/urgent for 5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603835250;
        bh=4oxVRJwveiMRlVLOlg2yG6cx1kQCNqoYz9coGQcIFp0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HzPFyA8ObkwHRw2G+80MlxTvF6KySjGTxqnfpQBeQ+1TFGRKBNHjQbQbNOrr9iY+f
         lQ/XgO2mK+AY41cmXcYqz3913u6OZ5zi+GhdoI8Jsbz7sGjxM3z3lzd5+IcjG6eb3I
         CZ6p5+xme+Dj09GbVgvKaP5XGcksVn8pPs5fNVEI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160382969970.21153.12631210500316115410.tglx@nanos>
References: <160382969970.21153.12631210500316115410.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160382969970.21153.12631210500316115410.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-10-27
X-PR-Tracked-Commit-Id: abee7c494d8c41bb388839bccc47e06247f0d7de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed8780e3f2ecc82645342d070c6b4e530532e680
Message-Id: <160383525031.27184.482146752621696688.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Oct 2020 21:47:30 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Oct 2020 20:14:59 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-10-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed8780e3f2ecc82645342d070c6b4e530532e680

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
