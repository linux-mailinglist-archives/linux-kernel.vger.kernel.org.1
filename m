Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70389245565
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 03:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgHPBzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 21:55:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729706AbgHPBze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 21:55:34 -0400
Subject: Re: [GIT PULL] scheduler fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597542934;
        bh=bOLJZhfwZM/IyStIYj5LjqYrcRgfByCVbTkcZgs9ehI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Z8eZjUVcdgW0duJzoDq2+ohWBlESsCtWuvMphjVtWy7BxeyWP0v1DyWmEuRkkL7MP
         CJsgd68hGExB5X9h/5PvOCptFb1PJKNqS1RuEG3vG3j0z9xqFK3t7oVrRWvHuKDOdL
         Bp9Zr2FScQlWM2cfiiH5yPf//NYa/9R+SNWVvKmE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200815112731.GA2640991@gmail.com>
References: <20200815112731.GA2640991@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200815112731.GA2640991@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-08-15
X-PR-Tracked-Commit-Id: cc172ff301d8079e941a6eb31758951a6d764084
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1195d58f003bf84d37fc5c30017600e09ba567b2
Message-Id: <159754293418.18953.5561358219777054709.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Aug 2020 01:55:34 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Aug 2020 13:27:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-08-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1195d58f003bf84d37fc5c30017600e09ba567b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
