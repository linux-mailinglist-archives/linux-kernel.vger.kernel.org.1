Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D12301E2D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 19:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbhAXSgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 13:36:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbhAXSgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 13:36:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8DEFF22E03;
        Sun, 24 Jan 2021 18:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611513293;
        bh=lUIeaMV2wFjdobmubxLTrEv9/trFQycWMihDuelZkew=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oBqsK3ZVyT+jsBudWZOJUVQWutRTOLKnUCuMvOoAuEstMiDNtpVGywVYJWV7dv/fm
         kXUrHgrjz1gMPRwFtkp3Kiy5D0TmzZD4CCaL8PePrhT6l+iBM6tdXAWA2ROHAdzNtz
         Z5lAKt4BNrnFutapdrH+bo/znuZAvso8N92z414ni7OwuJApZHNzNe4VoyymfiVzJr
         hPxIVHQAXKc3CnuZKRPvzNHqjIR5PGz3rFXWxhs3kJXD1w3rejSk+dUGon1owUcKU1
         kzB6KULVzCb44Y/sb9l3yhQqH00cyE0pkZeh9c7ubIEcFopkX3Y+8BweJakYYHLZ7f
         z089QEGgenZlA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 87BF8652F4;
        Sun, 24 Jan 2021 18:34:53 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210124123049.GE2493@zn.tnic>
References: <20210124123049.GE2493@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210124123049.GE2493@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.11_rc5
X-PR-Tracked-Commit-Id: ce09ccc50208c04a1b03abfd530b5d6314258fd0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e68061375f792af245fefbc13e3e078fa92d3539
Message-Id: <161151329354.2223.9114269742289837515.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Jan 2021 18:34:53 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Jan 2021 13:30:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.11_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e68061375f792af245fefbc13e3e078fa92d3539

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
