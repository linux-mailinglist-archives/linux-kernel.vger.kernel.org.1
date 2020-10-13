Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6512028D734
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 01:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388111AbgJMXxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 19:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:32844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729942AbgJMXtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 19:49:14 -0400
Subject: Re: [GIT PULL] printk for 5.10 (includes lockless ringbuffer)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602632953;
        bh=zgNe8ZI1isOhwniv1xm9pLQCrP4G628NV02ovFJeN9Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=P7Di2Py/gvfT7DR2iPyIMiF/j/oGKywHmHW3fqXDtmJvFb8KpeUo+DWhndRN7VUZd
         9joBUjNy/6T1Du+q5XuPI9SDH5P347g08Bso/Ha7O8wHuIdlZqvc23umAhYCsGtdTO
         ipC/tmp+oHlmQIJjoG+TFNNftBlHLsxeRz5E7U6o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012144916.GB10602@alley>
References: <20201012144916.GB10602@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012144916.GB10602@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux tags/printk-for-5.10
X-PR-Tracked-Commit-Id: 70333f4ff9c16dd82a2667080c3ae48fe30a3cb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d594d8f411d47bf7b583ec3474b11fec348c88bb
Message-Id: <160263295377.20088.7679985592929794121.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 23:49:13 +0000
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

The pull request you sent on Mon, 12 Oct 2020 16:49:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux tags/printk-for-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d594d8f411d47bf7b583ec3474b11fec348c88bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
