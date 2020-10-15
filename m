Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74A728FB12
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 00:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbgJOWT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 18:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731589AbgJOWTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 18:19:25 -0400
Subject: Re: [GIT PULL] dma-mapping updates for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602800365;
        bh=jUQ66Abb2Cqv517bRYUaJgK1Ar/plmVQdBiGTSpFQnE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=n12tT5nj2eWdrcYFLRRlWe8O6kDp9f1/pvamhLXqdmyOCRVcw60T50O0jZ+3gANtm
         iKmiGt+su3LfkI0hZbNTY/kQS2CTE1ZdAScCPaKF8O2GMdA2DSmYU1pVbhMWtlRFJt
         YNrLAbVhBp5mwxbVaXmpQrReLrP0Q/skbPLzucZA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201015174743.GA2648490@infradead.org>
References: <20201015174743.GA2648490@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20201015174743.GA2648490@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.10
X-PR-Tracked-Commit-Id: 2a410d09417b5344ab1f3cf001ac73a1daf8dcce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a32c3413d3340f90c82c84b375ad4b335a59f28
Message-Id: <160280036534.16623.3771479441636667328.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Oct 2020 22:19:25 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Oct 2020 19:47:43 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a32c3413d3340f90c82c84b375ad4b335a59f28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
