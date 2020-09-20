Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CD127186F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 00:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgITWk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 18:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgITWkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 18:40:21 -0400
Subject: Re: [GIT PULL] locking/urgent for v5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600641621;
        bh=Yihw0dzkn6rxmsDq2aTYdf8a03ZN07dlmAA+Tkf5bnk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QmRtCgMsu1Qux8hDqLK5bQC5i1Oa742Z35Fd3C0iaiECJooVBAoEyjb4AZuCFIref
         KqKzv0sVBbXbqMPSH+QeQT9zky5gBgpI+SoukBFPROm0atKUzEKeYNDtbE6/GSykgX
         vX4FyZFm1Vb9VkeD0Jic03MjcbiKeGa7IIS216gg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200920195120.GE13044@zn.tnic>
References: <20200920195120.GE13044@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200920195120.GE13044@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.9_rc6
X-PR-Tracked-Commit-Id: e6b1a44eccfcab5e5e280be376f65478c3b2c7a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d491679b880006d2469ad14f73c2debb2a522bd
Message-Id: <160064162163.32524.10411456094699717485.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Sep 2020 22:40:21 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Sep 2020 21:51:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.9_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d491679b880006d2469ad14f73c2debb2a522bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
