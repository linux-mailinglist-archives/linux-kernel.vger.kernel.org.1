Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F872A9EF2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgKFVOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:14:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgKFVNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:13:25 -0500
Subject: Re: [git pull] drm fixes for 5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604697204;
        bh=3JW8BUUMj0/pK5x52Z3RcLQoRDCmKGOLLujoJui7hog=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hWrCbnPqMnupU62cIXRUAmgbWRP0nD8IOA3Nr/8GxEsSIauNbV7nQR8fbxHULIG0H
         VU3bElkbovnwKNrGbhW/TVZhZXBj+J6gyhoa3CNl3gSmkZgjG1oEhbNT5bRIXuOy5Y
         3QO+1eShJnGGgp/sJcWqbNrhdJrPm0YD0Zl9f/hc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twEfV=TerAqTaQAo+3wUUewUxeij48bCph9XC1tdX3Pew@mail.gmail.com>
References: <CAPM=9twEfV=TerAqTaQAo+3wUUewUxeij48bCph9XC1tdX3Pew@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twEfV=TerAqTaQAo+3wUUewUxeij48bCph9XC1tdX3Pew@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-11-06-1
X-PR-Tracked-Commit-Id: 356583b956e620a7ef8086f14bfe971986a320b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc7b66ef076644dd646eb9f11563684edc479649
Message-Id: <160469720466.14190.5466261149845499580.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Nov 2020 21:13:24 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Nov 2020 14:21:13 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-11-06-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc7b66ef076644dd646eb9f11563684edc479649

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
