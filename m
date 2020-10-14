Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B7628E725
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390423AbgJNTSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389369AbgJNTSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:18:15 -0400
Subject: Re: [git pull] IOMMU Updates for Linux v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602703094;
        bh=CeJQJA6+jJU1Q8IK7BcXIkzwp0K6ByI6ZQq+kFkobS4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EUcsM0cu0KcdUyUhtqzfBWtbAzxCQU0j0DPEoRcE5KMwS9JOm9mFdDId/QjscHIbt
         kB70VR26d+rtrQhaqfMWyz+7OtAarEsoIC6r/Y09qoT9+v7qA2xhoE9fpMDCRpOUgF
         0FuB+DMtQ1e4vt8afxtWXjjaZSo3MXiELEoB44v0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201013160353.GA19438@8bytes.org>
References: <20201013160353.GA19438@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201013160353.GA19438@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.10
X-PR-Tracked-Commit-Id: 7e3c3883c381aeda903778d7e99fc4cd523be610
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 531d29b0b674036347a04c08c0898ff1aa522180
Message-Id: <160270309490.18367.15785316135185550226.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 19:18:14 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Oct 2020 18:03:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/531d29b0b674036347a04c08c0898ff1aa522180

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
