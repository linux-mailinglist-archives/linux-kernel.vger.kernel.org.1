Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E51C278FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 19:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgIYRst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 13:48:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIYRsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 13:48:46 -0400
Subject: Re: [git pull] drm fixes for 5.9-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601056126;
        bh=W4d0UPdguLawi1svN5PWS6vBQmvJCl6MLCfwRP649D0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Zu1PDNCz2afyRlzR3jkGhg3fHHPhJP5OZYp3JigoO3LkVlDCuvfriR0Ho8d9MhjMJ
         sSp0tY03Ghac0cSLACDEC3p5RQwE2HjqZ+D5s6K5sjVbUzk1oUW41QMDvMmQGRMuTx
         fDqE2UbUGj7LAwgLsGhRmmiv3LBUGT6JF/6uBqpY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzV6xvuqq9wnzhUY+qQPj9Q5K0BMpJX+7YUKX_a-EJTLA@mail.gmail.com>
References: <CAPM=9tzV6xvuqq9wnzhUY+qQPj9Q5K0BMpJX+7YUKX_a-EJTLA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzV6xvuqq9wnzhUY+qQPj9Q5K0BMpJX+7YUKX_a-EJTLA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-09-25
X-PR-Tracked-Commit-Id: ba78755e0c25dec4151880a14f523e929b2052c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 574ec42e1a9c4bfb8b2eef8d801a77e92bcea76a
Message-Id: <160105612634.19145.17530884405418842469.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Sep 2020 17:48:46 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Sep 2020 11:45:04 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-09-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/574ec42e1a9c4bfb8b2eef8d801a77e92bcea76a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
