Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69F72BB417
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbgKTSkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731545AbgKTSkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:40:10 -0500
Subject: Re: [git pull] drm fixes for v5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897609;
        bh=bgZy/PDcE4WULqfuzRjeJCQSumd3ZCthesACnpnCoqs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ubfLp1S2vMg7saZOf/536s7tHaFGaqAlOOB5aHAkDn+zo6twYmsvr/9fUKYLmRFS9
         qZ4eQp8bpeEMEa/xYHikGzrhsNtsD6WR+gJ5j9lqzVf9WD3QiQhjyBEHZT8OQxjR8B
         Jo7AzUnRLD2hSbkOuM4Q91mHPuvh8yl7FwvxDoXY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twCYAR-+-fYi-HwbhZOtqYkjVO3aVqX2oAPsFA+GgJarw@mail.gmail.com>
References: <CAPM=9twCYAR-+-fYi-HwbhZOtqYkjVO3aVqX2oAPsFA+GgJarw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twCYAR-+-fYi-HwbhZOtqYkjVO3aVqX2oAPsFA+GgJarw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-11-20-2
X-PR-Tracked-Commit-Id: 6600f9d52213b5c3455481b5c9e61cf5e305c0e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46cbc18ed85219d534b4fbb4a39058fe66766e83
Message-Id: <160589760963.4306.15311391865559989087.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Nov 2020 18:40:09 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Nov 2020 11:55:49 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-11-20-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46cbc18ed85219d534b4fbb4a39058fe66766e83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
