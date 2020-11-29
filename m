Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AB22C7B11
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 21:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgK2UGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 15:06:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgK2UGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 15:06:47 -0500
Subject: Re: [GIT PULL] x86/urgent for v5.10-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606680367;
        bh=ox5ffII8Xm8X4I2VZR39kPxJPahtv9v1e9sFFilp9f8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PS/tx/9BVGCekK2f7/iQC2cB5/NYjwePRcH9U8qFcouEWqqTFHXeA/9wFP156mFpf
         kwhuwTqZxrfJqDxKijy10fkE2OCqU7w52T7fxe0jK+YQbHSvh0VUBxFkeTcD/eeHYG
         aG812B483GSgXQX3zWcvrzWrFtY/S6Rai9WqyQjE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201129103844.GA12056@zn.tnic>
References: <20201129103844.GA12056@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201129103844.GA12056@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.10-rc6
X-PR-Tracked-Commit-Id: 25bc65d8ddfc17cc1d7a45bd48e9bdc0e729ced3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7255a39d24a7960da3a55e840ca5cbed5fcb476f
Message-Id: <160668036748.1296.8140752772921848847.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Nov 2020 20:06:07 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Nov 2020 11:38:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7255a39d24a7960da3a55e840ca5cbed5fcb476f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
