Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B421E898E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 23:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgE2VKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 17:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbgE2VKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:10:03 -0400
Subject: Re: [git pull] drm fixes for 5.7 final (apologies release)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590786603;
        bh=pv0QUgVsa/cVUs1TSJTybLNskmmH0dvwlOUliJ/c8rc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2DCd4Bmy3AjBbxoE2uB5qQDd4uRSW8W8DZRYrhM2SnW39Xbi70kJeyAri25MuBJbD
         ctlX+vcWbBscRVAbdOKDcq/Ugj5Hsg7Vuc8Hw3JhJwit3zGOnXpaM0DFYxzEXJZRQS
         tAZIR1jkHNSycFH/koz7f6d6la1W+vF51bnEfX1c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tznwDT9GEhbAHD1dkUVY_OF5bQNzxX7sBjXPkSH6VFjcw@mail.gmail.com>
References: <CAPM=9tznwDT9GEhbAHD1dkUVY_OF5bQNzxX7sBjXPkSH6VFjcw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tznwDT9GEhbAHD1dkUVY_OF5bQNzxX7sBjXPkSH6VFjcw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-05-29-1
X-PR-Tracked-Commit-Id: ed9244bd0b265c4c0866a9246c6e7cca1cca3acf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86e43b8bf0e6b3897e504cdb9230fd063ecd4452
Message-Id: <159078660320.32003.16753683449130964815.pr-tracker-bot@kernel.org>
Date:   Fri, 29 May 2020 21:10:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 May 2020 12:37:51 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-05-29-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86e43b8bf0e6b3897e504cdb9230fd063ecd4452

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
