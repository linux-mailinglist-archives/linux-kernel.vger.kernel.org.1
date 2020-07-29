Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C8623271A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 23:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgG2VpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 17:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgG2VpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:45:04 -0400
Subject: Re: [git pull] drm fixes for 5.8-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596059104;
        bh=IvltQxPcmxATCkw4biU9TkRTnUWnbuoEgY6PwQ0dIjE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=n+G9T9PAQfCTJezhqXG2b+6pFMgNP8jY39uNhA/pkOVjWGxi8PyuwlNes7xfFSOFO
         Sq1p2NNJWCR+u5SnpE/iDKZCelQVe/9OaympGpCsAKGmtEc4eJXg+TPwp8bqTYPZ8z
         ZlAjJvoQlxEDjVjlCCGu5lTXhE4YwWkhPUTRz1Lw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzCWbg3CUSeywiHxQ-fCE1FAGGdOt5Qm+sjsLQLBSExyw@mail.gmail.com>
References: <CAPM=9tzCWbg3CUSeywiHxQ-fCE1FAGGdOt5Qm+sjsLQLBSExyw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzCWbg3CUSeywiHxQ-fCE1FAGGdOt5Qm+sjsLQLBSExyw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-07-29
X-PR-Tracked-Commit-Id: a4a2739beb8933a19281bca077fdb852598803ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2f3850df7f95537e79c561f7be49df2e4ad8060
Message-Id: <159605910453.4880.16477590993967546458.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jul 2020 21:45:04 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Jul 2020 14:44:16 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-07-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2f3850df7f95537e79c561f7be49df2e4ad8060

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
