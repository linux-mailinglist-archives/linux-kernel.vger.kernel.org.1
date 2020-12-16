Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5472DB81D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 02:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgLPBB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 20:01:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgLPBBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 20:01:25 -0500
Subject: Re: [GIT pull V2] irq/core for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608080408;
        bh=0PvyaIeTc8M6A9rmjRBqFUrniVdOyi4jGlEaEFDDELs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sCqLV4xqztMveg/UNkQvh0f8PXZfxOBnkxw8ZoYS+X8lW464slWZtywDWBIpSZet1
         P8Ws2lPBxxWru3AOM3Wr4wKssj7wN5dg1eAne4p31AAroyZY+T3MKfr+17XBQg2QkD
         6QSZC5ZsBEYdnZHrpZqcvjAMkznMcUQHZFSehxcWF71h5OkFo90YeACoMylOXVYGp5
         bGeOB4031fwc6aom48IZjWJJMCySSJOJpglElp6VawBSZ7smtexYbVVDczVy7o9ntD
         AJGsvQ/UzTnR4lmtxm77IldLalz/ip7dxm8au3FmWNwI+KVwwPGq+qbwgV8/vUQHqu
         dUZVOc606kpdw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87pn3bt9v0.fsf@nanos.tec.linutronix.de>
References: <87pn3bt9v0.fsf@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87pn3bt9v0.fsf@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-12-15
X-PR-Tracked-Commit-Id: 3c41e57a1e168d879e923c5583adeae47eec9f64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2cffa11e2aa76a0560c890f057858b68fe744d03
Message-Id: <160808040795.29502.2259324746413597937.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 01:00:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 15:36:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-12-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2cffa11e2aa76a0560c890f057858b68fe744d03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
