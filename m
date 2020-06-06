Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F561F0844
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 21:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgFFTPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jun 2020 15:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbgFFTPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 15:15:18 -0400
Subject: Re: [GIT PULL] dma-mapping updates for 5.8, part 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591470918;
        bh=VRwezrwpQMvbb3BQiQdBcNFteObyDGAcxsXAXlCuYVo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=p+RyqFQl6RcJ2C6Jxr0GZUyxOQhPVjrFqSish2/NsMQsNdnrcqz4ba3jcx/phYUNQ
         VyZo7HkkFskIWIhZKzExtHAHyWQeD/iFYhIJte+gLS6HD5yWVPYAEINc46k8e6TV1j
         pyu3m+AaYBzvZWkDAECQk4yu8ssMWdZusSdU2N6U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200606160657.GA3482728@infradead.org>
References: <20200606160657.GA3482728@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200606160657.GA3482728@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.8
X-PR-Tracked-Commit-Id: 298f3db6ee690259927b105d5ad1079563361323
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ee18de92927f37e6948d5a6fc73cbf89f806905
Message-Id: <159147091841.3313.2281337702762277498.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Jun 2020 19:15:18 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Jun 2020 18:06:57 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ee18de92927f37e6948d5a6fc73cbf89f806905

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
