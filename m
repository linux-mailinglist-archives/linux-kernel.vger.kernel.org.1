Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB5329789C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 23:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbgJWVBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 17:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750725AbgJWVBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 17:01:16 -0400
Subject: Re: [git pull] drm fixes part 2 for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603486875;
        bh=5XXCXqomEwfsyLPJ81nX8fxCoXr5mmLAy12dSvAM/eg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gd8NEb+9xL3Wb5wLU5sNxJZQIRnNfJTWV+19iP2kgFkjEhlLh701c4LytZCanXrk9
         p1GcSp38Sjbc2ePYfRB1MQDU+GQZImXFojBcQ8a9vE4N6iqF9mAHz0VhomPpjXaB3l
         gIS8/c1HdI7+S0fX3vTSy1jQnL/9++qyloapT0FA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw08JOodzP4F_K9gMpQb7MiLr5-uc0vg=kSwdmDxr=Ziw@mail.gmail.com>
References: <CAPM=9tw08JOodzP4F_K9gMpQb7MiLr5-uc0vg=kSwdmDxr=Ziw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tw08JOodzP4F_K9gMpQb7MiLr5-uc0vg=kSwdmDxr=Ziw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-10-23
X-PR-Tracked-Commit-Id: b45b6fbc671c60f56fd119c443e5570f83175928
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc03b2d6a9d1398dc855318d6ddfa3be57bdcf2c
Message-Id: <160348687574.3049.18082894878208155785.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Oct 2020 21:01:15 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Oct 2020 10:03:10 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-10-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc03b2d6a9d1398dc855318d6ddfa3be57bdcf2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
