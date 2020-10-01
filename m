Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B3F280533
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732945AbgJARaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732360AbgJARaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:30:18 -0400
Subject: Re: [git pull] drm amdgpu + vmwgfx fixes for 5.9-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601573417;
        bh=bESyP7iI8I8oWmwo0p/daUKYw1SW96HYUdogfnRhIq8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Aw7xPD+gz5I+F/cSVtYC5F9GFV6eOMS3Dg7x2PuWTHt3ZubPAOnfHlIfCB+Rih5nc
         sgOjxBHaRFeoMviWySkoNbAICDee6DB4l6SLuiiPm7JLFSVQYm6CatpLy4ycIUeMxg
         eTjcz+8p579QSqxBdcylwWVoS0XKVGaVY4/8AuMc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txPMxjzQTiZiWeMCs_LDoYGid_d3F6W5HdBr8UB=tjvug@mail.gmail.com>
References: <CAPM=9txPMxjzQTiZiWeMCs_LDoYGid_d3F6W5HdBr8UB=tjvug@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txPMxjzQTiZiWeMCs_LDoYGid_d3F6W5HdBr8UB=tjvug@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-10-01-1
X-PR-Tracked-Commit-Id: 132d7c8abeaa6b10ed5f47330b0f06c6dd220a43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcadab740480e0e0e9fa9bd272acd409884d431a
Message-Id: <160157341766.4684.6393544746214094272.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Oct 2020 17:30:17 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 1 Oct 2020 16:10:22 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-10-01-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcadab740480e0e0e9fa9bd272acd409884d431a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
