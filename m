Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF6D2D898D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 20:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439834AbgLLTCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 14:02:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407792AbgLLTBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 14:01:52 -0500
Subject: Re: [GIT PULL] RISC-V Fixes for 5.10 (unless there's an rc8)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607799672;
        bh=Qymi6OWabOo9at3IXqABFyAKwXjko8RP497ekn2RpD0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EJ8qaLF6pLebNdv0lt/Ax2JCzz91OmGz9w9d+zw74ZUKBWx64ivxKhP0rEHD8TTuj
         KuR0Mu8ljchHIDLEszBaNU8dv2bA7LyBHlOo2JnQF5Urq8+Z4+kezTWfesKC3gkI0D
         uikaRCgEqRAgiBAevAMnjbgFhGTws2zx7wtAy9VsA1Yj+rl9ODEUwiKZQCceg+eZwh
         tx1k9ZwRSURu8qd86Dumspgz1aSeGFudToPIhRWeMlHcuyhIMBnuwVH3I05cZBatHc
         7de4xN1wmz0W5oMEPgnamO7H+9lJyKyZ8WeePgXOeojszhiL7ehuwLpUAIs8ShP0ur
         ENAvrmRrnhutA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-5e629583-5ff4-4523-bfdf-c4254276d95e@palmerdabbelt-glaptop1>
References: <mhng-5e629583-5ff4-4523-bfdf-c4254276d95e@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-5e629583-5ff4-4523-bfdf-c4254276d95e@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.10-rc8
X-PR-Tracked-Commit-Id: ccbbfd1cbf365b38d014351d1482fedd26282041
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b01deddb8d3cb779ac250978afd200931fd91dcd
Message-Id: <160779967212.16081.8987627923420642735.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Dec 2020 19:01:12 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Dec 2020 13:41:44 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.10-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b01deddb8d3cb779ac250978afd200931fd91dcd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
