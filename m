Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A62297DF2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 20:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763695AbgJXSLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 14:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763688AbgJXSLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 14:11:16 -0400
Subject: Re: [GIT PULL] RISC-V Patches for the 5.10 Merge Window, Part 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603563076;
        bh=8fw4vQh+vMRJ2XQEavl7iG2o1D1LWZm/tdDRFXflFtQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OgeeNaDpenj53Ip5q/l0kuUpP7/gqlNvjJeWZdLDs86ALsHyR+G130hKQpBp528Q6
         L5xrO/+hmv0olHzvgwEfIXzul01q26BStc51SXAEhesAvv8vK1colWCaOakUv3+XOP
         L08mbC6kdzYJUnnTpc/kRQK52U3nntnIQnLB6onA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-ed53d520-0ecd-4767-ade1-f4266118c3c0@palmerdabbelt-glaptop1>
References: <mhng-ed53d520-0ecd-4767-ade1-f4266118c3c0@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-ed53d520-0ecd-4767-ade1-f4266118c3c0@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.10-mw1
X-PR-Tracked-Commit-Id: e8d444d3e98c255f91d228984abc46cfdfaf48b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0593c1b4598a77b5f835b278cde0ab71e2578588
Message-Id: <160356307627.29626.11197947365181304549.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Oct 2020 18:11:16 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Oct 2020 22:13:02 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.10-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0593c1b4598a77b5f835b278cde0ab71e2578588

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
