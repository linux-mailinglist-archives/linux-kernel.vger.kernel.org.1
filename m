Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6800A2C71BF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391161AbgK1WBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 17:01:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391087AbgK1WAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 17:00:48 -0500
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.10-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606600808;
        bh=hqIKgv/ci9yCQp5U+PKDVvC0WXqLtOjCj+2u2X+pDFU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=14RozPNZIDw/cJLrsTC0CCz4vOawPcSIU6haWFms6Wff7P1zwLN3kKOktqsSs93K6
         8Fgo2KHIfhHGY4lXgc0Zxm4hK4Kqt9iaQxdRremDUKSAi8qaXTqnBfKz24LskrlfRb
         1OfewAbSc4dboJtXLSXGK6pY9cjkABmRZ2YLi+2Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X8JBDK8P6ZiKrvav@kroah.com>
References: <X8JBDK8P6ZiKrvav@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X8JBDK8P6ZiKrvav@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.10-rc6
X-PR-Tracked-Commit-Id: c7acb6b9c07b4b75dffadc3b6466b1b43b3fda21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b2c800d6695d91df9208ba416fff59c8b0fc608
Message-Id: <160660080833.28096.1420006747445375900.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Nov 2020 22:00:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Nov 2020 13:22:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b2c800d6695d91df9208ba416fff59c8b0fc608

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
