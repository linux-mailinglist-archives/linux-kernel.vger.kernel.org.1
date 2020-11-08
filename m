Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD492AACCF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgKHS3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:29:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbgKHS3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:29:38 -0500
Subject: Re: [GIT pull] core/urgent for 5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604860177;
        bh=GUv4aJbUoTdBxhoqUnrk5S/7ZtNs5Gtwg2TOJdO+/Dc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tytpeRvgzrAgpAx1UIZ+g1wlsnC1j+lz2iw5vR4vuSlmR/8SoddRmr7BtlXWYQTfQ
         eesVjM3uVSFDEz3DvI7OhdmZksNnyCsb3iHNNJX9CspvxjnxFlzBi3dGkigpVRJL7D
         gsMzS3e++bKR6p2/TPMMug74hGug8MpEDXb1fq8M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160484899473.4262.9790266201913163807.tglx@nanos>
References: <160484899473.4262.9790266201913163807.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160484899473.4262.9790266201913163807.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2020-11-08
X-PR-Tracked-Commit-Id: 9d820f68b2bdba5b2e7bf135123c3f57c5051d05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a8d0d283d624302d4377bcf4f40f5bd90c3c775
Message-Id: <160486017787.13369.17804566700263456734.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Nov 2020 18:29:37 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 08 Nov 2020 15:23:14 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2020-11-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a8d0d283d624302d4377bcf4f40f5bd90c3c775

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
