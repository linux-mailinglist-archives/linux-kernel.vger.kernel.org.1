Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD8728BFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391350AbgJLSW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:22:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390870AbgJLSVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:21:04 -0400
Subject: Re: [GIT PULL] arm64 updates for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602526863;
        bh=gDNztffAqtcvn15FSUFK6x78G55FaLOCDSvJZMSp6bw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1UxVXeM/Q1x47u51G9F143ozTXzmuHTu86jIzH4J9oLg2qRq3/J0N1psG+2bs+rRN
         Aw52M2KYYmS154Yw+/CyxlDIugxzAIh3yCRJBK5BW594aVxvexl1j/3NDnlnsKieLZ
         JDTz/NT4GJAoUdY7uhJFAgBlasmuWa73tF4AVgy8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201009141616.GA30637@willie-the-truck>
References: <20201009141616.GA30637@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201009141616.GA30637@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream
X-PR-Tracked-Commit-Id: d13027bb35e089bc1bb9f19c4976decf32a09b97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6734e20e39207556e17d72b5c4950d8f3a4f2de2
Message-Id: <160252686377.3643.17232048986425188129.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 18:21:03 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Oct 2020 15:16:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6734e20e39207556e17d72b5c4950d8f3a4f2de2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
