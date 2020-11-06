Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5EF2A9EF3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgKFVO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:14:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbgKFVNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:13:25 -0500
Subject: Re: [git pull] IOMMU Fixes for Linux v5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604697205;
        bh=5cKkHA45t/SLEE2IkJBajbrClJ/7j/9wbW6DCSjB73M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fthJfn7SaUkgmGr0fMljmEbInWGwApLCFkSBg1PHxEGpyXVfc0ea7bJVVkRVey9pi
         ctjf/yJoBCAfSdRjqSLqROewZEXR09/VIMf8BsqQf0QP4C5jVWidj+h42fItvjY4Ay
         rh9JCAwxLgFKDrJxNAhegpsiHalEuQ7U3N8lhzqQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201106162302.GA3084@8bytes.org>
References: <20201106162302.GA3084@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201106162302.GA3084@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.10-rc2
X-PR-Tracked-Commit-Id: 4dd6ce478003525df8618750d30f0b90380047a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02a2aa3500a993c9f0812b8564d36d63b8d49ce4
Message-Id: <160469720523.14190.4464532018621557998.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Nov 2020 21:13:25 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Nov 2020 17:23:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02a2aa3500a993c9f0812b8564d36d63b8d49ce4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
