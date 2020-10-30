Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03C62A0F80
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 21:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgJ3UbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 16:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbgJ3U3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 16:29:53 -0400
Subject: Re: [GIT PULL] arm64 fixes for -rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604089792;
        bh=pgLJ977y28RAXiGst4fDuLMTuOic1WBdBgwTBzjOeYk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=a5DSD+ki6faBzIBFP2dq7z+RYF2eQDsO3VfqNEcCI1LIyo1itaHPXvDs29wG0Ujsk
         zjyjrEkP7jEQtY6SZn9PESEICGGIaMmLimoZMb3Vi3hfE9YNHyHG/DeK62PaL17bIV
         KcGEScKvRwmXGy5yCEcpz4jGqB4B3+tqgXL/8O7E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201030170551.GA531@willie-the-truck>
References: <20201030170551.GA531@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20201030170551.GA531@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: ec9d78070de986ecf581ea204fd322af4d2477ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aab6bf505a8ea63ab3301c42d819e2e2b70cce7d
Message-Id: <160408979279.26569.3200162807591384596.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Oct 2020 20:29:52 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Oct 2020 17:05:52 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aab6bf505a8ea63ab3301c42d819e2e2b70cce7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
