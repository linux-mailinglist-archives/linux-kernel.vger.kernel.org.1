Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BF41C2E84
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 20:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgECSfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 14:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728863AbgECSfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 14:35:07 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588530907;
        bh=DG8ptTP/CPkgT4xTXP2BJxu9eBcErQVTmEzrRxKDUZc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XO/d592drAmPwCblB4J1Ov6rIyiJgQCvtywNdYw0h6HxnsFtrVm3coRamKscGOPCK
         PfguK91nw2E7mqiDnN3i9LeGxLFJjqY5CX8T/3bs5C7NZxnkBUowClKNPsK6uDhquu
         LcBzoEOSuvCz0babN8eYamdBFQPLDv0d/1XiFxlk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200503121929.GA10425@8bytes.org>
References: <20200503121929.GA10425@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200503121929.GA10425@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.7-rc3
X-PR-Tracked-Commit-Id: b52649aee6243ea661905bdc5fbe28cc5f6dec76
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea91593350ecb9d739c413d9213db9db08297108
Message-Id: <158853090751.15713.12435988349132997875.pr-tracker-bot@kernel.org>
Date:   Sun, 03 May 2020 18:35:07 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 3 May 2020 14:19:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea91593350ecb9d739c413d9213db9db08297108

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
