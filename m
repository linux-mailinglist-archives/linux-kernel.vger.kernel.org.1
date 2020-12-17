Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C821E2DD9C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 21:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgLQUVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 15:21:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:32808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgLQUVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:21:51 -0500
Subject: Re: [GIT PULL] f2fs update for 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608236471;
        bh=gESy059H5zo599KfZtdX82108W6FYXeU8i7d/GYKQ70=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JQgj10TQsm7/Apkr/UnzJHa/Y7PXLT4TvlLvRTzIKs0SSxAVRdkF5k/ZMWJTnTKw5
         CIadWh+U+FzR0YSUGCMXOdKcG8sNBuo1lWMAXNPn8fHT9uh3lZDltDjin97xzGMkWH
         iKcPclz/GDbQ+4tgRNd3nfTMueskE8s6kCMG4OQftZXDJQDreioNFtfm8upqLNYj7M
         TsPayfiGEvAo4YZwXBoDIEX1V2isaPa5vjsRkxY1w97xlrb+g1RPyelJraU6VtN84F
         /nNVzcKLl/dken21/icbR5vyuT/xOEDAc8acqjfdhuAJgzH0a29X7bs4qyzkR0v3tT
         L6xXvFE11yOwQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X9rz/haGgEG0pmMa@google.com>
References: <X9rz/haGgEG0pmMa@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X9rz/haGgEG0pmMa@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.11-rc1
X-PR-Tracked-Commit-Id: 75e91c888989cf2df5c78b251b07de1f5052e30e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff49c86f27e4726a86f5034543e6e684daf41955
Message-Id: <160823647128.7820.10554161551821543774.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Dec 2020 20:21:11 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 16 Dec 2020 22:00:30 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff49c86f27e4726a86f5034543e6e684daf41955

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
