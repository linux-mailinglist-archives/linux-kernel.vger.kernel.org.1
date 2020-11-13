Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899722B236D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgKMSMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 13:12:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgKMSMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:12:07 -0500
Subject: Re: [git pull] drm fixes for 5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605291127;
        bh=x9R+SPmtE+wZEBEGTxhMT6R63q4htMWcndE7nmRsi5o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jHQdxWQpNrvoSL1pnMf3SZ3WLJS/T6kov8ezkKRBH1zkYHoK52TpxXRSxml/bCvAI
         +tDR5wLP4mi/jstfv/2rJlVbzB5mCHw1iEwE59jBPImkRXbVZ419XC0H02oKLBd7Fv
         RKTXkwtAUpZR9WZSEczvEVTo3AYiJ/Tz+WAboQ44=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txkA3-XwKMbxzZT6ZWq5jneJXYWneABHi02AxGnpvrPtA@mail.gmail.com>
References: <CAPM=9txkA3-XwKMbxzZT6ZWq5jneJXYWneABHi02AxGnpvrPtA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txkA3-XwKMbxzZT6ZWq5jneJXYWneABHi02AxGnpvrPtA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-11-13
X-PR-Tracked-Commit-Id: 41f3ed2cac86ba533ce6a334a2e7fae5c7082946
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e627c25544dfec9af56842b07e40ad992731627a
Message-Id: <160529112702.14692.1883293070526598235.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Nov 2020 18:12:07 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Nov 2020 16:41:04 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-11-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e627c25544dfec9af56842b07e40ad992731627a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
