Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DA12E1029
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 23:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgLVWZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 17:25:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgLVWZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 17:25:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4938323103;
        Tue, 22 Dec 2020 22:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608675861;
        bh=kW0JXLvBKhdsWzU3y7QVqr3L5AXy0WeZwxVxoFJECKI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KjHO5mF0wtdPjNvKUwU+eTC7F1DMVUffazOaLzoHKv3zxMm1OmMXmZngmXgRL4pjB
         tzCjYlQdCL4bEX9co62Ta1lgbaTjwiiiCRAF9eQkm1fe8ooGR8kgIPspTuvILn7jYL
         RxIyUrXKZYLblWSZKy/gNcYDCGphvl0aSOT16O5TAsaDUc/MZdNqHG/fNwtqG22457
         em6r0iLaw6E5u44axdmmKTPdUZcq0aiUYtE1n4XcK1NR+BlFm39JXHfGheJTGJHczU
         rqAr+1hkXpUAh7CHajFkuqopR14cbsaKmsRbF8t42yUFalBwo7WeMLyTuaCFYNWC10
         fX6/m9jEG1Miw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 3F21060113;
        Tue, 22 Dec 2020 22:24:21 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for 5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201222160112.GA3019603@infradead.org>
References: <20201222160112.GA3019603@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20201222160112.GA3019603@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.11
X-PR-Tracked-Commit-Id: 7679325702c90aecd393cd7cde685576c14489c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 347d81b68b8f7044c9ce3fefa130a736ca916176
Message-Id: <160867586125.8550.11731307102280818177.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Dec 2020 22:24:21 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 22 Dec 2020 17:01:12 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/347d81b68b8f7044c9ce3fefa130a736ca916176

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
