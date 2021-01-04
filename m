Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88392E9DD2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 20:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbhADTD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 14:03:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbhADTD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:03:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 03F3A206A4;
        Mon,  4 Jan 2021 19:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609786966;
        bh=5Jgrm2Oaetvxl5/VVUn7gUMfkhG+U+aX0NvncCTk/Dc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YmTRVt+3Sg6bRs+Rf/GwNCh06rwtz1YJYvDGwvu6f57tJc1nhIRWRnscO20AKxomJ
         GgARBr6c7nirWsVsld8P94WODRh0JlDXywtfAkPR68kRhVKKWTGr4IEwW+GJtKlX9u
         nxMK5X+Dpgj60kHiQhHLRh7SCjBMqOdDqxDMom57zHalE22+HNMhoDnhUu58sz9zC6
         l/gp3u6HxaW8ZamHJC67EPvT5ceUHr62IoGeM4z6IKOo9cCiUAiAGDxxaQwhrBG0fc
         3GUICZSKZ1ia7b6ZgXWkvHfZ0GTfKFW/bsQjoU5fuqyHVqTWnht3JZXPSUqXfSmBg9
         8ofvEUIl+0pOg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id F2155600F6;
        Mon,  4 Jan 2021 19:02:45 +0000 (UTC)
Subject: Re: [GIT PULL] Compiler Attributes for v5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210104153026.GA26533@kernel.org>
References: <20210104153026.GA26533@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210104153026.GA26533@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.11
X-PR-Tracked-Commit-Id: 1967939462641d8b36bcb3fcf06d48e66cd67a4f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4f6a2e329523e1a795e5e5c0799feee997aa053
Message-Id: <160978696598.11668.15887230505503739535.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Jan 2021 19:02:45 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Jan 2021 16:31:06 +0100:

> https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4f6a2e329523e1a795e5e5c0799feee997aa053

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
