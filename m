Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32798202661
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 22:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgFTUZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 16:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728775AbgFTUZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 16:25:23 -0400
Subject: Re: [GIT PULL] tracing: Tracing fixes for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592684723;
        bh=kfnA/lzqSbh7oaXhpAfyPlYMD7VmYW74cgsr7Sz9SuU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vYDLr0HMbpABe/5W2MovAZo1d/7oO8bGZHNuIxvGeAh+/h7G1o/dGe7/ajjQNCR0K
         8xPipy2FBBlGfN6kNn4Um3wZCH1pSaDyesUtPu3+fHdzHoWCy3NpfeglZijj+VHEj8
         Mhk4J9yvf5bsKQmw9G07DlIXIzzWem+QlFvjB/Jg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200619212427.60abc603@oasis.local.home>
References: <20200619212427.60abc603@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200619212427.60abc603@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.8-rc1
X-PR-Tracked-Commit-Id: 026bb845b0fff6dec91fe24511dad7d3067dc3ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b6ddd10d678bebec32381f71b6b420bafc43ad0
Message-Id: <159268472324.18389.4393749772581374046.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jun 2020 20:25:23 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jun 2020 21:24:27 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b6ddd10d678bebec32381f71b6b420bafc43ad0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
