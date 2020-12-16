Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867422DB9C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 04:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgLPDpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 22:45:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgLPDpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:45:30 -0500
Subject: Re: [GIT PULL] erofs update for 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608090251;
        bh=2o+HUjbZOYAW9WX3CUsIxMGF/SZnDeVn+fubxMOp2jg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SbmFEbbm0O2a4CnU0BTgJowDF7EmAmhLkcLiZlhsrzVpiYa3US9GpmzUJ9O99Ahxv
         L+FAXLDRjyC4dhsnxfyKTcCwBI2a5KnmCz+V0hDam79kUTBDFo4gCZXpMf5rPa1MDh
         UYM+lc+nIzA+NaxY87elA6Ff9tDTe99r/RX06cOgvWCtgKh8bwhvxacKapWp+8cpn5
         ECDd/0lgXOWzxXbME3hZPVfKDoVD1/gfggFhLDcgRrPz66dquFGajoy6toamWvv+VH
         5CQRbXQJ2NRiRlzosdx8K0xkgpuAjMGXTY+PmLLOG78QX/LCPpGAqj8O7h73Rjs/V5
         4yUKcSZ6Y44TQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201215100855.GA581189@xiangao.remote.csb>
References: <20201215100855.GA581189@xiangao.remote.csb>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201215100855.GA581189@xiangao.remote.csb>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.11-rc1
X-PR-Tracked-Commit-Id: d8b3df8b1048405e73558b88cba2adf29490d468
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e88bd82698af86887e33b07d48a1aec263cbeddb
Message-Id: <160809025181.9893.10836368355158236700.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 03:44:11 +0000
To:     Gao Xiang <hsiangkao@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Gao Xiang <hsiangkao@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 18:08:55 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e88bd82698af86887e33b07d48a1aec263cbeddb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
