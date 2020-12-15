Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE5C2DA631
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 03:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgLOCWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 21:22:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgLOCWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 21:22:31 -0500
Subject: Re: [GIT pull] core/entry for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607998911;
        bh=zwE+j5lco6JnP1MMC0MTXoxVHSnM1RLeMx0FuFCxz08=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DsT9ZgH0OL3EceOMOLxiFikaYJ9U74h4Y/uxzy4JdMO/uTiGbfEl6Jd3jec190TJL
         v9ZZavREQufsPjhLfg5CfgDCF8bG951ouPv9ZYpODtdi63mrTmEjxjIYpXpTz0a1hG
         zWgWBHcM5ZJp7HrFYCocJZj5L5wKOU7ejjUU8EzW6avzVXYe5G7b2VWcDcb49IirhP
         PH6OiFAGVSckITHZd6W/xfB2WewjmbwoD4EOaqFdl+kmMN4xAJqrfx58r8Kc+kFlqg
         n6k4bxuGolt2uukPGO0StPJjf1Bdo8rksphpwDC9i7/wI33ESveBtHOW+w5X4RB5cN
         pTO7ApWerv/yg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160797732939.10793.9152151866806316627.tglx@nanos>
References: <160797732939.10793.9152151866806316627.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160797732939.10793.9152151866806316627.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2020-12-14
X-PR-Tracked-Commit-Id: c6156e1da633f241e132eaea3b676d674376d770
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ac0884d5474fea8dc6ceabbd0e870d1bf4b7b42
Message-Id: <160799891118.23883.10109078250539265583.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 02:21:51 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 20:22:09 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2020-12-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ac0884d5474fea8dc6ceabbd0e870d1bf4b7b42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
