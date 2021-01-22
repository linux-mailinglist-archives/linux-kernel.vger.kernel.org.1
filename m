Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AEE2FF9DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 02:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbhAVBTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 20:19:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbhAVBTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 20:19:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0AD52239D4;
        Fri, 22 Jan 2021 01:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611278312;
        bh=Ab/7UB3+CkjTq/GN0XW1zRbgIy6+ugyLv/KLYCTmRa8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T3B3eq6FoE2jghja2wucAXxJJCuA0ESmBsjJ6SudIqTjKN75kDk4AHbFXe2WY3EzK
         ZRLvATADkIHpjrR4gUHn80L158ZE/kv64AcxUA8As2CiuJAa+nIrCz1plkvhowLiis
         qY89Ka3B/Fza6WSdPsc3bv1kwafcWdxrg38bvt8QiRTal0VhfWCtWphYRznpjbQYOx
         4fevTiA7XZ8IP0/MErJM86BLGzccQfSAjUMJqHXyTqximC4SC8PP0T5mBQayrWsivB
         d5ppvXSz0VPdoR3oyvqmHXTfT9VwTYWgNMKA7xAgtyb79v3bLEHIhU28LQlqItDqyf
         JqOu9o4pUhvLA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id E430760641;
        Fri, 22 Jan 2021 01:18:31 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txc42qTPjmjChm3Z9itOp7-O=YivoG0oa8DsRMFriF4bA@mail.gmail.com>
References: <CAPM=9txc42qTPjmjChm3Z9itOp7-O=YivoG0oa8DsRMFriF4bA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txc42qTPjmjChm3Z9itOp7-O=YivoG0oa8DsRMFriF4bA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-01-22
X-PR-Tracked-Commit-Id: 06ee38dc2aab3b5a09feb74128cf7326a490b788
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36ada25026357c855d5839166f78017509824b77
Message-Id: <161127831186.8007.4452745686230068305.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Jan 2021 01:18:31 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Jan 2021 10:00:50 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-01-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36ada25026357c855d5839166f78017509824b77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
