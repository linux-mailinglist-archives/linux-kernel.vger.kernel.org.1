Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061E72DB683
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 23:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbgLOWYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 17:24:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730231AbgLOWW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:22:59 -0500
Subject: Re: [GIT PULL] Char/Misc driver changes for 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608070939;
        bh=YvZ7zr8KAXSqXJCThOs7n8XO/7Rk9hd1X7PyYHYFpMw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=q1ZMZXgALX8tU7hFdSrBbxd+vRlz/T0EOf4+oC5yhhw1RQSuvPGcQZHq1TbRDfmqP
         hyQ3Z8LjX9Vc4HGyRirRx2ABkzheNnpU0yqyGwtIRPylPM0FBI0TTvtk4B5hnDFNp3
         APIssS0BYPFkIncNuC5fO1WnXu5I0nOaRnKVWF45w6PPkpi1n2rtugB4mUGqwDFN9M
         hBT0pDGfo8kalR60WBNQU8dDr/FNyL0UQ3qqJOfuRnaD7BfjG90Bl9m2UXrTcFG19N
         b/PpT6epAGHwaFe/Jx9ayKSH5Rm79QkL9U163vSwUVpAH0HrLGe+5C3tAVYqzD66YB
         lsmglJEEzfePg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X9iN/jha9nVkuvEH@kroah.com>
References: <X9iN/jha9nVkuvEH@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X9iN/jha9nVkuvEH@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.11-rc1
X-PR-Tracked-Commit-Id: 93f998879cd95b3e4f2836e7b17d6d5ae035cf90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2911ed9f47b47cb5ab87d03314b3b9fe008e607f
Message-Id: <160807093930.3012.8620945917698676683.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 22:22:19 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 11:20:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2911ed9f47b47cb5ab87d03314b3b9fe008e607f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
