Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A99E23E5EA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 04:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHGCj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 22:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgHGCj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 22:39:28 -0400
Subject: Re: [GIT PULL] erofs fixes for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596767968;
        bh=klkVfP88rtLpfevFfFMGfw20TED7XGDbc1+skecj4Ck=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1sUWz7jFwLfI2MK7tPWs87D5q5W9gCbMXwuZHjK1BRXMk+9VEfUYr8FNGlhRHer4e
         I+7EZvBYop6pKuqDiwr71XNQVwzizO43v873a6qmwMFy2Vqpk70Ig0zqkeUS+KdHSj
         1U9P0xNquHaOitF1CyqFp14tbN/hP4/xaP7rWQkY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200806032017.GA4442@xiangao.remote.csb>
References: <20200806032017.GA4442@xiangao.remote.csb>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200806032017.GA4442@xiangao.remote.csb>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.9-rc1
X-PR-Tracked-Commit-Id: 0e62ea33ac12ebde876b67eca113630805191a66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 019c407c1dfb81c37036323597e18cce73c84122
Message-Id: <159676796820.23087.18283400571453619730.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 02:39:28 +0000
To:     Gao Xiang <hsiangkao@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Gao Xiang <hsiangkao@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Aug 2020 11:20:17 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/019c407c1dfb81c37036323597e18cce73c84122

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
