Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7351F6E44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 21:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgFKTu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 15:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgFKTu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:50:26 -0400
Subject: Re: [git pull] drm fixes for 5.7-rc1 (updated pull)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591905025;
        bh=JrXRH57fM4fvpHWV3D4gx5E1DHXUOmzoTatnMaljVTo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2PKr1KM7fcVbfG+Xfx+3anXDlaHV9eAGlwfKR/o4akbHOGsWCU1shVhMXfHwp99W8
         /EUz2DVmuXA2vTSdCe9i213cDifMgoGFIOAicUcpAE+UGr50/QdknvraetF65xL/ZI
         VZlxqwGwZ95o0tnVO7qQtYayHxg1IrXUJZvdXSjM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyM72CtJbA4Q9wKnft6oQoMLGEt=xCYBcPn9wK9F=+Uwg@mail.gmail.com>
References: <CAPM=9tyM72CtJbA4Q9wKnft6oQoMLGEt=xCYBcPn9wK9F=+Uwg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyM72CtJbA4Q9wKnft6oQoMLGEt=xCYBcPn9wK9F=+Uwg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2020-06-11-1
X-PR-Tracked-Commit-Id: 66057dd1d1cf2149e0f5fdaee58d6ea69bc98048
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4e181f204dd0491da6c1d09b7208a0b990ec887
Message-Id: <159190502577.20905.15451629338604498776.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 19:50:25 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jun 2020 18:38:54 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-06-11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4e181f204dd0491da6c1d09b7208a0b990ec887

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
