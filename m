Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DB3290C79
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 21:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411200AbgJPTyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 15:54:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411178AbgJPTyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 15:54:39 -0400
Subject: Re: [GIT PULL] printk for 5.10 (includes lockless ringbuffer)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602878079;
        bh=dHo/LnIi6WJPm/eWNUtFyRVWVjkyX/CQilFE4bP0ojU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qCNWJGmZzoJJrLTc2AnaR+zxsCvaWVy12YbRByGIppL83YAdXEHSAVC8Yuvzdbqf0
         kaCQChZ3ujV292QxBnJCs+s5Y2BswUJaXpzK3EnsZVuRG+7syq/lIw47ymLTcbztjX
         CJJgIlpXnTUjWdzcvJ75stDr/Ngw989h2KLeUU68=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201016150554.GI8871@alley>
References: <20201016150554.GI8871@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201016150554.GI8871@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux tags/printk-for-5.10-fixup
X-PR-Tracked-Commit-Id: eac48eb6ce10c1dc6fd3366608f4d3ca2430166c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8119c4332d253660e0a6b8748fe0749961cfbc97
Message-Id: <160287807931.14002.17064156594142196406.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Oct 2020 19:54:39 +0000
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Oct 2020 17:05:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux tags/printk-for-5.10-fixup

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8119c4332d253660e0a6b8748fe0749961cfbc97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
