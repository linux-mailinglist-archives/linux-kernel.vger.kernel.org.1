Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3500297E35
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 21:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764102AbgJXThV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 15:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764095AbgJXThV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 15:37:21 -0400
Subject: Re: [GIT PULL] dma-mapping fixes for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603568241;
        bh=nNMvH4+UmBjeC/7DRNagbhqqIqRv/Uo4MYVju0/JHfQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ewdkq1HH2dTj8++IfW5Ofp6sezrJrlQL5wPtQjY3o1ctljjFIj9M9dq29FHi9USm9
         Tq81aXMzbvdwe7fnr+cbPNeY5Efo/XcR0ZoT4DIq7VrMHSlpPknD3GEoyP7XQgMs+Y
         Kj2tGPxJ5uwxibuUCZpTASa9g6Z2nA2WQ7hLvpkA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201024141935.GA3556641@infradead.org>
References: <20201024141935.GA3556641@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20201024141935.GA3556641@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.10-1
X-PR-Tracked-Commit-Id: 6857a5ebaabc5b9d989872700b4b71dd2a6d6453
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b307ac87075c3207c345822ea276fe4f28481d7
Message-Id: <160356824105.4617.8041494852223115716.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Oct 2020 19:37:21 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 24 Oct 2020 16:19:35 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b307ac87075c3207c345822ea276fe4f28481d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
