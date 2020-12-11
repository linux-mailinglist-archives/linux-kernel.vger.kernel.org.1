Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501252D7E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 19:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405904AbgLKSfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 13:35:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405884AbgLKSfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 13:35:53 -0500
Subject: Re: [git pull] drm fixes for 5.10 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607711713;
        bh=U0QJ6P0TY+JNCDSrrr+lo/Fzpsc3kCk9ZaFZTWFCqEk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o0dnKin6fZiE7cObcpLPZ9z9oBI5AjvGpbDoOU96/BsGtO8eVjQDVYtoQnRixAR5C
         ufhRGOoddKSOQjn7DrOUer4LoNugmrA7cZ4HcgP4iEbzNx/u4V+m3f7UYS51QC3n9L
         4iSazRBvlnXaJla+1MxHdNxW3EfWKOG+/86BO/KZeilOiTH4AA9gwnNMmzMPYuvbYc
         66hWzxvYrCjj+PfKtVIDGDnO9NmRuqcJlNFqfocUEezBVz8CgoG71e0GEw93BXvN90
         HcdC12KY2t1e/6HWW0mZVI/obDrEt5LJAeEswOBZZZQByN/Gwbs95KA/0WB15tnP3H
         CP9YEh8qPaflA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txOVY0jehFoHQwb=4PCr+a9Bg_x9u_7484uPYg62UsLog@mail.gmail.com>
References: <CAPM=9txOVY0jehFoHQwb=4PCr+a9Bg_x9u_7484uPYg62UsLog@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txOVY0jehFoHQwb=4PCr+a9Bg_x9u_7484uPYg62UsLog@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-12-11
X-PR-Tracked-Commit-Id: b1f195fc49812359296a901e26cc7c0b761d8a70
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 059fe8296e0fb4b89d997ea0aa75996911b8f3aa
Message-Id: <160771171316.31675.11381949430544648232.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Dec 2020 18:35:13 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Dec 2020 11:03:01 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-12-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/059fe8296e0fb4b89d997ea0aa75996911b8f3aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
