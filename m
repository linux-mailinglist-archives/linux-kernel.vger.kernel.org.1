Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1272FAC6C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438035AbhARVRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:17:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389244AbhARVQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 16:16:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7832D22DD3;
        Mon, 18 Jan 2021 21:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611004574;
        bh=pKIiAZLNHiOky66RrIU3EKpbvGNdBhAO7yfWr6tysGg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vPBCMz05LPDGREO2Ig75Aw3wYspwfaHzg16gGttyeWXJELoT3x1/wj1kVTSDSbWmp
         oqSc4I++d7IjpQvZmc00yxz+nfGe0hpy9pRP5E/9yHt5az/VbiTNLMHO/WM9GH0WFI
         qZT/nPe4AS88DTUMC+9cH2ZGSeEEL9WcS8qGIEw6/dQ02VQW5agXu1n0bs1H39s/2o
         nAgxio5/6b42ml5dRrrRkYXxLUAgf1i1aTYCHMSzpBS0ro4p72/rxYByrE3EIxZIYK
         RJV39wIZwDCJbtOkKeKGfWuvLfAyyJgoJKv4UfqsrHB4VOW6NGnjMUV/V3vDQhYmVD
         CohYqYwgLs+Cw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 6A168602DA;
        Mon, 18 Jan 2021 21:16:14 +0000 (UTC)
Subject: Re: [GIT PULL] ia64: fix build regression
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210118113411.GM1106298@kernel.org>
References: <20210118113411.GM1106298@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210118113411.GM1106298@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2021-01-18
X-PR-Tracked-Commit-Id: 32c2bc8f2d855d4415c9a05b727e34649397bfbe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4459f4413c890a35dfcecaff29d37ac65607d76
Message-Id: <161100457442.30333.13712326819015812760.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Jan 2021 21:16:14 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 18 Jan 2021 13:34:11 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2021-01-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4459f4413c890a35dfcecaff29d37ac65607d76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
