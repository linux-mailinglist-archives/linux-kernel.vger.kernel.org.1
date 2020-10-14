Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7841A28E571
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389409AbgJNRhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388902AbgJNRhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:37:12 -0400
Subject: Re: [GIT PULL v2] objtool changes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602697031;
        bh=qR7q+51k2U2YCynBkaevofidbLkPqtec12TdvDnqr8U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Qhm3mEeoXU1ifg33/d5dbHmk92nnxetUVljIMtXta4HOEjKGuXixlzxb9P5R9dsAF
         2kmsZrtisEC2AYP4NzWHf555uEfPS9U7O9qYzvXbXGt5Q2J+edbfiozxoJhHshUA0e
         B+EF4ERArEIxlczc5F6OJqTmzvw9G0Sncgy5s0M0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201013103831.GB3933713@gmail.com>
References: <20201013082625.GA775379@gmail.com>
 <20201013204312.6052157d@canb.auug.org.au>
 <20201013101056.GA3933713@gmail.com> <20201013103831.GB3933713@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201013103831.GB3933713@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2020-10-13
X-PR-Tracked-Commit-Id: ab0a40ea88204e1291b56da8128e2845fec8ee88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6873139ed078bfe0341d4cbb69e5af1b323bf532
Message-Id: <160269703173.25844.17850482422531166796.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 17:37:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Oct 2020 12:38:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2020-10-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6873139ed078bfe0341d4cbb69e5af1b323bf532

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
