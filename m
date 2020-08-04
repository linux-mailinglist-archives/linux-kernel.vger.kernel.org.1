Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7354B23B1DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 02:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbgHDAuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 20:50:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgHDAuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:50:10 -0400
Subject: Re: [GIT PULL] x86/timers change for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596502210;
        bh=ZoO+g1N5XnwHONmOlAEhwVqJiVL6xf+o9n+Go/VFt/s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FiaZc0zAi7xJZPlqBBUKTrD+ksXjWJLi78mj4hgag03s+ZvVQjyM3Algn5531zk4W
         mp9gpJoswPtpNVGa3mIpDWEKg9klMEFi+Z3EacZsbQ11sTBDwEZGTHh/z32pBX9qTG
         uVEWZlVQy4p7gwfzM4T9/c+OyvRwIHMuox7G/HfY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803193539.GA1411343@gmail.com>
References: <20200803193539.GA1411343@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803193539.GA1411343@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-timers-2020-08-03
X-PR-Tracked-Commit-Id: 898ec52d2ba05915aaedcdb21bff2e944c883cb8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a92ad11fb209c8de0d358b78415fda5f01308202
Message-Id: <159650221007.17631.10487364717462990613.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 00:50:10 +0000
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

The pull request you sent on Mon, 3 Aug 2020 21:35:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a92ad11fb209c8de0d358b78415fda5f01308202

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
