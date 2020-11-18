Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CB52B8563
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgKRUN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:13:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:46722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgKRUNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:13:55 -0500
Subject: Re: [GIT PULL] Another gfs2 fix for 5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605730435;
        bh=KXBEKlid7ZSvPCydjpiUmgNg3MRdK1sLLuE9UlV9fvA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wkfFP4MqnIFrxZ2ds1/cJOlImeIvhitu3LeH9e8FJqYIwClNO2Xp/REzdpbWAnzxc
         d6ll140YnR992BQqajWz6dfidtJfkBGtG7P1kDx0VHi+L1QvarXjjLUPw5q9CPD+cT
         DtG1H4LEhtfdhDJD8eHNvkEPFitJSxuk3FK4lq14=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201118155032.127787-1-agruenba@redhat.com>
References: <20201118155032.127787-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201118155032.127787-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.10-rc4-fixes
X-PR-Tracked-Commit-Id: 20b329129009caf1c646152abe09b697227e1c37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2e7554e1b85935d962127efa3c2a76483b0b3b6
Message-Id: <160573043541.16719.16024747080869082916.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Nov 2020 20:13:55 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Nov 2020 16:50:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.10-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2e7554e1b85935d962127efa3c2a76483b0b3b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
