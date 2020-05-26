Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288001C2201
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 02:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgEBAkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 20:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbgEBAkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 20:40:07 -0400
Subject: Re: [GIT PULL] arm64 fixes for 5.7-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588380006;
        bh=keiy/L2cGLzzlwDBTazDNGSfDCaVDrLUlQ2vG+acV0c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QfZnvR33eTYsf+dmDKsjFVaW/HI1gWc6sxEcxpgO3ZSaDQZvkD8wia8ZuGrtZAxCF
         I3cX/6/j7w86yMuE5K9ASwjPHDf0EsHK0aH1jbF+5tjVySxJdsbaZmLEQ5YpgECF0R
         3135Pz9LV1EzHxx1SZ+lw7YHsLq+50IIB30UnvnQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200501192950.GA25365@gaia>
References: <20200501192950.GA25365@gaia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200501192950.GA25365@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 1578e5d03112e3e9d37e1c4d95b6dfb734c73955
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42eb62d417e5cf22d6e305cb895fb54299862a53
Message-Id: <158838000685.10067.7730740235724641289.pr-tracker-bot@kernel.org>
Date:   Sat, 02 May 2020 00:40:06 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 May 2020 20:29:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42eb62d417e5cf22d6e305cb895fb54299862a53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
