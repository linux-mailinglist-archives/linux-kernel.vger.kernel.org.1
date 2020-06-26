Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8B320B968
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 21:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgFZTkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 15:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgFZTkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:40:13 -0400
Subject: Re: [git pull] drm fixes for v5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593200413;
        bh=KQLDeKNOJt32GB6hmzGC9odeyGYV4xyxDoxxfCB5yjk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HoaGFbHJFZHZhOSUuIpQDioX7hom3XyzYCaBilp/ICoaZQ4LdWYUS5Oi9ueeSjpj7
         zAdRO73cAnGhYecKTE5/GjVyt98vaM3DzysPC1z/+v/vT/lEhNrXFCq13lJKjlJMTN
         Cpz1pYCwq0LLfZTZmpq9v5Y/NvWA9C9oc4QhYUbk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyuBF_AmAMxL1U=ofd4=kxN_39-EOW3c3rGNFyb4=ut8Q@mail.gmail.com>
References: <CAPM=9tyuBF_AmAMxL1U=ofd4=kxN_39-EOW3c3rGNFyb4=ut8Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyuBF_AmAMxL1U=ofd4=kxN_39-EOW3c3rGNFyb4=ut8Q@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-06-26
X-PR-Tracked-Commit-Id: 687a0ed337367be5267652af5f6dbcfc954b8732
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a6c9b220a7fb7c8285ad1739ac3c909584feb43
Message-Id: <159320041354.11855.17123223960471606973.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jun 2020 19:40:13 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Jun 2020 14:26:34 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-06-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a6c9b220a7fb7c8285ad1739ac3c909584feb43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
