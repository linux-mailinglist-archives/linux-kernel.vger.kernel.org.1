Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2DD2DA65C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 03:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgLOCWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 21:22:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgLOCWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 21:22:31 -0500
Subject: Re: [GIT pull] locking/core for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607998910;
        bh=lbO3+dnirfzOkTFaGK+cpipE7t/w1wp2PZJGhBU7QEM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=D9AMBgEGSwidaoT/BuplkloMgQyQubiLJ3Q7m3YGciHK2FGznKFIapB2/FrxEL+wU
         rS//f+VPd6AXCXyz5T4948kIU7P8lJAeTnOcCpCGxr/2XaIqQStIYnLPAa7GnDSsC1
         0W1MMr85DUH8eUcb8Oy/dD/E4+1rp3ly6KVs7HbK1NqSzO00zBlms2ralm96LdQTcR
         jjIjXzMj20l+GZefaz4uw1tjCxiL6fUXJX9yOj9vcXctXm2f8k5EDwMgBmajbq2xrI
         BeFxTN4/tu8BcniQIHY362O27p5nUbjCY7ThcYtL4GSQsZtkIqpJZHyHmj3nK7WSOZ
         V9C1DXETK/c6A==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160797733425.10793.1616595353462792263.tglx@nanos>
References: <160797732939.10793.9152151866806316627.tglx@nanos> <160797733425.10793.1616595353462792263.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160797733425.10793.1616595353462792263.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2020-12-14
X-PR-Tracked-Commit-Id: cb262935a166bdef0ccfe6e2adffa00c0f2d038a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e857b6fcc5af0fbe042bec7e56a1533fe78ef594
Message-Id: <160799891061.23883.9067015350650364079.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 02:21:50 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 20:22:14 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2020-12-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e857b6fcc5af0fbe042bec7e56a1533fe78ef594

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
