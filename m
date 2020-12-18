Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B0B2DE99D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 20:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbgLRTL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 14:11:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbgLRTL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 14:11:27 -0500
Subject: Re: [GIT PULL] Second set of arm64 updates for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608318646;
        bh=sCbJw+Nss/gHSdDTXDRtaAKmTYocFnQYClg3Ky73LF0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZfhgBPsAcE8OyOVvkPfgxNOU84GL32CFrb/MxJLPEkWJnTnBStrO9WXt881VgC637
         B67FFCa4AoGfVP05q3cINqLh7tB8vJXQv7i30e8fiTrIYtlAdOGgdVxteGOcIWbAxo
         NrXTzImc0ygNIXENF6SnbtRgG3UlxEttYvLZUi2GYsW2Ao4kre374hjLQTycx7Sy1K
         l0IZHZwh0x/gt+ColNy/OEleHEw5eRWYbxCR6WyrKPA6VvUzAKl536e2kCsXKAjdWW
         RpDuP4hGTnKtxmNCA2I4IH0+5DYOexUyJcHGfmel6cseiQVP5PayOCmsCpYFZ0e5UB
         XgdEqitRMCSSw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201218181713.GA13068@gaia>
References: <20201218181713.GA13068@gaia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201218181713.GA13068@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 9fd339a45be5c06e239d45a042eab9d25de87882
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ba836eb9fdb07843cfa004e511f333745adb76e
Message-Id: <160831864662.5982.11971277995011086429.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Dec 2020 19:10:46 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Dec 2020 18:17:17 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ba836eb9fdb07843cfa004e511f333745adb76e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
