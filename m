Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEEA20B96C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 21:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgFZTkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 15:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgFZTkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:40:14 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.8-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593200413;
        bh=sumYEiYj4agMZCjapVLL0DEwnnKEekY+2rshZJfFCB0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hsSiGlPiREJWygTLSYSanI3tlSUPDi2fEj7B58UhiVj90BcKg2bY+CkxD28RXAHmb
         EsSP/WiITGDBeMxoo1pm85nGrmAEauCPugT510kKDmIwt7YLDcxcs0N5vf/fEQpp2B
         zZx/2dy4Sd1YDAOO+Wdw0TEAAkjpMAxXtCg7CcfM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200626144655.GA20234@8bytes.org>
References: <20200626144655.GA20234@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200626144655.GA20234@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.8-rc2
X-PR-Tracked-Commit-Id: 48f0bcfb7aad2c6eb4c1e66476b58475aa14393e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd37cdf8ba1b56a968173560314398d5d3b2d37a
Message-Id: <159320041384.11855.1244021860580748750.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jun 2020 19:40:13 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Jun 2020 16:47:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd37cdf8ba1b56a968173560314398d5d3b2d37a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
