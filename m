Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE066301E27
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 19:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbhAXSff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 13:35:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbhAXSfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 13:35:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0CA0B22CF6;
        Sun, 24 Jan 2021 18:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611513292;
        bh=Kffcz1wAhen1BarIl0DYIR7DQjOt9KbQPSFaIKnatbE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VXLprnrceSsj+GWH9oWdu5zMnbm/9UTIzVrjaWhUItQo5cOf3rJ7cpvYQh36yxuvj
         cibdKhmdJqJFyepxAk8N2pNQ32ZPHniuDWK8VFqVx7HEaBHUKl9iicpBc9QrJj1gpS
         4KZTxmR6wGxoipUjBGpBV/dDG84sA6sOZyeSU0VqT/u7o79zFgmvg1lxNU2th80KXq
         GtopUvfBhXyXIfhmkwlN9NFkKzF9vfAFT6E5ZUJCOjlFUWDvLG2tdItztRGfuVyOZx
         /nfavsmLx6GAWA+m6QpLXTwNmy29XAXmpmopKQropk6Ytfh3WKxRxQhC4AnpVXNInV
         4ZUTznzSHBckA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 08512652F2;
        Sun, 24 Jan 2021 18:34:52 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.11-5 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87tur6pm2v.fsf@mpe.ellerman.id.au>
References: <87tur6pm2v.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87tur6pm2v.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-5
X-PR-Tracked-Commit-Id: 08685be7761d69914f08c3d6211c543a385a5b9c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14c50a66183856672d822f25dbb73ad26d1e8f11
Message-Id: <161151329202.2223.9266502406259930102.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Jan 2021 18:34:52 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, sandipan@linux.ibm.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Jan 2021 23:15:52 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14c50a66183856672d822f25dbb73ad26d1e8f11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
