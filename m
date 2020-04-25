Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F3C1B88F5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 21:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgDYTaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 15:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgDYTaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 15:30:17 -0400
Subject: Re: [GIT PULL] scheduler fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587843017;
        bh=6dtNahQ+SGqG6EYsAVrJsJ6pOSe2rPat4StJj/d4pEs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tY8hJLGWzkIIrzxBzX8f9BEjqI9jl7xNi7BRSsB4yWwPuG/PcYtoGEwfDIxLEFbPc
         3sjHlfAY1g3pkO4cHiA4PSDo/P+evirtSmCjhS2vZMpGmmt1UegTIV6fO1FsEqRx5o
         FLyhh5TC/li36mWhYoizPqKryYZCcINczPZZBN2I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200425092818.GA58070@gmail.com>
References: <20200425092818.GA58070@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200425092818.GA58070@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-2020-04-25
X-PR-Tracked-Commit-Id: eaf5a92ebde5bca3bb2565616115bd6d579486cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05db498ad94431315c73efe623eab7a7d2d961c6
Message-Id: <158784301730.5802.6201156772992452888.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Apr 2020 19:30:17 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Apr 2020 11:28:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-04-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05db498ad94431315c73efe623eab7a7d2d961c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
