Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BEB23C592
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 08:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgHEGFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 02:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbgHEGFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:05:17 -0400
Subject: Re: [GIT PULL] printk for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596607516;
        bh=QjpK2kFG9A6n4diTLTZPLOEYDvCtvR6d89F1pZJ0dHA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wLPvEQ8mzUDKhooyEzr/PIot3v13iJGpbOxxXsZE7ND72eixIB4vQf440ygpxZjz0
         rfPWdtllIpu4EoLou+ORSGylkauI5ROBCsvDUwdB03aODvNCr3AUXAXAJzSXrFfjX9
         TBRyNnJnrbYzCfwJHG6KcpKglaoVNGOveRcLK2lM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200804171209.GF24529@alley>
References: <20200804171209.GF24529@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200804171209.GF24529@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux
 tags/printk-for-5.9
X-PR-Tracked-Commit-Id: 57e60db3bc4d2755aefe5abd1024662f478770ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a754292348bf88ec6b55563eca4faba7dcfe2ae7
Message-Id: <159660751604.19907.7572550374048226351.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 06:05:16 +0000
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

The pull request you sent on Tue, 4 Aug 2020 19:12:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux tags/printk-for-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a754292348bf88ec6b55563eca4faba7dcfe2ae7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
