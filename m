Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F8C23F227
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 19:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgHGRr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 13:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgHGRr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:47:56 -0400
Subject: Re: [GIT PULL] RISC-V Patches for the 5.9 Merge Window, Part 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596822476;
        bh=aiSmJ6M3m4KFemyGg8H54Z+JLkfPFuM4Lq/xrEW90Jk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UR0bbyogQ7GFaNNHiNuAMp3B3yRQaP11+9Qj73XHH5VVpvSw3cd7FCzxQuUCpzHsT
         bSRn5eKMDrCg4Pijw6LOSDnZ+d39IDvhm9aaCvfEf0JCyTqpvilLT+hz35m6qBKElY
         gkMxbKz/lqPXBWx92/IgxAOFbqKINJ5CF1ImOEUo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-bb218bf7-4f63-48f8-95a6-67ff0d32a166@palmerdabbelt-glaptop1>
References: <mhng-bb218bf7-4f63-48f8-95a6-67ff0d32a166@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-bb218bf7-4f63-48f8-95a6-67ff0d32a166@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.9-mw0
X-PR-Tracked-Commit-Id: 40284a072c42f6177184fb1f62ba94c69e0c0277
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbf83817315d9ce93b3e5b1c83a167f537245bd8
Message-Id: <159682247650.18750.12723959783536094211.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 17:47:56 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 06 Aug 2020 16:17:49 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.9-mw0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbf83817315d9ce93b3e5b1c83a167f537245bd8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
