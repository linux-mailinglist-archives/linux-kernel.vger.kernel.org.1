Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1902BB419
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbgKTSk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:40:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:58332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730799AbgKTSkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:40:11 -0500
Subject: Re: [GIT PULL]: dmaengine fixes for v5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897611;
        bh=K8HBux9xF5dqoa6dA91FYxYYdFaT/JnOWBhOsaF8OnI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SySgRfpqAisj5/cxfvaqLIdujSP5oEL/+LqGmPZ4RSf5oj8IGfhL8WTnykUg1VvUC
         gz3kQMotf11I9QLk1bBSh8VptboLhl4e/z+q7xpbfRViqihg1PxpoITXo6mS9EqIDd
         2IFctkG07YibtQrAzuaGvOqHroJECPQFadRso+ls=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201120150512.GL2925@vkoul-mobl>
References: <20201120150512.GL2925@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201120150512.GL2925@vkoul-mobl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.10-rc5
X-PR-Tracked-Commit-Id: 7e4be1290a38b3dd4a77cdf4565c9ffe7e620013
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd4d74e8f8b201caf4dab064b8bc7d01a72747da
Message-Id: <160589761151.4306.15178661238462604450.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Nov 2020 18:40:11 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Nov 2020 20:35:12 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd4d74e8f8b201caf4dab064b8bc7d01a72747da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
