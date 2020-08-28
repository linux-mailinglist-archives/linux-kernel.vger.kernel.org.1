Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DE52561B5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 21:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgH1T6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 15:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbgH1T63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:58:29 -0400
Subject: Re: [GIT PULL] arm64 fixes for 5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598644708;
        bh=BydAT8LZM7y6FrUKof/ZuYLrasLpA7c9m89Fd2Rqkv8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ft9Y5pDAaP0gcJXPuDVR7vMVtNdVv3dHk9R3+iNEl+DwJQQPawxFn4E5uYbGpHuOW
         FMhiEl5NYHZcI31D93cptvcTIvKC761PIZw7WhQlpBnpPhYHZce7Ajwk/LP2X8XRFp
         w4hgxUp4KvBszZNOnZQBex6oOYZPkQnAXl9ENEXg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200828172555.GA31202@gaia>
References: <20200828172555.GA31202@gaia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200828172555.GA31202@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 71a7f8cb1ca4ca7214a700b1243626759b6c11d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96d454cd2c1668010406ea4c28ab915bcbb747f4
Message-Id: <159864470864.31636.11102316857316987642.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Aug 2020 19:58:28 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Aug 2020 18:25:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96d454cd2c1668010406ea4c28ab915bcbb747f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
