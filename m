Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB772DC839
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 22:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbgLPVST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 16:18:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbgLPVST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 16:18:19 -0500
Subject: Re: [GIT PULL] TIF_NOTIFY_SIGNAL for all archs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608153459;
        bh=5Qh6wRm7kb2uXkzcTXtaNOjQjwCTDBY9f2vn96qzSjg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gy6s0eXa3KQ2k+/KVNpKlvG+P0h5bUphC3k9LC3lljOkU9MGajN3WkpxQHG71mscW
         ddbgXg5BFERhzoVBJywpbvDBCj4oiGY3nz/h+/z2Wb9IKfgkTpvceC2sxs+EypDKX1
         FHDCfoP5ix6TSFtmxTSMaFGBPNX9/AAD8626hrRCx1kn8R8i2ALxQVekSomyv5UQWl
         w033KZESynfDA3csbKCqCZQWyRKtJf87+Xd63hBxRfxmcBimlFV47pV3/U2aie9wFN
         SZe/ystorNTDT/1oCmkoqOmeB9g8nQafZihSCbkxqli89ZKIrUUG7bDJrScPp5dQs8
         jD5gBt/Rhq9Wg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <701d4747-bbbb-dbb4-d828-63d096fcc22a@kernel.dk>
References: <701d4747-bbbb-dbb4-d828-63d096fcc22a@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <701d4747-bbbb-dbb4-d828-63d096fcc22a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/tif-task_work.arch-2020-12-14
X-PR-Tracked-Commit-Id: 355fb9e2b78e78b38ec00f5cd9b05c6aceb98335
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 005b2a9dc819a1265a8c765595f8f6d88d6173d9
Message-Id: <160815345901.27795.2544235487408028611.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 21:17:39 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 16 Dec 2020 07:33:42 -0700:

> git://git.kernel.dk/linux-block.git tags/tif-task_work.arch-2020-12-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/005b2a9dc819a1265a8c765595f8f6d88d6173d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
