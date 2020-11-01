Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFAA2A20BA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 19:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbgKASJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 13:09:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbgKASJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 13:09:01 -0500
Subject: Re: [GIT PULL] Driver core / Documentation fixes for 5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604254140;
        bh=4GdfmN8v8R/aObe/s8Ixi8rAx3fRGu2DAgmBmEtlD7Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0VnsykE311b9GS/Bu7OVV5gKatbDiOJ5dLtGn2SZHYTkl1aKsDlm9XEU7UGi+l1wx
         O3ZwoR4j+4PCiQHwJNg58EHWjuExQftPqj+WrAoFNaLn0j24k9WbA07+LhpJjIwIao
         fdQd9zkOm/rCwM47kL9C8hr3IfBempj/vuGDGves=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201101131100.GA4127706@kroah.com>
References: <20201101131100.GA4127706@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201101131100.GA4127706@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.10-rc2
X-PR-Tracked-Commit-Id: 2fcce37a3d2f2f3d7fa36aad2b71cbaca135ffd4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c75b68b91ff010d8d4c703b93954f605e2ef516
Message-Id: <160425414082.10555.4777743555924714210.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Nov 2020 18:09:00 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Nov 2020 14:11:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c75b68b91ff010d8d4c703b93954f605e2ef516

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
