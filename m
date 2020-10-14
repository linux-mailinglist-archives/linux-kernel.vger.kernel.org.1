Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F396728E572
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389380AbgJNRhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389340AbgJNRhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:37:12 -0400
Subject: Re: [GIT PULL] objtool changes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602697031;
        bh=K9Nx+HTPVwSMCrDIW+jm/ZUGZYZlKMGXr+nbVx+eD8Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ElY8lxE5jUDXpSQWUVvqXGEsFmFbPU3zfvEUvKWn3XC8ZNuNkUpt9bH2LILJHhAW3
         2ptp9EzK4aCbGewD1LYPiO+djX6yNtVWzJYKbBnjjh0ec7Hn4lc3lwsOnBUTna6CW9
         3fuEmOWOGVczlbkMXsynqCufC2GCk/Zp5lvU3Y2Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201013082625.GA775379@gmail.com>
References: <20201013082625.GA775379@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201013082625.GA775379@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2020-10-13
X-PR-Tracked-Commit-Id: 2486baae2cf6df73554144d0a4e40ae8809b54d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab0a40ea88204e1291b56da8128e2845fec8ee88
Message-Id: <160269703147.25844.10084774532097496188.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 17:37:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Oct 2020 10:26:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2020-10-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab0a40ea88204e1291b56da8128e2845fec8ee88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
