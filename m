Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94ECC2CCBEB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 03:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgLCB6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 20:58:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:43812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgLCB6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 20:58:17 -0500
Subject: Re: [GIT PULL] gfs2 fixes for 5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606960656;
        bh=gXjHYn6T6l1LeJ9/l4yt8UsDjR469dSxOnc/GvwV8Pk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iAqELExPN1zwOvWGoXsbI6VAjRoFQMH0m3GVMRmJPqDfpfNu/joD4T/qE0tbN/gzp
         n1+jlkxVQV8jsQMRN3gkK/KE+sFfIXa3pali+57zCPEN4D5ImWn6x0rLJblJQxWrun
         86aHBRucMCrFQwK5YJfysLGau7HPyqfVQBTXJC/dyn3gy5S1xu5MrXoGOvP6zRoOue
         s0AzG0RFGQldPUElnD6gGAhnL15K0rmZ/6t7PeZ1VfWXpDkhsjct3IXpPqyXSqTO4+
         dy3THzoRX0ZNVC/sZ4GhhihZw5kReVH3dK3dps9N5OquFs6uPqqMcBswu/ndRUfqMu
         PyOTZO1oR21pQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201202205839.843476-1-agruenba@redhat.com>
References: <20201202205839.843476-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201202205839.843476-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.10-rc5-fixes
X-PR-Tracked-Commit-Id: dd0ecf544125639e54056d851e4887dbb94b6d2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34816d20f173a90389c8a7e641166d8ea9dce70a
Message-Id: <160696065642.25461.15012834995463992596.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Dec 2020 01:57:36 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  2 Dec 2020 21:58:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.10-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34816d20f173a90389c8a7e641166d8ea9dce70a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
