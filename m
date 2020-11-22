Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF2E2BC993
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 22:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgKVVfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 16:35:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgKVVfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:35:12 -0500
Subject: Re: [GIT pull] perf/urgent for v5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606080912;
        bh=4A+r/R3X9nBI+cgwFAnthLBwn3uf8Dx3Ynd++/L4Xe0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=n7fhVDfSVhys+db4qL1jKhEGBxGvMYdGlZJILlu5s9SBg32g3u8lfqRe52JV1WSxZ
         Go9noXxFFSOuKMWNYZJE5eT//LZNUEiFu+a2prRhbT5iKVYZoOOneptitCzyY6wjg2
         t+Cw9PAeWNpWyHUin7wKlvl6jJFKkmOHkMMO9tQU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160605644421.9003.5813075622428010861.tglx@nanos>
References: <160605644301.9003.16302947389602369819.tglx@nanos> <160605644421.9003.5813075622428010861.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160605644421.9003.5813075622428010861.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-11-22
X-PR-Tracked-Commit-Id: ebd19fc372e3e78bf165f230e7c084e304441c08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48da33058975f3a3084390dbef6aecd9bda7db62
Message-Id: <160608091219.6067.4541080382960897738.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Nov 2020 21:35:12 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Nov 2020 14:47:24 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-11-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48da33058975f3a3084390dbef6aecd9bda7db62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
