Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15FD2BC992
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 22:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgKVVfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 16:35:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:36224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgKVVfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:35:12 -0500
Subject: Re: [GIT pull] sched/urgent for v5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606080912;
        bh=zOdn3lc4gsysEGzd5cKeC9s21yNo8GsTJmHbjOKseNA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ys546Nbi+GTKmQ8AnOFZAUrgZp/cWVz8dUEBLBUNgzXdqkiGcEZDK7FCtIMsDLMV3
         WQlBaCpMUDqfft1Jx0lamJ9wdWoY3zo7tAYAwWJN8iuYuIuH4qsBwvDOyILw9BRTfl
         7J6E+sPf3gN+ngAqnCgjWq8eclxMOl+oKrGSwYrw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160605644542.9003.12382410127919559065.tglx@nanos>
References: <160605644301.9003.16302947389602369819.tglx@nanos> <160605644542.9003.12382410127919559065.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160605644542.9003.12382410127919559065.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-11-22
X-PR-Tracked-Commit-Id: 2279f540ea7d05f22d2f0c4224319330228586bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4b936f5d6fd0625a78a7b4b92e98739a2bdb6f7
Message-Id: <160608091251.6067.11472237888931261505.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Nov 2020 21:35:12 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Nov 2020 14:47:25 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-11-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4b936f5d6fd0625a78a7b4b92e98739a2bdb6f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
