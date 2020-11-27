Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867262C6DA7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 00:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbgK0XTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 18:19:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731451AbgK0UF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 15:05:56 -0500
Subject: Re: [git pull] drm fixes for 5.10-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606507556;
        bh=Qd9CqSF8eXexGud6PiR4dlfq12llG814HMZe3+s5jkI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NYZUKAPom5QJ1rdIStKIAylNnl90AHMCGxLeQoNc+UNQ/qqNgzAapQWZImFR4sI9o
         YTshHDbOaujhDtHIU/lhVhpMeMySs+oSdWOvBCkBHrGXZQYVFP2QtMCvtLPMa+K9l+
         NBtu/G4yGVKQZSL3J43L3DOSsTQkvTTzmpsTeRic=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twQYg5nf=wGOMm=i=++dZswSvpkV2txDnBYFmj=SRDx9A@mail.gmail.com>
References: <CAPM=9twQYg5nf=wGOMm=i=++dZswSvpkV2txDnBYFmj=SRDx9A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twQYg5nf=wGOMm=i=++dZswSvpkV2txDnBYFmj=SRDx9A@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-11-27-1
X-PR-Tracked-Commit-Id: 9595930db4bb91433607441a5f26d90e9c6e34eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6910b676898934c2abe9f3ff3d60f4d4bc8afda8
Message-Id: <160650755608.29509.16650003010743047178.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Nov 2020 20:05:56 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Nov 2020 18:37:15 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-11-27-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6910b676898934c2abe9f3ff3d60f4d4bc8afda8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
