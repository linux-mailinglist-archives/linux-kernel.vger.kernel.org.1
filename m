Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B748F20C9AD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 20:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgF1SpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 14:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:32968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbgF1SpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 14:45:14 -0400
Subject: Re: [GIT PULL] sched/urgent for 5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593369914;
        bh=qX2OmYnz+KVBpDOSnjtDO0STEfuHaH3Ng1w4oy/Ckno=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rcjEvy0vw4Zz0Km212F9ZSGonLiL033J/dulqtjQiWMJlI5khQu550MsC1+156g1/
         NZ+S7zzLiwSGXTxh/8i1kG3IpJv10xSDR8gfft5qAutAkqAmrThOjmQ4Jxh1iG08ht
         txVjt2wgYKHmSnqjyNjWhSuzFB6FlnTZHn0GilyM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200628152342.GE18884@zn.tnic>
References: <20200628152342.GE18884@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200628152342.GE18884@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 tags/sched_urgent_for_5.8_rc3
X-PR-Tracked-Commit-Id: e21cf43406a190adfcc4bfe592768066fb3aaa9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91a9a90d040e8b9ff63d48ea71468e0f4db764ff
Message-Id: <159336991415.7125.5610090828608915873.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jun 2020 18:45:14 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Jun 2020 17:23:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_5.8_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91a9a90d040e8b9ff63d48ea71468e0f4db764ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
