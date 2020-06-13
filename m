Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69C11F8487
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 20:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgFMSAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jun 2020 14:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgFMSAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 14:00:33 -0400
Subject: Re: [GIT pull resend] ras/core for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592071233;
        bh=jUxv3dZ6wNo7KhYazYkrHCP34/YVeVN8UbV2dqj09yk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1cMEgtR0TnfjVSO4wR+B55969w3sQUMv0JqRhiXBq892fZp6OQmQ33SmWp3+laKs/
         BJy6UvQ9CNLsQVinfFBbnal0+/eBG/wQb0GJrqevAfc4k3p2sLdDezf8KNCz+lDd7+
         4fsAMkwWjJFG8+HUF/oomxCuAZoYiU4G9zze39GQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159199950675.21782.3785702143162610645.tglx@nanos.tec.linutronix.de>
References: <159199950433.21782.7922990856385499228.tglx@nanos.tec.linutronix.de>
 <159199950675.21782.3785702143162610645.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159199950675.21782.3785702143162610645.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-2020-06-12
X-PR-Tracked-Commit-Id: 7ccddc4613db446dc3cbb69a3763ba60ec651d13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9429089d3e822d45be01a9635f0685174508fd3
Message-Id: <159207123332.28894.7000363761584210831.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jun 2020 18:00:33 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jun 2020 22:05:06 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-2020-06-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9429089d3e822d45be01a9635f0685174508fd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
