Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101072A1A56
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 20:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgJaTxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 15:53:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbgJaTxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 15:53:54 -0400
Subject: Re: [GIT PULL] dma-mapping fix for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604174034;
        bh=viwE+r2ezqayH37udQUFt9+Rvq68jOQmPS7y1ziw3n0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nZCrgG6UAmfVoyJ8F0dzDpn0LyUMdOh9i5pYHlikaR3UqVPIt3pmzYNNzjuK2Hd0Q
         EtiQW8GB8dh4d1OHXRIn7LNLL0CbjxZkwi2hwoGc3nViLkazoFOtxyOxUOiumI1LtL
         l8K0jUPQ0OPUEItWeUhY5URYeGD6ascm0AnngC5w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201031093823.GA453843@infradead.org>
References: <20201031093823.GA453843@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201031093823.GA453843@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.10-2
X-PR-Tracked-Commit-Id: 48ab6d5d1f096d6fac5b59f94af0aa394115a001
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb3540be73ca1e483aa977d859960895fe85372d
Message-Id: <160417403443.21727.3065273541120028592.pr-tracker-bot@kernel.org>
Date:   Sat, 31 Oct 2020 19:53:54 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 31 Oct 2020 10:38:23 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb3540be73ca1e483aa977d859960895fe85372d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
