Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA42287C66
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgJHTUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgJHTUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:20:48 -0400
Subject: Re: [git pull] drm nouveau fixes for 5.9 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602184847;
        bh=11avprIQB6UVEvLk8bT4ULpHAzJ/Ft4HqqUb1REgiRw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Cp6aKx+HVvVLf9jmSxls691ERCxOMcdvHLrAzzhF5ijt9HtLFU+9opf97I2ZUOYXB
         3k2mFuYCc5kHmF14jX9OuCWFer0/+Ae4iT4Y8pkUQbjJgKxlEhOm4c7r+odeXhCQio
         4aw+LkaghOLPcjJ+9/YhNgWVLCiXg2bT+XoWTS7Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twbVGe96YNPCMMRrXPJhCoLLbhqtN0DjdTJcqo52OoLCA@mail.gmail.com>
References: <CAPM=9twbVGe96YNPCMMRrXPJhCoLLbhqtN0DjdTJcqo52OoLCA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twbVGe96YNPCMMRrXPJhCoLLbhqtN0DjdTJcqo52OoLCA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-10-08
X-PR-Tracked-Commit-Id: d10285a25e29f13353bbf7760be8980048c1ef2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d006ee42dde0b08b7b47697def6f50fd849c996
Message-Id: <160218484794.22350.2341226418196875900.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Oct 2020 19:20:47 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 8 Oct 2020 13:35:59 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-10-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d006ee42dde0b08b7b47697def6f50fd849c996

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
