Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436D4270488
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIRTEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgIRTEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:04:14 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.9-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600455854;
        bh=ENzdNrr6Yxov2Bq4jXUL6Wo6Vtn0e8D2Uu4poYfo59Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KDqRm34Z2uFXVYGIG2bdFP3UNv4TFwH+CGAq67wfqdTtRNM1ID9TiUiNgPTfDQOm9
         2r37+N6alFdjvnZ9C69UJdvoXO/CMGn0q8Y1C7R+EtXDVA2DqenNivLBSZoz9wL36a
         6JgYpzJnLTGkSJJu0b+6g88i94vDVyaMksPa1rpg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200918151051.GA31007@8bytes.org>
References: <20200918151051.GA31007@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20200918151051.GA31007@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.9-rc5
X-PR-Tracked-Commit-Id: e97685abd5d711c885053d4949178f7ab9acbaef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fd79656f7d59b2ccfc8d7ec8136db60d21f1e0a
Message-Id: <160045585430.18461.16309137272287318103.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Sep 2020 19:04:14 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Sep 2020 17:10:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fd79656f7d59b2ccfc8d7ec8136db60d21f1e0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
