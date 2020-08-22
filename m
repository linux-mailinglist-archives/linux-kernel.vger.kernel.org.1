Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FE024E910
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 19:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgHVRcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 13:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728516AbgHVRce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 13:32:34 -0400
Subject: Re: [GIT PULL] arm64 fixes for 5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598117552;
        bh=94paNDq1unkYpfSvsa3o2JpycRmGOAxH79zzPe/MSIM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lJ1u6UxDhxfXhBlUd0nvY6E/mw6quiVk2RbOitlZak3/gOZIzUBk7vnN9G7qnVL/0
         Q5SAwo4OzA7b1Xy/W+//6PS6Qsk1W3NVGmMPZk+aGayGHzduyqijdaBAPwfT30XBrg
         bqYgTwl4dMtxqXHxWiSWBL96CyHcmpAote+J9ORE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200822153116.GA8696@gaia>
References: <20200822153116.GA8696@gaia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200822153116.GA8696@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 8d75785a814241587802655cc33e384230744f0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd105d64a0c6976153adea40c034ba26f7cf34ed
Message-Id: <159811755259.17427.5800994783434860966.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Aug 2020 17:32:32 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Aug 2020 16:31:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd105d64a0c6976153adea40c034ba26f7cf34ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
