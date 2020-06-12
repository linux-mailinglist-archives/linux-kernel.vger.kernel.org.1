Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA831F70FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 01:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgFKXp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 19:45:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgFKXpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:45:23 -0400
Subject: Re: [GIT pull] timers/urgent for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591919123;
        bh=aqGD3yzjEkWHikfIInuK6ESkMK1leqzMdpUYRUNUfRs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=S9e0C/MjTwSOXkvKmvaspPRE5LPW/yT1/xKyqFqNYlLCFIP99QlMu2uCkQyBHoQ2k
         Nm1TdFJJ/NpMx7qg7RioeGBb0JNhpfVujQYmCoHdXnofv9RS7ibj74kgSehPguhT2s
         d4JTDpRKlh3+b9t701WirtkDI+XAqHFcaxZzcHjM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159190118210.28418.16838792857524354792.tglx@nanos.tec.linutronix.de>
References: <159190118210.28418.16838792857524354792.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159190118210.28418.16838792857524354792.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-2020-06-11
X-PR-Tracked-Commit-Id: b91c8c42ffdd5c983923edb38b3c3e112bfe6263
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92ac971219a29336e466921156b16f8fa88d91aa
Message-Id: <159191912339.19194.1005607187534682995.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 23:45:23 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jun 2020 18:46:22 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-06-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92ac971219a29336e466921156b16f8fa88d91aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
