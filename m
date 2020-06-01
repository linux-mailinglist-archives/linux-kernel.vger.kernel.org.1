Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E319A1EB154
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 23:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgFAVzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 17:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbgFAVzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:55:08 -0400
Subject: Re: [GIT PULL] objtool changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591048508;
        bh=9su0B+lIapB8a0TQ4la9rOwrBvm9ByXYZl9zsU7ytuc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wd1UwW/0mzIiAIwj7XiiNglp0pOO4/g9kDLHoeEwHfCZAD93ujQ/28GGYrIhv87oj
         E4O8Cu201vvT52mox5B8NyS7uyh0DnC9qjesFYdJc/b1eWUwuOD4u77vs+pM4/6N38
         dsvNLbuvLYzi50k8+h90gR6T2vfNMiRiMeE+33oQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601153114.GA994053@gmail.com>
References: <20200601153114.GA994053@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601153114.GA994053@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 objtool-core-2020-06-01
X-PR-Tracked-Commit-Id: 0decf1f8de919782b152daf9c991967a2bac54f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69fc06f70f4569c9969f99fe25bdc9a6bb537b43
Message-Id: <159104850805.21074.10760548772632631123.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 21:55:08 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 17:31:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69fc06f70f4569c9969f99fe25bdc9a6bb537b43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
