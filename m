Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6034266850
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 20:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgIKSh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 14:37:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgIKShN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 14:37:13 -0400
Subject: Re: [git pull] drm fixes for 5.9-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599849432;
        bh=To9qZZExMmtVAxS0FChFah7fb/s6Qm9qDZB1FFFO8RY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jQ+3mqTV/qjxVfYc30M9ApWGWDmsxps/zEUpcqa2zqvDiTA7fNJ+aRLzE0w2EH2xR
         h8qm8qxCzFYAftZzgLGO+iiqsLEbZUmQcV8LOKjthkjqgDkgocq787D1qPalRI/SFR
         gyCNRoutqQTIkMtq3upHVqA93SuOSHNjvyJvVy5k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txiwAocSprg6zCMF7ajJm-aY7wX=NY47+ZhVdKLfVZi+A@mail.gmail.com>
References: <CAPM=9txiwAocSprg6zCMF7ajJm-aY7wX=NY47+ZhVdKLfVZi+A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txiwAocSprg6zCMF7ajJm-aY7wX=NY47+ZhVdKLfVZi+A@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-09-11
X-PR-Tracked-Commit-Id: 7f7a47952c0f981f9c9a6409c8cf8d025d55af64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d67f2ec1f5fed849d9773cd783ea161df842bbae
Message-Id: <159984943290.11596.10839572395961557016.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Sep 2020 18:37:12 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Sep 2020 17:20:15 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-09-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d67f2ec1f5fed849d9773cd783ea161df842bbae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
