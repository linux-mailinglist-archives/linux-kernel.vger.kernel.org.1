Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A221F1F68
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 21:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgFHTAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 15:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgFHTAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:00:24 -0400
Subject: Re: [git pull] drm next fixes for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591642824;
        bh=wFvxGuNZ+8D8d7Fg07XNVR4lrWufWgqoZIfgmL0C6vs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TtDv/YXrz54z9YRMI5UESm88fqOqYOhm37nTlo76GZV+f5fTv0zYQz4WGyumR+s42
         CJNT22BwEYcCP27XVqDksZZdZM6qBto67lvB+TtpAvTlSFHO+jJ9VyuDdBUEeTHfR0
         IhxvpjOtVSfyPN0cKaafPtf+K24JSHopTQjyumCY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzk9DL+Smnc6wdDpGvex8_2qi4TtmCfi-cevBE8-jLGTA@mail.gmail.com>
References: <CAPM=9tzk9DL+Smnc6wdDpGvex8_2qi4TtmCfi-cevBE8-jLGTA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzk9DL+Smnc6wdDpGvex8_2qi4TtmCfi-cevBE8-jLGTA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2020-06-08
X-PR-Tracked-Commit-Id: 8d286e2ff4400d313955b4203fc640ca6fd9228b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 107821669a9cbf234f260d576039983b64c7cb6d
Message-Id: <159164282425.16000.6015107631632578742.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jun 2020 19:00:24 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jun 2020 13:15:58 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-06-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/107821669a9cbf234f260d576039983b64c7cb6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
