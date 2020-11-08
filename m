Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1842AACCD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgKHS3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:29:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728814AbgKHS3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:29:38 -0500
Subject: Re: [GIT pull] perf/urgent for v5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604860178;
        bh=VlPxXEDbvCqsgJCJ7NYqBbTu459QeGMXROztaRu4YfI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ohxFg2jiejTIZNJn4nyv1HfPX6nA2Sp2ga/Kg2K2d71qfcfTE0dLAL1Dprv+wUmRE
         dydhpqjD2t1pqoY7qE2bN50Y8KfhwzcLr/4N/Ie3ESKVcZ1p7iL41rfZWiISt4TVO/
         bw6dPDpZLHvMPITgmyhA9jdicHJfOFQxHFLuOmdE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160484899834.4262.18402207585184220802.tglx@nanos>
References: <160484899473.4262.9790266201913163807.tglx@nanos> <160484899834.4262.18402207585184220802.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160484899834.4262.18402207585184220802.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-11-08
X-PR-Tracked-Commit-Id: 7bdb157cdebbf95a1cd94ed2e01b338714075d00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 100e38914a025a2fc797aa887efee15d812e9f83
Message-Id: <160486017851.13369.7818362578917248753.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Nov 2020 18:29:38 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 08 Nov 2020 15:23:18 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-11-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/100e38914a025a2fc797aa887efee15d812e9f83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
