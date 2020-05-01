Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167361C1D48
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 20:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbgEASfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 14:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729767AbgEASfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:35:11 -0400
Subject: Re: [git pull] drm fixes for 5.7-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588358110;
        bh=SmqomhasQEC9HdiALeRepmCi5R5rtei+s/Y4faNmvAU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Zk7B2PXBj2yMo4d2E1Lshy1ImbsGsE+Lw93tKpRsWM4ryCpgKPaqie/JLtwf/axLP
         nBRCGKWPX2neBDL8w/ehTj58lzr3X1dltGl3CMzNzJ7fxSeRIrBiFMDsr81yLxELG0
         HmRQZjJzc0L6MrLty/bplFUHOIlkQYOXMzC4wNpY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzf-buFu3YY69tzLw=bwwYVD_37RiGazpFXz+OgayWfFw@mail.gmail.com>
References: <CAPM=9tzf-buFu3YY69tzLw=bwwYVD_37RiGazpFXz+OgayWfFw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzf-buFu3YY69tzLw=bwwYVD_37RiGazpFXz+OgayWfFw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-05-01
X-PR-Tracked-Commit-Id: e3dcd86b3b4c045a4db17c02340138a4c514fe20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 477bfeb9a3d712b6e1aeb4e37607faebf4b7f6d4
Message-Id: <158835811093.18489.16145116338627649076.pr-tracker-bot@kernel.org>
Date:   Fri, 01 May 2020 18:35:10 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 May 2020 12:59:10 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-05-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/477bfeb9a3d712b6e1aeb4e37607faebf4b7f6d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
