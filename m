Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097E028C4CE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390046AbgJLWeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:34:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388401AbgJLWeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:34:04 -0400
Subject: Re: [GIT PULL] x86/paravirt changes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602542043;
        bh=BXP9zpy9URyzNfYtK1xT6GYtTcQVgrGJqYILar1oDWM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=euwTWmDy99YHdVIzfVFFjl287uKM4cJDHw5q28641GSzMC78v+xKAlumFnkWXVkYB
         N5I1x8Ad03KjUPzq67gxIji8XiGEaFH+m5sej7K1UMU9Z6fMBZXe9+r+H4l1Vj5DuA
         XtZFgAmP4PT7EBezOPNXVdDggG63t5OiqsamMAe0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012173046.GA2992944@gmail.com>
References: <20201012173046.GA2992944@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012173046.GA2992944@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-paravirt-2020-10-12
X-PR-Tracked-Commit-Id: 7c9f80cb76ec9f14c3b25509168b1a2f7942e418
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee4a925107d1f4d10ee0a935841c2491f1c06ec0
Message-Id: <160254204376.4463.2078676398973275974.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 22:34:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 19:30:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-paravirt-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee4a925107d1f4d10ee0a935841c2491f1c06ec0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
