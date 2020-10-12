Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7530928C4CF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390130AbgJLWeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:34:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389660AbgJLWeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:34:04 -0400
Subject: Re: [GIT PULL] x86/build change for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602542043;
        bh=8vdXBhqSm74MflZ1+GvUjsqDyaZBM5BR+M9VWFxGRdU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=w3GJhFQ7QEWd+bQ+iWubYjJ7CN+4x/llbHNx9aqitzQWvpLnNCWrhSJcW8vlqDC8N
         4/Ktr12i8vrgpPX5JjbbgCP4cSzyzF/qpSch8+3L5zFl+tnX89h53fi+tqikkE/fJb
         yV3kcbYbb6iQt9Lkn3yTst6Zx+dwPoXu7J/cbunk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012172630.GA2963540@gmail.com>
References: <20201012172630.GA2963540@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012172630.GA2963540@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2020-10-12
X-PR-Tracked-Commit-Id: 642d94cf336fe57675e63a91d11f53d74b9a3f9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad884ff32931265294a8989636a5a76aea06b571
Message-Id: <160254204355.4463.15599882534588262974.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 22:34:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 19:26:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad884ff32931265294a8989636a5a76aea06b571

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
