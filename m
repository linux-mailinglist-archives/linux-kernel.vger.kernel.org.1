Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046612F09A1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 21:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbhAJUIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 15:08:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbhAJUIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 15:08:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 81DD922581;
        Sun, 10 Jan 2021 20:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610309243;
        bh=S3died/dPNI9IvVJNZXe9xsd0Gh/orcJL1BhUATABuI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j6Egk1fLQWqKKNpkp57f68c+vM68w8XDBSczfU2oqb4Azw4HOEX95xb4R6P7qLNAt
         AfXoudgPcAZBGe3nHi2Oi824LkUGoT1KORp8HPZ6aY41jJfSLf0ayY1B5fePR946VG
         Vug/GROR+pgvRG7VxjEagXMFTFZcNawc0BMj6nQjg2c4sNk3s0XkJXY+C6LR6ws7ym
         rGSLtX/yNztmZdrnK1cPTL4WhMuVanGzKC+Px6cEIpTYGLrfBRy56G3umAsZD9tC2w
         ZWPvkxJUbglaVgbYy751GPhKWs9bWaDxgY9weJBPegqNteaDTwrM9bH0xzYZAB4flF
         N8M2uqrGlz1hw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 71BC760140;
        Sun, 10 Jan 2021 20:07:23 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.11-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210110103436.GB10664@zn.tnic>
References: <20210110103436.GB10664@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210110103436.GB10664@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.11_rc3
X-PR-Tracked-Commit-Id: a0195f314a25582b38993bf30db11c300f4f4611
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a440e4d7618cbe232e4f96dea805bcb89f79b18c
Message-Id: <161030924338.466.7894824747803350006.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Jan 2021 20:07:23 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Jan 2021 11:34:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.11_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a440e4d7618cbe232e4f96dea805bcb89f79b18c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
