Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE9E2AA7C4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 20:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgKGTn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 14:43:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:47834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgKGTn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 14:43:29 -0500
Subject: Re: [GIT PULL] RISC-V Fixes for 5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604778209;
        bh=RBvFnZEJ5sR/qnXqblElAitROl9YLY1Y8CJ/7Uax/Qo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j4Na6VMSKFQPq6olMjiZntb/zVJaO4er9KYyiMa2Psj0k1HMK5FCYpxAWRYpCsCwK
         0DfJl2rDXmXlWMiF5KesFXVdt3rSEpPiWvVkFGXu7NKwV6+A0heGpFXh08Ao/btSnC
         HUcpVXJpmuoqtSJrnBrDrZvIas/o7dHRK7rAF28U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-3492671f-a069-445d-a6d8-89363714a1fb@palmerdabbelt-glaptop1>
References: <mhng-3492671f-a069-445d-a6d8-89363714a1fb@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-3492671f-a069-445d-a6d8-89363714a1fb@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.10-rc3
X-PR-Tracked-Commit-Id: c2c81bb2f69138f902e1a58d3bef6ad97fb8a92c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b1d362db99d9233406cb7cfe35fc698ef92be25
Message-Id: <160477820907.15421.11445199450215268776.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Nov 2020 19:43:29 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 06 Nov 2020 23:41:08 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b1d362db99d9233406cb7cfe35fc698ef92be25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
