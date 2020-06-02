Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8AD1EC4DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 00:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgFBWUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 18:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728888AbgFBWUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 18:20:07 -0400
Subject: Re: [git pull] drm for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591136407;
        bh=7lHSBvEPz7oxY7O+go1frxwoEWOhwnlJQiDFhhJWsqA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YUWPOuDHKGVB6/b/178dr9IKDajJeXLmTJziaMnrxLwQIZaux3HjJIHbBkRTCt8SU
         PxZ8xg+e6faFhLWuCu4BUlvmDVf9nT3+e/lo5iMXPx8kuqJNSy75Py9x2YPDa1A7xH
         brMApxVfuSzGvTxlzEglT926iXfkOfCXXyFU4plM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2020-06-02
X-PR-Tracked-Commit-Id: 9ca1f474cea0edc14a1d7ec933e5472c0ff115d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: faa392181a0bd42c5478175cef601adeecdc91b6
Message-Id: <159113640702.9664.5070448560079355262.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Jun 2020 22:20:07 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Jun 2020 16:06:32 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-06-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/faa392181a0bd42c5478175cef601adeecdc91b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
