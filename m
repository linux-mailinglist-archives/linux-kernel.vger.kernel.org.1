Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FCD2EF958
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbhAHUgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:36:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:48144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729340AbhAHUgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:36:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EFDF623A9C;
        Fri,  8 Jan 2021 20:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610138167;
        bh=vttOgl3S39XzGTnWEWBd+koeY6qXDdlQvtrRefBDAkc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MUyyboNK/uui5uldRpJT68tUt5GIaQgf945W+Vx/lryXS5mwJmW4slJBslKdoDkec
         gfiZce9lDVCb5+7dQe5PKDDZvpEnlMjjt2AEbPFP5dvzpAihaAFoE7mOWByM5+zU4W
         FF02KP//Fecfeb0a9QUqdCuWTSZ2o3Zqo6Ca9mTsm1aEyT4p0F61Y78IDdRX7O/Tkc
         caQyRw1jcY4Zw/fPHdP2WrErD+vCHycAZu2xFmkpX1zUqPTxwXhGb4rnklVTa2p4V9
         ELsy6a72fCTVPTw3Ckoo7bD06Yz1m1HdgiEIVORuQhte3RQgkd6Jax2dNzPA2WW9QD
         r70zc1e9DmnfA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id EC31B605AC;
        Fri,  8 Jan 2021 20:36:06 +0000 (UTC)
Subject: Re: [GIT PULL] gcc-plugins fix for v5.11-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202101071517.4415D1F7@keescook>
References: <202101071517.4415D1F7@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202101071517.4415D1F7@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.11-rc3
X-PR-Tracked-Commit-Id: 67a5a68013056cbcf0a647e36cb6f4622fb6a470
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4cc3b1de31b76f425ce92854783709386f9e1b7
Message-Id: <161013816696.21693.8446430081551761554.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Jan 2021 20:36:06 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Jan 2021 15:18:24 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4cc3b1de31b76f425ce92854783709386f9e1b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
