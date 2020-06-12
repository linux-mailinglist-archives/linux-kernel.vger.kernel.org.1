Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFDD1F7D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 21:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFLT0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 15:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgFLTZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:25:31 -0400
Subject: Re: [GIT PULL] printk for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591989930;
        bh=o66TgqJCCvgx5tH/sel8vwZ11HbUm8QXxlYucoJdTLM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J0r120bcOQ25099xb/mvmf9K2I+abAwl6qp6Ub91BrpyYM0FGVmVIuLP9EKBF7NwO
         uVWqIED32BYwzdnFz7bJQzCTcdFonqmPEoCCwj8uOZzqIjriA+4TzsIEmYrJNwkgO8
         Z9p+C25Km7nDrp4FsOc88fbrVpMm2Vwi6lN4lAgM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200612084049.GC4311@linux-b0ei>
References: <20200612084049.GC4311@linux-b0ei>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200612084049.GC4311@linux-b0ei>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux
 tags/printk-for-5.8-kdb-nmi
X-PR-Tracked-Commit-Id: 2a9e5ded9543436620a7fbc9329ddcc32bf97bc7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c2fb57af0f42550eb718a3b0b445c81ec923895
Message-Id: <159198993089.4050.1219224835189781022.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jun 2020 19:25:30 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jun 2020 10:40:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux tags/printk-for-5.8-kdb-nmi

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c2fb57af0f42550eb718a3b0b445c81ec923895

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
