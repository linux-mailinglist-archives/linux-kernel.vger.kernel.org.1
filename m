Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0BF28C4CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389765AbgJLWeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389084AbgJLWeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:34:03 -0400
Subject: Re: [GIT PULL] x86/mm changes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602542043;
        bh=USPoreDj9bZg71MA4aeQUnZGzH2SDZQKKmV8xtcj3Xk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=x8s7VXloHX6Hd86APhyoD7ZRvHzUq2TZv+0LKZqmzkAwOA4Vo85mLkigunQEsxg1q
         dMPQYo8J69CJD9oYK0rHYN77ZLVSEvRnJx6zwKYsFzfgOVicCLH+UpxLGsyDZ2N9Np
         sKFXWVVn/vYX2GRJ3BJF42xNKELwzRUGVKshGIsE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012172415.GA2962950@gmail.com>
References: <20201012172415.GA2962950@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012172415.GA2962950@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2020-10-12
X-PR-Tracked-Commit-Id: 7a27ef5e83089090f3a4073a9157c862ef00acfc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1b4ec85ee40cc7a9f7b48bea9013094f2d88203
Message-Id: <160254204333.4463.13959719310829843881.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 22:34:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 19:24:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1b4ec85ee40cc7a9f7b48bea9013094f2d88203

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
