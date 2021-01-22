Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1962B2FFA97
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 03:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbhAVCmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 21:42:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbhAVCmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 21:42:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D940723136;
        Fri, 22 Jan 2021 02:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611283299;
        bh=9Zi26Umn4bfBl+qlAcYkpuei7dW6gvAbqBK7e0VzGY4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XpA6id9nBiOlHVISxyGgtDGRx5eQsZj/ypIA9pAzz9Q2pkdxzaY6OgWcrYZE7PQrN
         L1l9pSV3uDxhnY6USU9BEmSn4HU+wrJMCn28VvY2p++Q5aVeVHFwfsjDA38YTjXK0B
         sUCRA0Bk4zAPMhVlEJLk9D8Whfei6c1eJ/FhJhQg5e/tf841tQvu/XoAKHfDxVtBHH
         JWGq8k8/VOhE7k7NQEe1r0ZksKpE9Kzsxlkxnhnu26XkknWucgpueF0NBIWJ61olcQ
         ueWPXw5JkCpEcJgFC+El0nUd7goBejdxgwQPlswzhzW+QkbyvG+3jyT0s81+BUHRrz
         OkPJgWEcLc4+w==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id C6DD760591;
        Fri, 22 Jan 2021 02:41:39 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC fixes for 5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210122002902.GP2002709@lianli.shorne-pla.net>
References: <20210122002902.GP2002709@lianli.shorne-pla.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210122002902.GP2002709@lianli.shorne-pla.net>
X-PR-Tracked-Remote: git://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 031c7a8cd6fc565e90320bf08f22ee6e70f9d969
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83d09ad4b950651a95d37697f1493c00d888d0db
Message-Id: <161128329974.9480.4436451757364424272.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Jan 2021 02:41:39 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Jan 2021 09:29:02 +0900:

> git://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83d09ad4b950651a95d37697f1493c00d888d0db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
