Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33B5301E29
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 19:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbhAXSfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 13:35:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbhAXSfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 13:35:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3CEFC22D03;
        Sun, 24 Jan 2021 18:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611513293;
        bh=6IuvcHCP5wp5YKklk9eT3MUNrVETCHZY304sW22v7zo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sl/+eQwHo7IHJ8uUYN2yMz153NEwaX1M5Eaq1mB0JgCfbUSdZ+5ivBbwWAs3ni5hQ
         9ReqhSKQ79qiFzln9g7BaH4A5T1yvygluF7OEwUtQnwBWc9TS+2k9tfSJdotWitUeH
         uFscGOttaeAm+HJUTBR9+9/ComuoJrt5jFtKw0Pq5rBZxGOLO9op7TY6i4oz20xTiW
         ZggpKzxxAHWYXYwG0thmrUmgSblznSwKVTvd6KuMo+adA6oVKkkDbuVRFf0cjo2rZd
         kTqJC1FekdNNbHHhFlelzDA+RH5lbKZ+zYMfnKO5x4bSlAfIbMXZBPAdbCrH0yOb7u
         2Sssyo/15qjSg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3654B652E1;
        Sun, 24 Jan 2021 18:34:53 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210124110247.GA2493@zn.tnic>
References: <20210124110247.GA2493@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210124110247.GA2493@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.11_rc5
X-PR-Tracked-Commit-Id: 6e1239c13953f3c2a76e70031f74ddca9ae57cd3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17b6c49da37f5d57d76bf352d32b0ac498e7c133
Message-Id: <161151329321.2223.18175309503633530683.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Jan 2021 18:34:53 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Jan 2021 12:02:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.11_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17b6c49da37f5d57d76bf352d32b0ac498e7c133

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
