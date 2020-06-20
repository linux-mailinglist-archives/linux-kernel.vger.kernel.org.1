Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C55C202645
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 21:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgFTTz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 15:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728666AbgFTTzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 15:55:24 -0400
Subject: Re: [GIT PULL] RISC-V Fixes for 5.8-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592682924;
        bh=YOhXoTb1o5C1Jl/TLWwhF9JZzy9ZzY00Jlr6C3UMC2c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=m6rbiu3I9do1tLyhAU9d/FO1rwxxO3a++llJhkKpGOFC5G/G4vYgEm56Y6SE6m5vX
         B9bLvVJcGEx+f2/z6ioEWkBWUvt4PGwv5wFeTmtC4znX4ryv917ZTBX95/OsUjiH+c
         oSb/dPuiy72Y/m63oZhzPny0+2I7WuZx+aX8OIso=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-ff59c9fd-a367-4804-bc35-73c8a572b016@palmerdabbelt-glaptop1>
References: <mhng-ff59c9fd-a367-4804-bc35-73c8a572b016@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-ff59c9fd-a367-4804-bc35-73c8a572b016@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv-for-linus-5.8-rc2
X-PR-Tracked-Commit-Id: 0e2c09011d4de4161f615ff860a605a9186cf62a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fdfbe08a2b3e2bf776e2f2b341768ba93c2e158
Message-Id: <159268292459.15446.1815019867968444758.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jun 2020 19:55:24 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jun 2020 16:24:29 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fdfbe08a2b3e2bf776e2f2b341768ba93c2e158

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
