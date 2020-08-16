Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9120245561
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 03:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgHPBzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 21:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729743AbgHPBzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 21:55:36 -0400
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597542936;
        bh=L1iIUq2dSU8YpvDhMXodINtM5bnR7etHdP9EiDOhCis=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EN3T7T+99qKiYBtFMa3zbeYKeENbJBPNmkDYvNx9Ij1zQoRrwAFE7aTVrceq982TS
         kGKxZapJKM/WQ3Mdah0diDZMlsdXshEDg4Y4Cqgcv2U5ETZQsi8GLUO2b2dH44THRP
         jXfDoaNbEf+OWmqyZ4am2FwFiFLQbOK5IpxvLcZs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200815114552.GA2643023@gmail.com>
References: <20200815114552.GA2643023@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200815114552.GA2643023@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-08-15
X-PR-Tracked-Commit-Id: a6d996cbd38b42341ad3fce74506b9fdc280e395
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50f6c7dbd973092d8e5f3c89f29eb4bea19fdebd
Message-Id: <159754293628.18953.936544159903853744.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Aug 2020 01:55:36 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Aug 2020 13:45:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-08-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50f6c7dbd973092d8e5f3c89f29eb4bea19fdebd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
