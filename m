Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB88280878
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733056AbgJAU2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgJAU2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:28:10 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.9-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601584090;
        bh=Vx/mDwecDTVqctCYUHEFyLcErqa/NIaIFmAxxuYtrC8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2V0hgdrR9SX2mTQU125VYTfgvDVu8qUVOgkcHwhFC+aCCuAqIJJTqe4bGAb00WRai
         0sqnwhPceNkd64SAzwAI92ZPlpVJqss8GdFauRMEjJcXtSXKAm/RINrM4KxJPH0IKV
         O8gcHozZuIEGH6J71FFjXSroYTw9P/jukccStpbs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201001185024.GA3327@8bytes.org>
References: <20201001185024.GA3327@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20201001185024.GA3327@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.9-rc7
X-PR-Tracked-Commit-Id: 1a3f2fd7fc4e8f24510830e265de2ffb8e3300d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44b6e23be32be4470b1b8bf27380c2e9cca98e2b
Message-Id: <160158409032.27596.5069528873491259512.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Oct 2020 20:28:10 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 1 Oct 2020 20:50:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.9-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44b6e23be32be4470b1b8bf27380c2e9cca98e2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
