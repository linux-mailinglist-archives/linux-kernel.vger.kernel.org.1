Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107D82A0F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 21:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgJ3UFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 16:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgJ3UFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 16:05:49 -0400
Subject: Re: [git pull] drm fixes for 5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604088349;
        bh=18GkA6iRo2BzVyR0d6ewM6Nt8BeX5/+XG0fMOzXKNGo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=g6TwEtkgqZtqP7nhTt1th3PkwIEccFb82BvemeskW2/lYBTwX23/ltgs8Inj/iJxC
         UF7NiQJpctFudhSZdUljU7P//Lvn7tJsfhPsXBsdwarC60caGD6r7/JfAFhEoJ0+lK
         GxmAJkH9+35a3GTjO77Cq749jOOQpwnWEiLlWt/E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw8m2318cixWC-_BvLTpO7usf6wiYiNbdT3W9NaVa5qpg@mail.gmail.com>
References: <CAPM=9tw8m2318cixWC-_BvLTpO7usf6wiYiNbdT3W9NaVa5qpg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tw8m2318cixWC-_BvLTpO7usf6wiYiNbdT3W9NaVa5qpg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-10-30-1
X-PR-Tracked-Commit-Id: 7babd126327b8b5a3904d2f8f01c95235801af2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ba4d8675090480e64388f4669271c03123072b2
Message-Id: <160408834914.13990.10597880144562985068.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Oct 2020 20:05:49 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Oct 2020 12:01:27 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-10-30-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ba4d8675090480e64388f4669271c03123072b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
