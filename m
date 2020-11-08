Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54102AACC9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgKHS3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:29:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728805AbgKHS3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:29:38 -0500
Subject: Re: [GIT pull] irq/urgent for 5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604860178;
        bh=UfSj79g1JEoWBXrAtvkKi/hsz+Nfl3i6ob+uuuAE5HQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qipR+Z53oUJouZbcKV+xMCuLX/yO6v/HH65oMeJtv2WXuI6RcnJvqiPfHzs/dhwp2
         Sj5w+qtdMW/fhBpiEHxLFCbvBUxmEsIIoHjZMMXiw2o7DcJMkyUCUJ/1BcGvI9Ypp3
         kKWIpHsPE7qLBBsjXQv3HBTCU/eYDPgVtIwE+Wcc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160484899593.4262.17407262771838227894.tglx@nanos>
References: <160484899473.4262.9790266201913163807.tglx@nanos> <160484899593.4262.17407262771838227894.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160484899593.4262.17407262771838227894.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-11-08
X-PR-Tracked-Commit-Id: 82768a86c64659c7181571ebfbc41ec9f2e52dde
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15a9844458cf3a7afcd720eca81ecb3a16213cb4
Message-Id: <160486017812.13369.17705398940842429494.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Nov 2020 18:29:38 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 08 Nov 2020 15:23:15 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-11-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15a9844458cf3a7afcd720eca81ecb3a16213cb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
