Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378BE276362
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 23:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIWVya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 17:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgIWVya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 17:54:30 -0400
Subject: Re: [GIT PULL] bootconfig: A couple of bug fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600898069;
        bh=BxFusWaEz1d6jI+EYAkrUvXaPItea/qnsKJ88tFxoMw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=H0B17XhDorycjcxYqHfH2uD36plyFA6+husWtnBLyz9+XmDfxcsfQcSMgTIM2TmrQ
         hiiQl5ozBAOC3NuDHW9Msw0UJ02v4wVniDEla+UheUVslRNyOCpSMyksFW9BoetP3W
         Xsk+fsg0bL/T9lyhkuI9Gzws5HVgU4F9qMwkWaEc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200923135448.5d8d9cb9@oasis.local.home>
References: <20200923135448.5d8d9cb9@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200923135448.5d8d9cb9@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.9-rc5-2
X-PR-Tracked-Commit-Id: 2f5fb555637eff4a3e5579f2323cd358c77efdc8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9c9e6a49f8998e9334507378c08cc16cb3ec0e5
Message-Id: <160089806994.12557.10770523180202860171.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Sep 2020 21:54:29 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Sep 2020 13:54:48 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.9-rc5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9c9e6a49f8998e9334507378c08cc16cb3ec0e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
