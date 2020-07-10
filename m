Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F17A21AC88
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 03:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgGJBkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 21:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgGJBkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 21:40:03 -0400
Subject: Re: [git pull] drm fixes for 5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594345203;
        bh=i4HIRRheC66Dla3cyYkRyLg0MIuXZImCZW/QuJUVC00=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fKk+mEuG6gNtiLsL3N0AVSDu5xFhBbFlKjlPdUJR1jiRspEtqMBvmKqbimBUdHL4H
         JDPE61YxX/tEHZpZcdcLOw7JebFguH4mUInraQ19Fm+mmNORH06ecWYIxjHFI1qHV0
         4/0y/wNreclsFXyIwO+1sMiGnt0REGd0BcVbMZYo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzAJTvCx4_2o1RyK78n-Sr6MCByLTF=_P8mhDntxf4v4g@mail.gmail.com>
References: <CAPM=9tzAJTvCx4_2o1RyK78n-Sr6MCByLTF=_P8mhDntxf4v4g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzAJTvCx4_2o1RyK78n-Sr6MCByLTF=_P8mhDntxf4v4g@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-07-10
X-PR-Tracked-Commit-Id: 38794a5465b752118098e36cf95c59083f9f1f88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42f82040ee66db13525dc6f14b8559890b2f4c1c
Message-Id: <159434520350.26610.12870276466678802161.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jul 2020 01:40:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jul 2020 11:13:41 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-07-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42f82040ee66db13525dc6f14b8559890b2f4c1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
