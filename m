Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951692EB47C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 21:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbhAEUtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 15:49:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:52438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbhAEUtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 15:49:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2D29522262;
        Tue,  5 Jan 2021 20:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609879732;
        bh=Uj7nizIQUPx57WLpXR/988R3wQXEkcJeNYTSh8yYd9g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PkxMOFX76tfDWrD9t3EhuWPdjKNUrNjRxM+iJPzeSwWs9//mtRO/CuJKhviZWvO4W
         Sgx41UiOpxEAdoWPZGor1dRlYJv5G18CyofB8tC6xR2pPstcE5Uk2jxXA9lEAo0129
         WgCiHa7W6RsG+oqPfSb1MXK2o3LIv8bJNuVuUwwlahBh7Kj+WB13YUnVGolxN+ZSax
         1phymEh/m6osbSxJdcsYcUAOOHBb0n1HlNx3SMh8SnzT2sadqddGxNKQrPnTIFLAhl
         Gy+qMrPprjK6CmZADyhma4yCBDIKOvBQzoK3kbtuU8VPmsCZ/JqjaJ8XgiYZiW2Vwn
         n7qE9FxysjdCQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 1A0DA604FC;
        Tue,  5 Jan 2021 20:48:52 +0000 (UTC)
Subject: Re: [GIT PULL] ARC updates for 5.11-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <59b97fef-41fe-f520-6e3a-2d96958cc744@synopsys.com>
References: <59b97fef-41fe-f520-6e3a-2d96958cc744@synopsys.com>
X-PR-Tracked-List-Id: Linux on Synopsys ARC Processors <linux-snps-arc.lists.infradead.org>
X-PR-Tracked-Message-Id: <59b97fef-41fe-f520-6e3a-2d96958cc744@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.11-rc3
X-PR-Tracked-Commit-Id: 3a71e423133a4b1166ffafcb4a7cfa87ddecb910
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6e7a024bfe5e11d91ccff46bb576e3fb5a516ea
Message-Id: <160987973203.24340.16693717606222472990.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Jan 2021 20:48:52 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Jan 2021 05:01:45 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6e7a024bfe5e11d91ccff46bb576e3fb5a516ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
