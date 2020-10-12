Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D5328C199
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388589AbgJLTrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:47:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388259AbgJLTrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:47:04 -0400
Subject: Re: [GIT pull] irq/core for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602532024;
        bh=cTlK0KwtMVOV2SIj70snFTL+3JBhYla1LFj0j8vFiaI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rQLLyhQEylq0ebbaZbN/livMrcZmkUWFQubROWlDJXBwZcXR6MyQkyC32IF8JSVPY
         6z9iRPFqs711q2gyj33otltqNSfx2xKSD624WEw3RziJxp8XGn8qNQzSewZ5CJxt+n
         myVdSCTtquJgjefAobGzVRsCbaf5AslfC+YGIMkg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160250758282.26264.8240369892923988747.tglx@nanos>
References: <160250758161.26264.880601562259119308.tglx@nanos> <160250758282.26264.8240369892923988747.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160250758282.26264.8240369892923988747.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-10-12
X-PR-Tracked-Commit-Id: 863bae1fbcfa0420e5f51389218a9532542aa00f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c457cc800e892315d428a724ede09a085c4501be
Message-Id: <160253202450.16131.9836771179697723087.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 19:47:04 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 12:59:42 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c457cc800e892315d428a724ede09a085c4501be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
