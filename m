Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E779128C3FA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbgJLVZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732150AbgJLVZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:25:08 -0400
Subject: Re: [GIT PULL] perf/kprobes changes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602537907;
        bh=+9C//FzH7vMIf6ZZ9/Uc41n1L/+s+WxmgaUy/ct0Bd4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y0Nn4axv8r90EdnRz+VI3k6nb4DnxF/FqhFdhG8xMy8UPONJ29fuhnWxVhy9ZrANt
         rMAghI2MxAqRMvGGpfngp5MujRpTHNqhkkvgFsgXrxCoEW7fmtroAt4g4dDAyasGjf
         No9ASA131P/UQyOkqEHR98PfjTh2dueNVLOWnOrI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012162337.GA3751519@gmail.com>
References: <20201012162337.GA3751519@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012162337.GA3751519@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-kprobes-2020-10-12
X-PR-Tracked-Commit-Id: bcb53209be5cb32d485507452edda19b78f31d84
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c6890707eb1438b0fb4e0a10d4afe48a217628b
Message-Id: <160253790757.926.1919099824045176542.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 21:25:07 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 18:23:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-kprobes-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c6890707eb1438b0fb4e0a10d4afe48a217628b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
