Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59586285240
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 21:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgJFTSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 15:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgJFTSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 15:18:32 -0400
Subject: Re: [git pull] drm fbdev fixes for 5.9 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602011912;
        bh=ZIzEc9VE4fhrfyPrrqZAaIOMdajyG2L9BHNzJHZDfSQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vBu3z5Ex+kvcPzJ3X/nhG6pqIqvmTtC3ffgmvI52ijRJAoRjJH5uUVWkKzcCQObrj
         Dz04dnNcS8S2EG6BbQtYe0g7wQTrtd6jTSFMQa/0OBtRRG4E+rwWa1ExytPzUWcEd7
         QLEFNVBgH+G3hblcPm5RCjoL1rgddZQRomRmOlfE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyLDWM8c6L0fTG6SeouqXRixTTS2MHX8FKeEGekGinp8w@mail.gmail.com>
References: <CAPM=9tyLDWM8c6L0fTG6SeouqXRixTTS2MHX8FKeEGekGinp8w@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyLDWM8c6L0fTG6SeouqXRixTTS2MHX8FKeEGekGinp8w@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-10-06-1
X-PR-Tracked-Commit-Id: 86fdf61e71046618f6f499542cee12f2348c523c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1e141e9db6b89d124ec09ca162f378a29119481
Message-Id: <160201191206.29733.6854172821291251615.pr-tracker-bot@kernel.org>
Date:   Tue, 06 Oct 2020 19:18:32 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 6 Oct 2020 16:37:22 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-10-06-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1e141e9db6b89d124ec09ca162f378a29119481

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
