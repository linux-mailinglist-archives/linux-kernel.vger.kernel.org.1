Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A5E2D8991
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 20:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439820AbgLLTCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 14:02:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407786AbgLLTBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 14:01:51 -0500
Subject: Re: [GIT PULL] xen: branch for v5.10-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607799671;
        bh=/z4e4OBG9dX34wwm48LbjXS2Jefc/mywFk+XdssA/Ws=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=COim9VWaDQNCkRwjVETWa6JIi88ouDhkK0sLAqw9k4SxZaJfC2DbE5z+3tpvY6nje
         lx7hjbWu8CYxXnQcYFpwHXNkgZwDiqGqYHJBPNB8Eq37+8o/v3FJhIDtemKO1CWbGJ
         3P31QoluUQ9XWyuDs/Y2edDVkxF+AgmA6eiuIQB3CCaqbLZ5NMyAgxc1/QZU+9+2eJ
         6EAbcFJ/4VOL9hM8xUswWWQSsi1lyVhWLaVJFFLf2SSaVPmtetKeKXOU0yir8VJDMo
         RTV2YvVAT/rHM8wy9U0UaXgzwqkNzuSiL7HtitZjH6soF3ZftZNvk/IDcesuCn/z9s
         kLziimxS04E+Q==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201211085309.8128-1-jgross@suse.com>
References: <20201211085309.8128-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20201211085309.8128-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.10c-rc8-tag
X-PR-Tracked-Commit-Id: ee32f32335e8c7f6154bf397f4ac9b6175b488a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b53966ffd4c0676c02987d4fc33b99bdfc548cf0
Message-Id: <160779967131.16081.10288142971358980370.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Dec 2020 19:01:11 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Dec 2020 09:53:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.10c-rc8-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b53966ffd4c0676c02987d4fc33b99bdfc548cf0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
