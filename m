Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3A92C7B15
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 21:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbgK2UGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 15:06:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbgK2UGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 15:06:48 -0500
Subject: Re: [GIT pull] irq/urgent for v5.10-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606680367;
        bh=rrAPyoRPFVSM8PYBmuoG4yfIH13GIQ1CFX5f1J28w4Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=D6dkIuXmwGqYQ5/LUm5LcUnIz4qeGqhu+JWaPvf/S1V2c8itXI0Y4cHuHouCm/ydK
         1ppMcJ2lg4zgxYmy4M9HXNkOYqE58IkmY8egiTl+GV7/1w8TjeSI6iCbCOf8l0AIz7
         X4ff8boA0d+QPuNsZXX7O6g+/CibmusqlwgkEWrE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160665707945.2808.5384034634184489471.tglx@nanos>
References: <160665707945.2808.5384034634184489471.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160665707945.2808.5384034634184489471.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-11-29
X-PR-Tracked-Commit-Id: 7032908cd5842af9710de4815a456241b5e6d2d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b7a51ba2637ee53ce90624f5f98aaf8ec9b2bcc
Message-Id: <160668036765.1296.16518748535431958528.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Nov 2020 20:06:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Nov 2020 13:37:59 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-11-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b7a51ba2637ee53ce90624f5f98aaf8ec9b2bcc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
