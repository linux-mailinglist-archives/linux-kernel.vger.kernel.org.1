Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32012F84ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387774AbhAOS6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:58:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:54360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387598AbhAOS6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:58:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0ED8823A75;
        Fri, 15 Jan 2021 18:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610737083;
        bh=f0MoX4svYON7mKKr99NykQ06FZYVjpJHgoV93eXHG2A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jSfYCVo3HpsChnFQwZnriFiOMx6F3EqpemhioO18oVtUzoN32Xmh5rycWiXAZPa85
         /MfnyHJdVyiN2y56x0uhqnjgbU7u95vWxEw4NhujNqutPZ9CQu9aOY4pI1QB9khj3c
         TaA+ljmdOr7me40/P134lA1h/4H/MZD/OzCGF86SKt5VS1u2N94ikYSGAFiQYZSHlF
         LXU2qmtPoR4/U/QfTeNNIhsMCYl9WEc0P+EPqDvtuNbCwIdb85vLk13Xfyd4VveGff
         gYf1G1YY1Tog+zmWAgoB4pl6FBSltWMD6As+k89WVKk41K8aQ9Ix0e87gg/SfbFSMf
         PT9PH7F9ISWyw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 0A12360156;
        Fri, 15 Jan 2021 18:58:03 +0000 (UTC)
Subject: Re: [git pull] drm nouveau ampere modesetting support
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twv04YWugPc1h87PHBd=QY7sLykCt=tNyM+6gnoAaXOSQ@mail.gmail.com>
References: <CAPM=9twv04YWugPc1h87PHBd=QY7sLykCt=tNyM+6gnoAaXOSQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twv04YWugPc1h87PHBd=QY7sLykCt=tNyM+6gnoAaXOSQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/topic/nouveau-ampere-modeset-2021-01-15
X-PR-Tracked-Commit-Id: 584265dfec70e78ce2085b82ed389f27e06fbca0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02c06dc3750be486e143cd553c13f02978e39b14
Message-Id: <161073708303.18503.5778542879742029279.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Jan 2021 18:58:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ben Skeggs <skeggsb@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Jan 2021 14:56:04 +1000:

> git://anongit.freedesktop.org/drm/drm tags/topic/nouveau-ampere-modeset-2021-01-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02c06dc3750be486e143cd553c13f02978e39b14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
