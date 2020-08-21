Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D0E24DD70
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 19:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgHURRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 13:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbgHURQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:16:19 -0400
Subject: Re: [git pull] drm fixes for 5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598030179;
        bh=cNoYfjKrtJSQm8jTogKaryiMVq/0p/K2zYAGKiXnugk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u6NMUj12rlNC/dENNgDFZa0GNKkuXi11Hfce0yrDmeBep0Hs5dwuYXK+Bi0iJuq1y
         +5zllTWnqUqzMem86uRwswLbsC5OjR8tfZlViy1Baw1YE2VsynTDAphSteGxWX+t4G
         xdyrq+TdprPX5iqNV8O1mTSuZEYJAuRY2QpwXSLk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzpqLjG31xd0nPmGaYs7NXiWEQTtYaZ=vQZedyWU+yjfQ@mail.gmail.com>
References: <CAPM=9tzpqLjG31xd0nPmGaYs7NXiWEQTtYaZ=vQZedyWU+yjfQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzpqLjG31xd0nPmGaYs7NXiWEQTtYaZ=vQZedyWU+yjfQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-08-21
X-PR-Tracked-Commit-Id: 0790e63f58f22a68696667102be03efb92a4da5f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43d387a4adc48e1fe68bf467cbfd67a11d65eb45
Message-Id: <159803017933.29562.97618442697473059.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Aug 2020 17:16:19 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Aug 2020 11:55:16 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-08-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43d387a4adc48e1fe68bf467cbfd67a11d65eb45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
