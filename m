Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709A82979EE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 02:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756290AbgJXA0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 20:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751068AbgJXA0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 20:26:12 -0400
Subject: Re: [GIT PULL] ring-buffer: Updates for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603499172;
        bh=WV4tlzDEK4xdmArV6yWKpJoVCzpDC+O+NAf9Llnx5JE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kZx3o1YFMh+9JJhbzsSALT1AJp4IWNj0xKllhQrJhvR38Zite0vTdeyC+fGFEWE4a
         J1AxaO+4O35k4cLQuAUyIw7mroYV9u1+ATzFrwMy1fRj/dZ2aNsHdrotf3eq5n6jHw
         3N5g2ogigcbENKt+eAmSdyoHDZRakvmXVZKdl7cg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201023120750.72f73a97@gandalf.local.home>
References: <20201023120750.72f73a97@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201023120750.72f73a97@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.10-3
X-PR-Tracked-Commit-Id: e1981f75d398c0afe83c8ffa4e5864f037967409
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5e5c274c920f693d9c1ab65440d8e53a4530aca
Message-Id: <160349917201.12519.11990675063591566526.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Oct 2020 00:26:12 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qiujun Huang <hqjagain@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Oct 2020 12:07:50 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.10-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5e5c274c920f693d9c1ab65440d8e53a4530aca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
