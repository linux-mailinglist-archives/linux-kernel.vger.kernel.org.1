Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C8B256A59
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 23:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgH2VYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 17:24:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbgH2VYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 17:24:32 -0400
Subject: Re: [GIT PULL] fallthrough fixes for 5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598736272;
        bh=oJohxNXjU/ybdfp9MpGbdBopnsE/npgE+8Tv6Uy+ahM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=B17d9enzJF2k8pBXmYq9XTaHDfXhTwS681H+LW5EzeD4PEp1gYXYvGFu1mN39nmLO
         qt9SACC1xR6oPX4U5t/ttII+Y/NR39UP5wufP6QL3e9OLA0YMbPEQXJsVN7RkvLN/N
         QZH6h/9ZVSBCMahyHLBPdNKuds7nrfcY0J2u6nbE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200829173702.GA22301@embeddedor>
References: <20200829173702.GA22301@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200829173702.GA22301@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-5.9-rc3
X-PR-Tracked-Commit-Id: c165a08d2b2857c91c627039c4881f9d7ad1a3bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1127b219ce9481c84edad9711626d856127d5e51
Message-Id: <159873627246.5962.7593439975044093985.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Aug 2020 21:24:32 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Aug 2020 12:37:02 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-5.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1127b219ce9481c84edad9711626d856127d5e51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
