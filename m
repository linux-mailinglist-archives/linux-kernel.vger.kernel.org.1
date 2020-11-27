Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817A12C6DFE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 01:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbgK1AkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 19:40:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728995AbgK0UBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 15:01:24 -0500
Subject: Re: [GIT PULL] printk for 5.10 (includes lockless ringbuffer)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606504792;
        bh=4q2KhKFF+EEegEsLEh4dml0kBFZMWpk+Lf3kXpy0hGE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=n0RMozc99s8BSCh0zAUCg40udtY5EO2hh1FTC4SYsNmmKUENzwPe9924we+bfUJvS
         LR4mwCiL8dWPWwckpm1cT+OmKP9kYqGgFDYP/za/7WEBllCQU33LRfwYitpZOoYLBc
         +TAHDT3Io5vF4y7qaQy4HUKWzLT1LwTwSi9JRxkU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X8EDY+hYkuyja5vy@alley>
References: <X8EDY+hYkuyja5vy@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X8EDY+hYkuyja5vy@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.10-rc6-fixup
X-PR-Tracked-Commit-Id: 739e7116b10bf8694795ed8365dd7cbe089b662a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43d6ecd97c0c69acffc918cc18cdabdfcaa55354
Message-Id: <160650479225.7570.6427782855740917557.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Nov 2020 19:19:52 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Nov 2020 14:47:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.10-rc6-fixup

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43d6ecd97c0c69acffc918cc18cdabdfcaa55354

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
