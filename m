Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9521EB15D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 23:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgFAV4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 17:56:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbgFAVzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:55:09 -0400
Subject: Re: [GIT PULL] smp/core changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591048509;
        bh=lz4aMC8kr2tCkEDoEjSDkZJHG0bMsYW5Mfqbe7u/VRw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wodty0E2nZehFujosQv2iUCliern72cD1v1mWEvfZB9qGYInSN5o8W5QhyUbm7iPx
         UHtCq1Zjq1dQjmWLfUUgAVIuBZrK4n9FvA94UozWWyTCKbTds48OCqpsm64qLEAFRM
         LS0hPkzGRQh58nWaC5EYYtOGBdHt/jffxhJlUe6c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601161136.GA1094087@gmail.com>
References: <20200601161136.GA1094087@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601161136.GA1094087@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2020-06-01
X-PR-Tracked-Commit-Id: fb7fb84a0c4e8021ddecb157802d58241a3f1a40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d861f6e6829ce586bcf5823ab7d348f09be3c8fb
Message-Id: <159104850951.21074.960624797986740062.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 21:55:09 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 18:11:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d861f6e6829ce586bcf5823ab7d348f09be3c8fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
