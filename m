Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BD91B92B2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 20:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgDZSPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 14:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgDZSPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:15:18 -0400
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587924917;
        bh=+70Nkhy1Sm1u0LTpVo+LhJHx0taDHWiTc7WBnW9U+7k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nl42cEOElev+Nqe/qbznp9eB/QSIY7vjcWskzbTScJCKEME1lK1ck7Zda0HS/bUZE
         V5jhpEGVOr9xU0zviSK7R+9vkq3GoDljk5JLjuuaIXP2cnjv7aP6RqsToS2w3hZYp2
         AAHDqOSNgaNDWX5FKGzRWtd5OVZX1po0WI1m2iig=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200426104730.GA2120674@kroah.com>
References: <20200426104730.GA2120674@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200426104730.GA2120674@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 staging-5.7-rc3
X-PR-Tracked-Commit-Id: 664ba5180234593b4b8517530e8198bf2f7359e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: edf17b283844a21b338b9618107c8817105d0ffa
Message-Id: <158792491776.6795.10238582975247910789.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Apr 2020 18:15:17 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Apr 2020 12:47:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git staging-5.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/edf17b283844a21b338b9618107c8817105d0ffa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
