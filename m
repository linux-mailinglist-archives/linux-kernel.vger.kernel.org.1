Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748A52F22F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 23:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390666AbhAKWlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 17:41:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbhAKWlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 17:41:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id AB601222B3;
        Mon, 11 Jan 2021 22:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610404825;
        bh=tku730vYVw2BXbF+cIp4eI/dy1XVKT/ZozV7dirFPA8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mWE9THHcd4hIkUgTlmADTyN6N8NB/Zbsx7WG6S+JKvF1C6sh+4yIbj2420p7QD06f
         SybO4ZYKRswy4KUg/KxFmLZ4PcbLqwSJZX/zen5c54a+Tgak7HL5IoVaB0kpJFijfN
         bjFRf95YmsuI6C+RqDvRuS1BPWQl/j0PADRbQRull9gdN3CjqUEytVZZ30GBylpKHU
         BPD4xzR1/qWeJ/hL7m70A3Fs4+wODO8jJVcZwXIPR6AErrEMLN9RuOuEeAC5+gUhlY
         qHi80DwnMH237UUGOHtmSoqoFpds5opn0lWbWuoD1hvXv8GZ1HrGewYWBbEe4G9l9v
         czoLs+JZ7I6ig==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 98C6E600E0;
        Mon, 11 Jan 2021 22:40:25 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/kprobes: Do the notrace functions check without
 kprobes on ftrace
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210111162059.28d4c91a@gandalf.local.home>
References: <20210111162059.28d4c91a@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210111162059.28d4c91a@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.11-rc2
X-PR-Tracked-Commit-Id: 7bb83f6fc4ee84e95d0ac0d14452c2619fb3fe70
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0d54b4f5b219fb31f0776e9f53aa137e78ae431
Message-Id: <161040482555.23384.11326149910780672324.pr-tracker-bot@kernel.org>
Date:   Mon, 11 Jan 2021 22:40:25 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 11 Jan 2021 16:20:59 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.11-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0d54b4f5b219fb31f0776e9f53aa137e78ae431

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
