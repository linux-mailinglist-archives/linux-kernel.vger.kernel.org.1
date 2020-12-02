Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CBC2CC84A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbgLBUt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:49:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731319AbgLBUt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:49:27 -0500
Subject: Re: [GIT PULL] bootconfig: Always use little endian for size and
 checksum
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606942126;
        bh=r0KNsIPoDA4dDmEX5fflHR09y7DpBnnmOVBMvvh/ARY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JYt2hb0wt6P70S/9rVNtsyhzuLh7Ox7bsKQ7n7Cz5hsfpHDhHzrm4lDDawHayUBa1
         uRR7iPffdHKWDnSYDo24VtbcYctQbieAljY+AcCztqhQHw/qhUiMsVJkMVYhahkzpo
         xJifx2xfPi9qjjP353lx5Bu05YlKVmmob7rGWVi/vTiF1k9WFpXWhDJ+8tRL3L2wcV
         MQjeg+G3Z6KrCEiflZQWRwdSNxHgrc+uHLpt7fz2iDrtp4DR/crMLbRDYXuM40wq0d
         bhYUvD8ZGDt4nr/omaGTZTTyw+rWA9E6GUYJ6R3LKOjfD5LnnwnmS7ymRgqgnUCR1l
         sOwOhsSOSbg+A==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201201202239.5618b84c@oasis.local.home>
References: <20201201202239.5618b84c@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201201202239.5618b84c@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.10-rc6-bootconfig
X-PR-Tracked-Commit-Id: 05227490c5f0f1bbd3693a7a70b3fb5b09d2a996
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a02ec8f35779335b81577903832c2b3c495e979
Message-Id: <160694212648.5087.892158938767968766.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Dec 2020 20:48:46 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 1 Dec 2020 20:22:39 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.10-rc6-bootconfig

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a02ec8f35779335b81577903832c2b3c495e979

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
