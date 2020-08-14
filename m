Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28576244FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 23:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgHNVvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 17:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgHNVvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 17:51:18 -0400
Subject: Re: [GIT pull] timers/core for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597441877;
        bh=Q/ACN2icRa2ttl6IsW7fMMMzyALrVAbA+2l4tMz48T4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Pr9opGFCPgLjpZtjPTh/lS/ghwE4Jgx3Q7nDRiLqJ8/xPOfIj1S+p4W7+EGrw9fpf
         vHAgD2ZqOiyWuBAXDPn3YvNSK38iJD7QgZkdLVLQeCUbbBw2d/tDfHTfqgptzFrMzZ
         TiPTztAZSGQoBwpETsCCYaWfqYsr7CJTHMyyzr9g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159742071312.30851.9658771452402261764.tglx@nanos>
References: <159742071192.30851.2328227964586183297.tglx@nanos> <159742071312.30851.9658771452402261764.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159742071312.30851.9658771452402261764.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2020-08-14
X-PR-Tracked-Commit-Id: 0099808553ad4f9c04ad7afd966f6d7f470f247f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6b178e38f40f34842b719a8786d346d4cfec5dc
Message-Id: <159744187777.11302.707602127649738188.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Aug 2020 21:51:17 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Aug 2020 15:58:33 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2020-08-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6b178e38f40f34842b719a8786d346d4cfec5dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
