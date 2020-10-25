Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2187E298325
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 19:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418220AbgJYSfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 14:35:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1418147AbgJYSfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 14:35:24 -0400
Subject: Re: [GIT pull] perf/urgent for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603650924;
        bh=HA3cGtGhk60r2sJE1wQKsdLVx1/y5a8Tcdf6Ueyb4PM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QsFR44uqjWwUeeQs1yG7e4H92eLDbHXqCMloFQPqaHGuiBF/F56/7TOz8EtCXvnJ9
         juY8Z8dOVyKsa+0WL/7gwNELBe6/j9xA0IJkeEOSm5juA7hv4Gs9OO0qro4VIqilXt
         mNFNuHbBmABL8Xmnqzjec6AsDnP/v7/ghH9+4dWQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160363590585.1234.15412286970681035533.tglx@nanos>
References: <160363590465.1234.11586095980767794789.tglx@nanos> <160363590585.1234.15412286970681035533.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160363590585.1234.15412286970681035533.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-10-25
X-PR-Tracked-Commit-Id: f3d301c1f2f5676465cdf3259737ea19cc82731f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3d1b31213f1f789cc45a7db5c721513282d225a
Message-Id: <160365092399.20889.954201007479075201.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Oct 2020 18:35:23 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Oct 2020 14:25:05 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-10-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3d1b31213f1f789cc45a7db5c721513282d225a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
