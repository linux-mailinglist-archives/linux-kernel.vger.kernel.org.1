Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF7F23D5B1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 05:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgHFDIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 23:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbgHFDIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:08:30 -0400
Subject: Re: [git pull] drm next for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596683310;
        bh=QKZSJR9S/ZG1/AuOXr/WI3fdzKadEtEIvfdT7uQC5XY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=w1zDQLGM4cLfye5kC5id0i2fjOZAulUUagxJqPjN0RyBYFrWG+kWVb+bag7oueFHP
         0hwbm9Hn0d6s1DbqWXjsZa0xy/b5ZfV6RKI5HI69gUiG+de3RSItpMTULd/E9SM/DI
         /nqO9pBur/sMgHduqevT6ANvlJ2j+AIWKf5cZKOg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty8hOY0m2+RJdRiRADY5Li-hs3ZaDEK-DTf6rgFewar7g@mail.gmail.com>
References: <CAPM=9ty8hOY0m2+RJdRiRADY5Li-hs3ZaDEK-DTf6rgFewar7g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9ty8hOY0m2+RJdRiRADY5Li-hs3ZaDEK-DTf6rgFewar7g@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-08-06
X-PR-Tracked-Commit-Id: dc100bc8fae59aafd2ea2e1a1a43ef1f65f8a8bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8186749621ed6b8fc42644c399e8c755a2b6f630
Message-Id: <159668331010.23142.13676170826531297261.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Aug 2020 03:08:30 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Aug 2020 11:07:02 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-08-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8186749621ed6b8fc42644c399e8c755a2b6f630

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
