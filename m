Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E172B396C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 22:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgKOVOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 16:14:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbgKOVOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 16:14:11 -0500
Subject: Re: [git pull] drm nouveau urgent fixes for 5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605474851;
        bh=jUTZyS4AZsV6JujZiwD1FdfFlpGqhQw/bCn0u0jwn40=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=K6XJoKIjMJC4W/goDyVxDecBpksqQVdlavZ3NQ1y3qeGFr5cMXzRHRndZUHxqknpy
         Tw6XHBGfkXPVL/yW/hFjUhYP1WlrPliq5yQhESVWvuvOC3j8XHVdJFArrtskz6kqsk
         jdEFE6oqKw9EzOlWc/RRoX/UT2kToDmFkE2p5dxM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty9cBzR5tr8g2B7LE9+Hcf4NViHcyDcEHJMVgYmSoub1A@mail.gmail.com>
References: <CAPM=9ty9cBzR5tr8g2B7LE9+Hcf4NViHcyDcEHJMVgYmSoub1A@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9ty9cBzR5tr8g2B7LE9+Hcf4NViHcyDcEHJMVgYmSoub1A@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-11-16
X-PR-Tracked-Commit-Id: 8f598d15ee6577a56d6617d9e4151591db34d8fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6af8718b98e1cd37a9ea9a02269c79577fc9138
Message-Id: <160547485149.22165.6645793392727628504.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Nov 2020 21:14:11 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ben Skeggs <skeggsb@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Nov 2020 06:41:34 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-11-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6af8718b98e1cd37a9ea9a02269c79577fc9138

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
