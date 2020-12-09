Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEEE2D48A3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbgLISK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:10:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbgLISK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:10:27 -0500
Subject: Re: [GIT PULL] IOMMU fix for 5.10 (-final)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607537386;
        bh=MsyqIRUCM2LjhoRDi35EkFF1ESIf2BAfUJ8bcwdw2+U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XlNQliH1vSnOaxmolsvDJ5Abo1m6Ruw8YCydrMqOY/WXyo9TWZBildmBHCFtes0sL
         LMmrVLZuUTxOZnIM0O02hLXkLCHpCYFBMu3HDRN25hXcwWYVgl1PbsgkcMC/3g+CgO
         gZGzvQnQecnV6rp8oZ21sT9Mzo5OE5k/XTCmy2JGipR3YXcHn06XpusKQgtPk1FmDH
         7MdsL/ClKNCaCUxAPfaAOBudE30DsxiNpcUHX7EQCZ9qlv3CRQrARIyq7GEiDZmhSk
         IqA5gMpRwTXAWSzThReVMuoJsL8CvqL9geU7f8uXRO4lm2mw/kWSjq7zr5MZJm+03a
         rQLPjZ6+O44Og==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201209141237.GA8092@willie-the-truck>
References: <20201209141237.GA8092@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201209141237.GA8092@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes
X-PR-Tracked-Commit-Id: 4165bf015ba9454f45beaad621d16c516d5c5afe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca4bbdaf171604841f77648a2877e2e43db69b71
Message-Id: <160753738624.9915.18144343532450407181.pr-tracker-bot@kernel.org>
Date:   Wed, 09 Dec 2020 18:09:46 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 9 Dec 2020 14:12:38 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca4bbdaf171604841f77648a2877e2e43db69b71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
