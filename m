Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF67300F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbhAVWBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:01:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730517AbhAVWBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:01:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A952B23B06;
        Fri, 22 Jan 2021 22:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611352835;
        bh=g6ESMx4x8AtvvLcOfRZyHBVVHUQEpRSoNXbCvw9wG1s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=frUgNm9UY0berZKUkjWQds5U54jjxIQA0t+cLwkAaTE62jwotzExYqegXOHgv3EhM
         h1UcSYeLs+fJu/NSKpNWoab4TniNfaHO5rwwIhrvgtJkTl3hsTja3rU5U7W3/v1iON
         BOwiJs7NWW6/Ut8PpnfFsM4YGXg4T7tGJV3cbXwX0OI+EEkhIEXa1GmvsFfbi9/ybr
         5U0rj/ozl920sCa4Jdz3vt0jrTi5Cltbqdqq9krgrEf1CO4QiKJWNoicFDx14SpHGe
         /QWmI5vus7YvnmDwX1c4rObnGmKgLoGXPPv1SzDb6QNAve2PcXj9KoYwlQdi1Her9P
         SUXBIrr4rSVyw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9229D652D0;
        Fri, 22 Jan 2021 22:00:35 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210122190719.GA29705@gaia>
References: <20210122190719.GA29705@gaia>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20210122190719.GA29705@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 75bd4bff300b3c5252d4a0e7a959569c62d1dbae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c304c77f7cfc92572cd45cbf045ac2443423ea1
Message-Id: <161135283550.4174.8851261574070735271.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Jan 2021 22:00:35 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Jan 2021 19:07:21 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c304c77f7cfc92572cd45cbf045ac2443423ea1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
