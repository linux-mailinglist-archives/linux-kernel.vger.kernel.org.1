Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7550B29415C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395391AbgJTRYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395373AbgJTRYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:24:01 -0400
Subject: Re: [git pull] drm fixes for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603214640;
        bh=jEy+A3kgsLLSan8ch002OuIdcyn8Qfx1jlsqgFQi+Mw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Qf3XLdHEYCee0SzG5D7lVmK0JTuRpkKcR6F7TqsBBB9KmRn7ECai3SVEY3iZxWUtM
         ailUqO/3BwfuNKfTyenlfyXwVGvFSNBcdkgMraPtlezg7xmYsqxR8YmMmLH1f18LUv
         KfggCq97l9RS5fwxTdcyPINYLt8dQEbsDRKPQTro=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyGF24NcUraYx7shazjkZ=c2sukykcxZE-u6L-qekCvbw@mail.gmail.com>
References: <CAPM=9tyGF24NcUraYx7shazjkZ=c2sukykcxZE-u6L-qekCvbw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyGF24NcUraYx7shazjkZ=c2sukykcxZE-u6L-qekCvbw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-10-19
X-PR-Tracked-Commit-Id: 40b99050455b9a6cb8faf15dcd41888312184720
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9915b964c25193a6be1aed744c946d6ff177149
Message-Id: <160321464091.32514.18204076146042610602.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Oct 2020 17:24:00 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 19 Oct 2020 15:21:40 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-10-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9915b964c25193a6be1aed744c946d6ff177149

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
