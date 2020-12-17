Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F17E2DDAF5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 22:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbgLQVpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 16:45:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730128AbgLQVpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 16:45:36 -0500
Subject: Re: [GIT PULL] tracing: Updates for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608241496;
        bh=ad3cNyUr1BovzCmzMxAPlVk8WI1uQ7CDeqj0q9rGpE0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ElCFjKild2tkZwUgrEKVekqK1qU/LszGx8OOSUEvLTCUknMJ3A4TbU5Xq5owvhgA2
         KXFRW1KV0yGRCkr4kylYZeCfrif1UZiwfJe+Od+feO+6QTlxri4koEdWHW8xL6BAI9
         u7hC75LkXo5lfL0FKoP/hvWl9BZ+mu97bWWNyYE589f8ek8krPf6FDs2XcC2GdTxgh
         mjn8rWFFRtlfLWjz2q6iaHXbagGLcKhZsxfKnnvXFwX5jjGI6h/y/ktai6b9aNoT2F
         eTyaOGLG5sjPaFHWcKUy/tP5CQ7l/ojvdwMPjkaTGbgM0Db3Z23WR5e/hceOlXecuq
         OCXaKJ7pDYadg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201217140852.45d70612@gandalf.local.home>
References: <20201217140852.45d70612@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201217140852.45d70612@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.11
X-PR-Tracked-Commit-Id: f6a694665f132cbf6e2222dd2f173dc35330a8aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09c0796adf0c793462fda1d7c8c43324551405c7
Message-Id: <160824149592.19561.9457076918689812198.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Dec 2020 21:44:55 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kaixu Xia <kaixuxia@tencent.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Dec 2020 14:08:52 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09c0796adf0c793462fda1d7c8c43324551405c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
