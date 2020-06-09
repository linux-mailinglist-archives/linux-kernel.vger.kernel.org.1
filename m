Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A271F41D1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 19:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbgFIRKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 13:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbgFIRKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:10:24 -0400
Subject: Re: [GIT PULL] tracing: Updates for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591722624;
        bh=sG1n+CM3WK4BHIx3A45YlQkI+/INiFgXBl+1/h1AMUw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zVkz+l5Ci1ywmBzlEDJ5PphQ9rt2Mz5O7HAv9yyfAVV7F6tylEnNMbU/x6PDZ6+tA
         leCcsPKcNI6ubdMS9D9zcgf2J3giAaOJcI0Ov53OfwtFAx2ucaaOSY16Bmk+yoU0lL
         JB3efdr/EPmV6yN/wKpv3PYt+jHzVCep/XVsigS4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200609091740.303dda01@oasis.local.home>
References: <20200609091740.303dda01@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200609091740.303dda01@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.8
X-PR-Tracked-Commit-Id: 388d8bdb87e01bcea6d0b2bf797b5f6d7b2401fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1e521adad250ab8c979861c857fa2b1542c9741
Message-Id: <159172262411.7211.1849583354629591619.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jun 2020 17:10:24 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Jun 2020 09:17:40 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1e521adad250ab8c979861c857fa2b1542c9741

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
