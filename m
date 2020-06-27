Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91CF20C409
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jun 2020 22:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgF0UZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jun 2020 16:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgF0UZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 16:25:13 -0400
Subject: Re: [GIT PULL] dma-mapping fixes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593289513;
        bh=9J040E0WnnbQGma5xN3YBHaW/r21PdJwI/TPcLGUJ0k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EasVfYhXqGsLNA/0DLHWXBkODWqVUoRomVJK3r61hPPMbNxBlLF/J6YrljHyc0cWm
         gofyPVLAFXvKmELbnHZmTKRxovKAgICDCfY/beCVnQyxUcLrCMKbjXhpqXg1Fc98en
         6xgtwDd4DvuK3oDHZZtw/O4+xoLdq8b45ZrA0r6E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200627074902.GA2447682@infradead.org>
References: <20200627074902.GA2447682@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200627074902.GA2447682@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.8-4
X-PR-Tracked-Commit-Id: 8e36baf97b252cdcafa53589e8227cbb1e85f0b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f05baa066d0f6a38f0624c28008fb2f53cd00e17
Message-Id: <159328951331.11719.13949831114777019739.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jun 2020 20:25:13 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Jun 2020 09:49:02 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f05baa066d0f6a38f0624c28008fb2f53cd00e17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
