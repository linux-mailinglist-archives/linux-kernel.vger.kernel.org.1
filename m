Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB6D2DB9C7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 04:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgLPDpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 22:45:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgLPDpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:45:30 -0500
Subject: Re: [GIT PULL] close_range()/openat2() v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608090252;
        bh=UQo0NNeI2jMVyNratqOhx25qKc8P4IVQI/a9HvewOmQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MO+H5wp/ulMWGD1wKZfrZ3xnmsw533se4yS/wpGas5CZ8LFk3iebHDE+pd1BEPjzN
         +hAKrZpNSS/1aovMeiR27BW+6A3jYf23kQUb0JxTCfO0H/FPwzQs/hvC60U9Rldhh3
         G6VL/zbzt/vqUSquscuau2IwIilhYbZJkhqmCBZVIC10/dWD5ZyibD4IG0qtYr2VCE
         ow7QBJh/8JfCBZJlOqYXWf4MVNzfP1Rw6P50QNuPlH6LDZyeGhnai9rTF9H2LFJQOJ
         8h1X4rkDGrEILCeFc07d5bXcbZw9tE9KbW+bvB1I+K2tLp7fOiKe4NP0Ra9PqmSIn8
         pNSrvfblW6YHQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201215153125.199021-1-christian.brauner@ubuntu.com>
References: <20201215153125.199021-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201215153125.199021-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/close-range-openat2-v5.11
X-PR-Tracked-Commit-Id: 23afeaeff3d985b07abf2c76fd12b8c548da8367
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 345d4ab5e0a226e0e27219bef9ad150504666b0d
Message-Id: <160809025224.9893.17257871794437088461.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 03:44:12 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 16:31:25 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/close-range-openat2-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/345d4ab5e0a226e0e27219bef9ad150504666b0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
