Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC01224DE4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 22:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgGRUuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 16:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgGRUuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 16:50:04 -0400
Subject: Re: [GIT PULL] hwmon fixes for v5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595105404;
        bh=8399C5wjgWQGrgxa9vJL59qQFBb/UJ/8QpaxCn/llOw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WN8CYM6+whMnNQtYOsUtKt+Mw2IFzKk8YMRfGCV988uN7wWjKD76n2E+XCU255yJ4
         Fmyp+pmd3zYtMmydc0Ua1iqLnN92eSIOPpZ4WxYGqN/VUZ9DHpt75Rm10fm02y/j7h
         z1nMBZi7FImLroef6mxd8xucakHzqMtG1jF5hkEA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200718152255.175469-1-linux@roeck-us.net>
References: <20200718152255.175469-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200718152255.175469-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.8-rc6
X-PR-Tracked-Commit-Id: c66ef39eb27fe123ee05082b90eb2985c33c7715
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e26aeee89f54e2e5867836231b4dc6448e45248b
Message-Id: <159510540431.20690.1524153901713935165.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jul 2020 20:50:04 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Jul 2020 08:22:55 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e26aeee89f54e2e5867836231b4dc6448e45248b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
