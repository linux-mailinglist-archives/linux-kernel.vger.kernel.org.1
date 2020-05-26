Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C159819EDAF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 21:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgDETpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 15:45:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbgDETp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 15:45:28 -0400
Subject: Re: [GIT pull] timers/urgent for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586115928;
        bh=ybcdyKBhVaz0OPyY6kaEVIoT0p9CGqIbwJzguZlartI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gjpla6LXwgb98/NcUwCL/YYlo9zh+//NvKuOullzNxmhAGJsH6NKhrmC1kNNcXnLu
         Nr5r7YKpMSauqjQXgfeJLrhXUpVR5gO5q1/IX6RVOsUPz5D4v88HT8D7eJQWZJTwjt
         UQlsy8pI6PvNdzTokYcoWTK7o0Bvvq2TCUOsSqA8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158609411231.4266.16619269103115870160.tglx@nanos.tec.linutronix.de>
References: <158609410988.4266.5816311298811487752.tglx@nanos.tec.linutronix.de>
 <158609411231.4266.16619269103115870160.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158609411231.4266.16619269103115870160.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-2020-04-05
X-PR-Tracked-Commit-Id: 760a53768610d427990192b5cfdb71310e1373db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5ca32738f8fbd3632928929cccb5789d44be390
Message-Id: <158611592828.11305.1304073357545038723.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Apr 2020 19:45:28 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 05 Apr 2020 13:41:52 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-04-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5ca32738f8fbd3632928929cccb5789d44be390

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
