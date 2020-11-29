Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7D52C76D8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 01:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgK2Abq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 19:31:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgK2Abq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 19:31:46 -0500
Subject: Re: [GIT PULL] RISC-V Fixes for 5.10-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606609865;
        bh=hgqkBHR4Xun9tcO+P6FZaN+z5+ES2O2FSjik8VIpQXM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UDMY+ZZcxSJZVDHA6BkuTQ9S14y/dFsjhjopSqpeNByyZ3b+XAB262voLoSAsyVl9
         NieGX5LGmosgA8r9JZv9h81xM9+6wlFAQeIXSQ7S+vlk6uC6XLnc9V8+zvVGeLi2sg
         O5iHDkj1nOOm0D27xXIeGbbqgsyF0G6cmbxdKZL0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-a86b7c3c-7719-48e7-b6b3-5d7ec6b8933d@palmerdabbelt-glaptop1>
References: <mhng-a86b7c3c-7719-48e7-b6b3-5d7ec6b8933d@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-a86b7c3c-7719-48e7-b6b3-5d7ec6b8933d@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.10-rc6
X-PR-Tracked-Commit-Id: 30aca1bacb398dec6c1ed5eeca33f355bd7b6203
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aae5ab854e38151e69f261dbf0e3b7e396403178
Message-Id: <160660986567.2144.11136173652409993464.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Nov 2020 00:31:05 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Nov 2020 15:00:47 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aae5ab854e38151e69f261dbf0e3b7e396403178

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
