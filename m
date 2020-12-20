Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB36C2DF696
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 19:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbgLTSxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 13:53:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:34830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgLTSxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 13:53:47 -0500
Subject: Re: [GIT PULL] GFS2 changes for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608490387;
        bh=zi6NEYowNyGT1b6P2fpVMU1/PIvFQVuFgugELvM69+g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gk3IiDYmAB3eaXpA8ZtpKUHGYwOP5RnnGifPAvye9OJjsBj+srmP3RA0HOd06p6iW
         zE5WVIoZ9ziz5Jr7uNT0fOR/Ly3HTWEr672PlpciyqjFl//EAUmlEs44fbhxczJlPo
         X7FwiAok/dyW+2eo5JE3ezvm7B5E5qR7NQtlPW8uhlDgRbXUbAwLcPTZii1uNLXvO0
         IGse0Hc4wOJRTWP114Vv7aBlZJI/JNhgmfb84vN4cO07RkuCFebhnlPuxzZ+HYzcPL
         VrjtALgW+d4qUOs2bwTZ13Q3uescV/VSlLFGRYVXMK0vd1Ks9cVGZDQAkYMnAaLsQw
         mb1M4k94aSMSQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201219211127.287454-1-agruenba@redhat.com>
References: <20201219211127.287454-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201219211127.287454-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.11
X-PR-Tracked-Commit-Id: 6e5c4ea37a99e5b97aba227fc43f3682d4bc0496
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7703f46f2cafa57b9e5e8f4d6ff3dd8dcf0c1656
Message-Id: <160849038724.26331.16671651916130696802.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Dec 2020 18:53:07 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Dec 2020 22:11:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7703f46f2cafa57b9e5e8f4d6ff3dd8dcf0c1656

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
