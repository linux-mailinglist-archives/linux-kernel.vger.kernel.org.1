Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2196B245566
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 03:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgHPB5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 21:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728959AbgHPB5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 21:57:07 -0400
Subject: Re: [GIT PULL] A RISC-V Fix for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597543027;
        bh=cAJrAP63vyHizFBti+jyzu+VN4BLiVQ1YOGXd47g3ls=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2sQ0h47rk/jThYQWXSbsJ+dbtyPLgs0x5HhT5rZ/IPoOX4ddZojQ24E4QPvV3Rutl
         B8Na6ccNJIWlEmbj6sX9Eanzb0e2qCkIa4xu4Q0qLUNyFcHgOZPIBS45WB2ohVaXb7
         5bbjGtfxZlgQU4MJGJbGewkvNE2nSpE1buvhVNFU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-9e581f1d-3696-40ba-8a64-b0910d6c85bb@palmerdabbelt-glaptop1>
References: <mhng-9e581f1d-3696-40ba-8a64-b0910d6c85bb@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-9e581f1d-3696-40ba-8a64-b0910d6c85bb@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.9-mw1
X-PR-Tracked-Commit-Id: 76d4467a97bd8c4bb01e810a5129c8f96d7dcbf8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d84835b118ed8c14c21fa056ca54014b2eff068b
Message-Id: <159754302721.22546.13234087526570060438.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Aug 2020 01:57:07 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Aug 2020 15:39:41 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.9-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d84835b118ed8c14c21fa056ca54014b2eff068b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
