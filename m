Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8052AACCB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgKHS3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:29:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbgKHS3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:29:38 -0500
Subject: Re: [GIT pull] locking/urgent for 5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604860178;
        bh=GvONS2hXiv1CSmmH3dAYBsDIG1IQfjC+7348zu1gji0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yrA5ZN7IMJax4CKfYzIruP1301hS5lAsIR7gbaWjnRl0/GccaohDLVN8VIipvpmvU
         C9dAQ3yl5/01UmPGmB78l+CATUVbXwwsxE+GjVJGD47cFPPwv+TEv6R2R7qWbFLOIc
         q/x85ISaOyEBM8HXmGhi8ouCzNx+4h8rSFuhFR2M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160484899714.4262.9283526258177769567.tglx@nanos>
References: <160484899473.4262.9790266201913163807.tglx@nanos> <160484899714.4262.9283526258177769567.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160484899714.4262.9283526258177769567.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-11-08
X-PR-Tracked-Commit-Id: 9f5d1c336a10c0d24e83e40b4c1b9539f7dba627
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aaaaa7ecdc0b46fe56e8192545321ce44d85236e
Message-Id: <160486017832.13369.11356906620974836521.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Nov 2020 18:29:38 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 08 Nov 2020 15:23:17 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-11-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aaaaa7ecdc0b46fe56e8192545321ce44d85236e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
