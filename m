Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EB026EA4E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 03:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgIRBKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 21:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgIRBKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 21:10:15 -0400
Subject: Re: [git pull] drm fixes for 5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600391415;
        bh=r1ms76b5s05xnohRny6LhBmnMvwVPTcZ9pEz5yL8no4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kSXgxMUi+J3rI8mrPOsFydmV5LEN88W0kc3tJVeg6T9PfdnetQTuKbv45igzi+B2n
         TYLsELRdeNMeVlDRT5vcSDouiXcxgVobhKCgTe/BWRm8AizoByXIkoEPlXYwEb4iT2
         dgGKALX4st3qhqs24XVe6GYD+0Dsprxi/UE1IgT8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txcHEa3-tZK3N+SAznbfHU_61UcQ01gq99m6riHzU5OOw@mail.gmail.com>
References: <CAPM=9txcHEa3-tZK3N+SAznbfHU_61UcQ01gq99m6riHzU5OOw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txcHEa3-tZK3N+SAznbfHU_61UcQ01gq99m6riHzU5OOw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-09-18
X-PR-Tracked-Commit-Id: 1f08fde70075784d28d1687d0e75871e81cc1173
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c0449c906fe4d9631025bc11993009071094a9a
Message-Id: <160039141518.8261.4924567172091494025.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Sep 2020 01:10:15 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Sep 2020 09:05:58 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-09-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c0449c906fe4d9631025bc11993009071094a9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
