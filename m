Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E5D2940C1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 18:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394825AbgJTQqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 12:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733221AbgJTQqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 12:46:04 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux since iommu-updates-v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603212364;
        bh=xg+oRsnPfUU6aXZECsaUkYM5mm8ivkatSd5ywRmNj1o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LcFX2hl9XzLfQqG3iOLFmNW96G4uOwD3iyHJ3CD9LY1msNb9aY707J3q6vBuVHJgm
         BcIuqiunxVXN2j1OjbWW7u4+8ilGStGUDobGRjun0FDOFVhXGN+sE6AU+pS2o5ueXB
         prs7pf/TFsr0vWdBWcfFIvDwKbAtlGWvfqdQPCRs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201019154418.GA25261@8bytes.org>
References: <20201019154418.GA25261@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201019154418.GA25261@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.10
X-PR-Tracked-Commit-Id: 9def3b1a07c41e21c68a0eb353e3e569fdd1d2b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c7e3f3f5cbc31118914ceee969154582ad3aa6b
Message-Id: <160321236432.11581.15305611521366285712.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Oct 2020 16:46:04 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 19 Oct 2020 17:44:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c7e3f3f5cbc31118914ceee969154582ad3aa6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
