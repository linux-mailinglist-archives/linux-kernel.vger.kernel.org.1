Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19232E322C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 18:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgL0R2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 12:28:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgL0R1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 12:27:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 52C4B22512;
        Sun, 27 Dec 2020 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609090026;
        bh=tm5Sjcbk+n3gqqgRSZrv3GC0HOUQoZI9BkXteeNdeKs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CQZgRab4e48iPcr4LewVGFWZ70lYBcD0VBOY5tTnsVk9jkKpOU9/2PL9NSFN8lqK4
         VOvm0TEnBChmf/29j+nbBYyqz/biGE+K2GUIy+ZCYg2B9kYp2mwLe6xsr7+syOyRRt
         efAtnlhk4OcU71Q7pZV9BChNJfzjHUGVdGjfEmUwV+z+EMHdLSrTExsFREYl6lMAdB
         tSsFqi/fSMAK4cAokH0withGXplxxGByLlsoXllAGQ+3Fr2UZnXPhC+Fpb6rkSpdGF
         ziaSfequPnNHKLaz5UqORskHQHRU/e8MNy0gyU4+Axk5k435YDKjnieZL6qtmwdXbq
         UFAWqHNRMxrEQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 4D778604E4;
        Sun, 27 Dec 2020 17:27:06 +0000 (UTC)
Subject: Re: [GIT PULL] locking fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201227095044.GA1841019@gmail.com>
References: <20201227095044.GA1841019@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201227095044.GA1841019@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-12-27
X-PR-Tracked-Commit-Id: 91ea62d58bd661827c328a2c6c02a87fa4aae88b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6be5f58215f1dcbd697a695ad5db9986c28c50c3
Message-Id: <160909002631.19416.10691858900678724228.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Dec 2020 17:27:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Dec 2020 10:50:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-12-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6be5f58215f1dcbd697a695ad5db9986c28c50c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
