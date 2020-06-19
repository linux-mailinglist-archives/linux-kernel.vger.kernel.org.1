Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677D0201C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 22:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbgFSUZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 16:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgFSUZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:25:23 -0400
Subject: Re: [git pull] drm fixes for 5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592598323;
        bh=P2SsJqPjthAAmm3aJvqDFeEcXcH3hqQHTcjrBRY981s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=C0Kn/yvyoHTzuF9949MuGeqiazp9hLBpl8Cdtna9ZDCidtIBGsHJS27j8gV7Osz3j
         x1eoRit0xfS13Eis/SGaNNHvccGhfsJf+vqcim+vLfbeL+1FEjdwEs6tKoJ0A8BJaP
         EnhcQTFdLQp5nQTB2czwwcrT8dxsJIrPtLtUxKzI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzY6Md_x57APC-u0eWTztTmB1g-78XQk-dFS++7W1DtgQ@mail.gmail.com>
References: <CAPM=9tzY6Md_x57APC-u0eWTztTmB1g-78XQk-dFS++7W1DtgQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzY6Md_x57APC-u0eWTztTmB1g-78XQk-dFS++7W1DtgQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-06-19
X-PR-Tracked-Commit-Id: 8a7a3d1d0dcf2bb63dafe7275020420005e13e54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62c91ead977a5d5023be3d791cbff8535f7d5433
Message-Id: <159259832312.1498.1663559978022920624.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Jun 2020 20:25:23 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jun 2020 13:00:42 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-06-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62c91ead977a5d5023be3d791cbff8535f7d5433

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
