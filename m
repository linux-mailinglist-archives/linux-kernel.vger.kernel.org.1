Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8870D25E30E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 22:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgIDUtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 16:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbgIDUt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:49:29 -0400
Subject: Re: [git pull] drm fixes for 5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599252569;
        bh=PvB4DkPOxFuGOgSWUOxsQjmURrkgJbD47BnL0h1Yo1Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dQgtwbhlhAOqt+rla2zTnqRD85WBxkOzVZhsgeEg7Gcl3oIN6sqna/Y7K0v/E1tCd
         GPxD7R5uXm4r9Jm8wctWnnyObiFBCDmrNw1qqqmYCTvKCoNrez3ERV4lMFJgqfwKXB
         hHBHb0Y01pk/Eb2z9rGeqtHHAv7YjWY75yAk0l4Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tz0whDeamM+k_8Wu8TVzz0TDr+qMNMXo8rKeeNRKxBuiQ@mail.gmail.com>
References: <CAPM=9tz0whDeamM+k_8Wu8TVzz0TDr+qMNMXo8rKeeNRKxBuiQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tz0whDeamM+k_8Wu8TVzz0TDr+qMNMXo8rKeeNRKxBuiQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-09-04
X-PR-Tracked-Commit-Id: d37d56920004cae612fa32d1f92aaacca5e145f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf85f5de83b19361c3d575fa0ea05d8194bb0d05
Message-Id: <159925256932.25529.13873694892912208460.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Sep 2020 20:49:29 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Sep 2020 13:52:56 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-09-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf85f5de83b19361c3d575fa0ea05d8194bb0d05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
