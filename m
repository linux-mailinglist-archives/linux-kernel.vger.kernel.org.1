Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D8223C1E5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 00:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgHDWZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 18:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbgHDWZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 18:25:09 -0400
Subject: Re: [GIT PULL] checkpoint/restore changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596579909;
        bh=hNrjf1LKvb17Agedby0qd9gm06H8vqIB8yka+1APpHE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NNrPbp0sMFB/mtgEXG4ZRod8g1PZVmtxETKqjw/l8QzKlwK+K2Ed9PHZ74dQGb6Tf
         S7Z38qwD6Vc1QIIq7wrGsFxxzQzhpKRlQI7Ba8CWNEiItAu1sbu5hCumyU9xxK9Ip6
         DIBDgoSpUiKMJyMRMWRLB07hVpzXTwOg89Tp7vH4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200804113202.72667-1-christian.brauner@ubuntu.com>
References: <20200804113202.72667-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200804113202.72667-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/cap-checkpoint-restore-v5.9
X-PR-Tracked-Commit-Id: 1d27a0be16d6c95fd71deef34e94b40cb4411cc9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74858abbb1032222f922487fd1a24513bbed80f9
Message-Id: <159657990925.8406.13977729422742403466.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 22:25:09 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  4 Aug 2020 13:32:02 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/cap-checkpoint-restore-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74858abbb1032222f922487fd1a24513bbed80f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
