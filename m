Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD391D5A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 22:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgEOUAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 16:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgEOUAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:00:04 -0400
Subject: Re: [GIT PULL] arm64 fixes for 5.7-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589572803;
        bh=J2hQQdonB1mfSuob5lmfj7Jr07cc9xJKDDPV1suGu1Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MChrpSSy+AAalNqZ1sLNbQERfkKAX+/nL8xHhx/WnmbsOfcAJL3H15XcnHtVpmkkI
         sZs8XFGjaX8+wQHtc9v0ECAzBHzkyV5Q2VK25f/E0NvwZw3+Ff4t3nvmvr5+BzYi4u
         kbsA65OsQsx7ygAqnTHmLaB6kYGHr4AHtZRlnl+I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200515172443.GA1749@gaia>
References: <20200515172443.GA1749@gaia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200515172443.GA1749@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: d51c214541c5154dda3037289ee895ea3ded5ebd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01d8a7480304a2f0e196459eb4061e171d9e9922
Message-Id: <158957280369.8762.11385200558117584905.pr-tracker-bot@kernel.org>
Date:   Fri, 15 May 2020 20:00:03 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hch@lst.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 May 2020 18:24:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01d8a7480304a2f0e196459eb4061e171d9e9922

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
