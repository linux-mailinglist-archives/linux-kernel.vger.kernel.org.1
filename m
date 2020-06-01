Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47101EB158
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 23:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgFAVzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 17:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728823AbgFAVzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:55:07 -0400
Subject: Re: [GIT PULL] locking changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591048507;
        bh=syyHu7ExoVRERIefFajavPx4qYgQaGtIzESLCYALvYA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HCr39pYPrZ9SgA6jOLw/iyf86fK8LHtFn9fpujLAzcSnXlcnat6bOfDEnWYUZw2vG
         TBQTJIp3S8nEf8G9o3I5hnpJYuJP1txrutzZNJf4FsHzdtXGEgwhKHRAq5LifmnZvX
         1zbTvN+Z+mj034mrAIyUxG3A197ansnQwXcB59CU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601133228.GA834929@gmail.com>
References: <20200601133228.GA834929@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601133228.GA834929@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-core-2020-06-01
X-PR-Tracked-Commit-Id: 19f545b6e07f753c4dc639c2f0ab52345733b6a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60056060bede58c3073dccb8a5e73a6c40804aa9
Message-Id: <159104850724.21074.4474404004179763671.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 21:55:07 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 15:32:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60056060bede58c3073dccb8a5e73a6c40804aa9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
