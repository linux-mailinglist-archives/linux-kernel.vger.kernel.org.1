Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A39123C2E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 03:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgHEBFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 21:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbgHEBFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 21:05:08 -0400
Subject: Re: [GIT PULL] dma-mapping updates for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596589508;
        bh=V8SyMJUhTk121eZYzAmhMw82jobWxaHTOhXR1PgnYnE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0xo/kexh69Mx1o1AXt7z9fqmSfKd++oqctX1Lzm/2CvXBpnVEyQR2c5H17/+FQvuR
         GqskXQ6MnPlLaebzPqSFOofnXsD8ENW7BDhkrF4zrga4SS6kU+x7cXIQG53PSXNY5z
         hOcqfPLzrd183MhG1/VHEQjKTOHs1kWlcLZgqJ3o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803141547.GA752173@infradead.org>
References: <20200803141547.GA752173@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803141547.GA752173@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.9
X-PR-Tracked-Commit-Id: 274b3f7bf34415eed106e479e4815e897ce5d763
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ed90dbbf7be3b7cd2790fc6fa946c478ab496b8
Message-Id: <159658950828.28431.11011770511224592315.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 01:05:08 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 16:15:47 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ed90dbbf7be3b7cd2790fc6fa946c478ab496b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
