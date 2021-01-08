Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D3D2EFAF6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbhAHWQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:16:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbhAHWQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:16:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 966BC23AA7;
        Fri,  8 Jan 2021 22:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610144165;
        bh=wOSE91rY9tM/lfgQ0xqZsC7VHrIKNLSiJAqLNgpQPwI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T6ZBWO/aRmSEpBRTUPh49P9VXRnRMIJYNbD/n4E/veLLICnA7PJuK7gGfofbCpdiX
         GmpxskSdFZZ5ddIJkul8hwURZht2igmXOEpfBSigiIS8XrT3soOn0lSH/rHPAnU2s/
         MeBEN/4luSsY5pwNr9+Heo81yXd2Ex5h9koL+Cgquhrr0CkIlNoPOVcTn2UhmJWRw7
         Wne9S9fOwCWWY2B/UuEiw0Lm8VMSVMM9SduhRLlVd8zdug5WbIPsx+ZMeH9iM3dzEP
         Lsin/QnjcDaVt2y5QOQV7ZKk9j7aUNlLsHSvOAbNphOfnwCR5vzG8tXa2gwlVP55d9
         XrTv5ghzAS8Bw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 8789C60597;
        Fri,  8 Jan 2021 22:16:05 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.11-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210108163343.GA18635@gaia>
References: <20210108163343.GA18635@gaia>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20210108163343.GA18635@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 83b5bd628f65e6b4d1924b307d6a88a57827bdb0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56ef24e53ec1660bf095779cc95fa574dd0f71df
Message-Id: <161014416548.31342.15026554864632314912.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Jan 2021 22:16:05 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Jan 2021 16:33:45 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56ef24e53ec1660bf095779cc95fa574dd0f71df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
