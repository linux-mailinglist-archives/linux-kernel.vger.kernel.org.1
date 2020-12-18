Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690502DE99B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 20:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgLRTLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 14:11:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbgLRTLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 14:11:19 -0500
Subject: Re: [GIT PULL] RISC-V Patches for the 5.11 Merge Window, Part 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608318639;
        bh=HHjqFizdZpjgkWrzLkZbiFgqfTZmzHzCGLToJgYSaD4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ca94pmBZcnUytQExMAn4yoXqDY/wuVspvi1WK6m8g8AHzSnytPU7EvX3Wnyufl9RS
         owidJ8CyfUKEkj9LtyKGLWEvyCwqQfVGUDBKW7gI/yo/TWDkkO/xdOqkSXjXM13Iiz
         rarxgQqNrS33bjjLb94bZf5HzEbZGB+06VSkcjrUsPiQgeUoXpotNQ6OBST1+8mGTk
         QMhOaYpocd48FrmHszWBIMyJ7YciUHqlQjSNOKMD9muhS06urz2DLRU75mXtKxBMTK
         ArjWhHCsah3YlkKXRE8DlOldYIAzA6aJhc2PI8+byML+5KaliTRb4NgdF2+sx9t+dl
         qpP+n5w+Glt4w==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-9bb2f707-7aac-4141-8e3b-edc1b463fcd6@palmerdabbelt-glaptop>
References: <mhng-9bb2f707-7aac-4141-8e3b-edc1b463fcd6@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-9bb2f707-7aac-4141-8e3b-edc1b463fcd6@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.11-mw0
X-PR-Tracked-Commit-Id: 7d95a88f9254b711a3a95106fc73f6a3a9866a40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2ae634014d3a8839a99f8897b3f6346a133a33b
Message-Id: <160831863914.5982.8524807332166745328.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Dec 2020 19:10:39 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Dec 2020 19:10:50 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.11-mw0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2ae634014d3a8839a99f8897b3f6346a133a33b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
