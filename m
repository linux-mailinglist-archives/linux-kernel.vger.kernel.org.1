Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1F328E922
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 01:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbgJNXXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 19:23:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbgJNXXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 19:23:10 -0400
Subject: Re: [GIT PULL] SPDX patches for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602717789;
        bh=D6Xc38q7U5HS5tRHvEvQ8e6Ge1zWT7wYn/oM43ugnmc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AJTVReRjDVWIVy3WDywpA6zyacd0U/yzxH1FoKyz/kMduRABhDkUqfa3ZGIaDma6d
         kPJLkMo3yv9gkHqaqiuniiIwx739HABI+aU2yFiAQ9uK5PNjBsjxHRJG0wbBAzcX0t
         DMVfBrL9ZaKPeX7xGw3jD78ZjmceYKEFHR0J8vCU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201014175216.GA3787023@kroah.com>
References: <20201014175216.GA3787023@kroah.com>
X-PR-Tracked-List-Id: <linux-spdx.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201014175216.GA3787023@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-5.10-rc1
X-PR-Tracked-Commit-Id: c5c553850899e2662ecf749ac21fff95d17f59a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e4fb4346c781068610d03c12b16c0cfb0fd24a3
Message-Id: <160271778947.1444.16592289210855819251.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 23:23:09 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Oct 2020 19:52:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e4fb4346c781068610d03c12b16c0cfb0fd24a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
