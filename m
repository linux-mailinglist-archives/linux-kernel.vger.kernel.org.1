Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA6F1EB15A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 23:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgFAVz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 17:55:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728866AbgFAVzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:55:11 -0400
Subject: Re: [GIT PULL] x86/build for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591048510;
        bh=Hlr97GTi4JR0pMD1QFmmhuDSdbEaOurIGjWzzd6EG+E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JilMO4ccss0qGaIwAbUHRdCbEnfpcshsBBBqnsd9qi5I63yGgNo2clEsAkJs3J+p5
         Wt9EGVAgDqEtL1w+X0h1K5iTUTouXj1KqrSanVxRSry9C6m/C8vOLJjLvlQfM6g6oj
         KSrTWp5VSNdtO/fOaqqOUZkyWGP3f027TXf8QhMs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601163154.GA1179988@gmail.com>
References: <20200601163154.GA1179988@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601163154.GA1179988@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-build-2020-06-01
X-PR-Tracked-Commit-Id: 38f3e775e9c242f5430a9c08c11be7577f63a41c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb548bedf5c596f72b6388804b3cbd2f78c9dc98
Message-Id: <159104851089.21074.1782505486013352758.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 21:55:10 +0000
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

The pull request you sent on Mon, 1 Jun 2020 18:31:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb548bedf5c596f72b6388804b3cbd2f78c9dc98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
