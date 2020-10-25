Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6BC298326
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 19:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418228AbgJYSfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 14:35:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1418143AbgJYSfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 14:35:23 -0400
Subject: Re: [GIT pull] locking/urgent for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603650923;
        bh=vAwCK8Yl04MW41cmWZa12YtWroqj9UhYzQXQakJTY2g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eHTOrLC8IXjcOM5nt3IrZFI4ZXip14vWpNQwWJaLoL8nZnpORQZu5MEmq82OkIn7l
         JzUJA/LGQltVQ4NlRepXDwT46IDNF8Oa8EgiTXMXEsIdOGW1bcZbyQeEGawuG+j6Tf
         BpLgRZSo7ea9tFnbzqT+gdNKLjIkQUOA1qoM8Pqs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160363590465.1234.11586095980767794789.tglx@nanos>
References: <160363590465.1234.11586095980767794789.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160363590465.1234.11586095980767794789.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-10-25
X-PR-Tracked-Commit-Id: ed3e453798d4f81c99056aa09fcd79d0874a60fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c84550f47f35851c5d37405b888ba964053fca1
Message-Id: <160365092353.20889.12352560633647514611.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Oct 2020 18:35:23 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Oct 2020 14:25:04 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-10-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c84550f47f35851c5d37405b888ba964053fca1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
