Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8296028C3F8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387733AbgJLVZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732124AbgJLVZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:25:07 -0400
Subject: Re: [GIT PULL] core/build changes for v5.10: Add orphan section checking
 for x86, ARM and ARM64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602537907;
        bh=b+G8yr+3fkuAp/1e2rzwpagMiC9nEInAkpq/12bWrRc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RFTyw0AbySj6LhB9eZ4CCFYQixownal2MAzqxOMcdWVPMZRYlq45og2In/GdlVIaK
         lvpSjW2Yqn9QzCPbBXLVBHPpdOMAmPAnh1D1ccnzS9VtP64bXpT9pzmhLt8P+TyOP0
         6FMon3NjjHpX8C83ZYM1RQ6YwMH9PoiJPn6c4FmQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012153430.GA3491427@gmail.com>
References: <20201012153430.GA3491427@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012153430.GA3491427@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-build-2020-10-12
X-PR-Tracked-Commit-Id: 6e0bf0e0e55000742a53c5f3b58f8669e0091a11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34eb62d868d729e9a252aa497277081fb652eeed
Message-Id: <160253790695.926.17859901104649363182.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 21:25:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 17:34:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-build-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34eb62d868d729e9a252aa497277081fb652eeed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
