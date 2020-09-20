Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5839271678
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgITSAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:00:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgITSAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:00:15 -0400
Subject: Re: [GIT PULL] RISC-V Fixes for 5.9-rc6 (or shortly after)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600624815;
        bh=zDZdy2/rOnaDLkaUwDrgQ6iWegH8r8eZeBuVbfVBAuo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RpOFY3dRA1kjtEBFlEyzubKpkWKi1vjwiMbCqj4BohEHju+Fj++kUR029nvp3rsZ2
         BI8xY8fPGFjXnRl9cpjOw460Eps1pc7RqSvvd3uSbDS+Qadt4oMOjTEu15+w7aWQvY
         aSS7rVGXg44eO3xwekrB11yqLiDazdnFrmEBmpIE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-a3f22c5c-7980-4ed9-b198-da86bf6d1162@palmerdabbelt-glaptop1>
References: <mhng-a3f22c5c-7980-4ed9-b198-da86bf6d1162@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-a3f22c5c-7980-4ed9-b198-da86bf6d1162@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.9-rc6
X-PR-Tracked-Commit-Id: d5be89a8d118a8e8d09cd74a921a808f17fbdd09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bdcf11de8f776152c82d2197b255c2d04603f976
Message-Id: <160062481552.1698.11531166567985103507.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Sep 2020 18:00:15 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Sep 2020 10:26:34 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bdcf11de8f776152c82d2197b255c2d04603f976

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
