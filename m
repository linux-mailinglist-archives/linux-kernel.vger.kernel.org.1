Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CAF2B378E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 19:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgKOSAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 13:00:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbgKOSAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 13:00:14 -0500
Subject: Re: [GIT pull] perf/urgent for v5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605463213;
        bh=uvJSzyUp0b1Efy176fNwLuqFSiEaA8NFWbLSzbTgqyM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dhOzITVLFCNI8GG4aauhjh45R+UMzhOAK6AE6Ei5aLIgyRyGd0PCntGIl2q8AdncS
         c3ihJaxk8/+o0u8keYNjIsdxqmHS2dOWYG0H4DouK1Iw6b6HjElTM3RyDzrMLUOrpN
         cEjm2gb9ipgaAzRovf9uqBxlIf2G3rmsek0A7FfY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160544524145.25051.6722901041651113077.tglx@nanos>
References: <160544524024.25051.12292089189937197323.tglx@nanos> <160544524145.25051.6722901041651113077.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160544524145.25051.6722901041651113077.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-11-15
X-PR-Tracked-Commit-Id: 1a8cfa24e21c2f154791f0cdd85fc28496918722
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64b609d6a60c8a54ff9c43819803e6a7861e7ed1
Message-Id: <160546321385.32406.14551978599501632526.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Nov 2020 18:00:13 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Nov 2020 13:00:41 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-11-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64b609d6a60c8a54ff9c43819803e6a7861e7ed1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
