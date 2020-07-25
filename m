Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25B622DA3E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 00:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgGYWaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 18:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgGYWaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 18:30:05 -0400
Subject: Re: [GIT PULL] scheduler fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595716204;
        bh=RSqJnpn+19tZLCn7UoK87tOErsxaAHybLVcR5pOEFoI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BV9fwnx7G5od4jnHC5gn8EzpVcvCRyBhQoi+ECs3l9sUqhkkdL5SxXBTfaHYk6iDE
         qOoprsV+YCFDFLUSxpV/WPOqt2ZhJsaqfCRHtLHFnlH1qm6uL/iRL4KxIavPWIPT9/
         duvV1CuSqWEgIETcJeO+tqFrHLgp1A5h+blWCvr4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200725104720.GA824189@gmail.com>
References: <20200725104720.GA824189@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200725104720.GA824189@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-2020-07-25
X-PR-Tracked-Commit-Id: 062d3f95b630113e1156a31f376ad36e25da29a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3077805eebb63d75ad716e36777a54a3321d34a5
Message-Id: <159571620490.7388.4683562674054019071.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Jul 2020 22:30:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Jul 2020 12:47:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-07-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3077805eebb63d75ad716e36777a54a3321d34a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
