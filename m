Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5633623B1E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 02:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgHDAu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 20:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729250AbgHDAuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:50:07 -0400
Subject: Re: [GIT PULL] x86/cpu changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596502207;
        bh=L5Pcs/heHuX+wy64H7lr3Ul6RLAoFZCeE2VlvJPnhmw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oT0esoV58jLa8YVz7plP72DZ2yjlL0nFjSsBgMxfymTHd8mCpO5k3KG1soJr4ACYM
         rEmrFGyBzTfqxgdDHJuNGSZ2zWhHPGE3upRh871MFjgBQZShgJ7KfF/mPwBicVycE4
         I5ZxAtE7hXrRnvHqVcsYX1GwthOEOvWxPPFGVB14=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803180336.GA1041383@gmail.com>
References: <20200803180336.GA1041383@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803180336.GA1041383@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-2020-08-03
X-PR-Tracked-Commit-Id: f69ca629d89d65737537e05308ac531f7bb07d5c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 335ad94c218e96ef12f56d93eadc884731aa23b1
Message-Id: <159650220707.17631.15935543953655156041.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 00:50:07 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 20:03:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/335ad94c218e96ef12f56d93eadc884731aa23b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
