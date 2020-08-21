Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A4824E2F4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 00:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgHUWFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 18:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgHUWFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 18:05:07 -0400
Subject: Re: [GIT PULL] RISC-V Fixes for 5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598047506;
        bh=opOBlqaUGECh+5z5xpnvyiZ8AHozCfhVoJLtemUrOFg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vDxnRB7E92FJK9kzPB4fyfxG0U2U8fBGbSe/Q9/THG+bBgIqhryx3exsF0k3PwoGL
         2DKsUjX7t12Rafv5+mutDxsJdrVF3wak/0vVo0FP4zxXoDWvI/7qv12WONcBjzgme5
         ykxBHQ9mxQaE+jTz7jHZv2XQmbxixrBWd/Q92aNA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-32c8d053-acbd-4c72-b41d-8d6042ac639d@palmerdabbelt-glaptop1>
References: <mhng-32c8d053-acbd-4c72-b41d-8d6042ac639d@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-32c8d053-acbd-4c72-b41d-8d6042ac639d@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.9-rc2
X-PR-Tracked-Commit-Id: fc26f5bbf19459930b7290c87b65a9ae6a274650
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f22c5579a7d600fa03f8c1d150cf78188f8709b6
Message-Id: <159804750671.4316.9225136869085625949.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Aug 2020 22:05:06 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Aug 2020 11:26:44 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f22c5579a7d600fa03f8c1d150cf78188f8709b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
