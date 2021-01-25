Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9340302C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbhAYU1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:27:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbhAYU0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:26:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4E41922582;
        Mon, 25 Jan 2021 20:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611606358;
        bh=/umDtUOr18i+5kdpH8cDDCXYCUzQ8EB4QI8YgMuDx/0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fxl3DcosDIX9+MAi2bX8LWPK8ReDBPs/wLK7PmIzxJ6aP4RjW1D9fRZoztcHacKMG
         39yIQU3b24Di/tPKMa7cfYjCNJmAdz+ZQcgF90GQec8fTR/30/zXS8CA2J41J07bZT
         Ehw7QwrDsAzdLSekTbOcTk0btr8A8C1qQzZQ/SRVArESvJKu6q3kGzOQE+lgTqVMdH
         nLzKsabczPzKPTM2O+Be0EqKcRfcbwX/WFn66uG4uK/5GoCWpqb8JjFjaEY3wYdbiD
         nuW2zM3d8aSZpJ2cJHogEg5PPv5DTWZOkqj+FbZPCfM/fu0sWogOt7VJe+k2q3ARtq
         9CxJQhKXrKqaA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 39CCF61E38;
        Mon, 25 Jan 2021 20:25:58 +0000 (UTC)
Subject: Re: [GIT PULL] printk urgent fix for 5.11-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YA7Y1WIjM3Oy2O7Y@alley>
References: <YA7Y1WIjM3Oy2O7Y@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YA7Y1WIjM3Oy2O7Y@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.11-urgent-fixup
X-PR-Tracked-Commit-Id: 61bb17da44a0b6d079e68872e3569bb3eda17656
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 007ad27d7bafc6df36e1d6ad4a13f6d602376193
Message-Id: <161160635814.7553.16773013877295301535.pr-tracker-bot@kernel.org>
Date:   Mon, 25 Jan 2021 20:25:58 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Sven Schnelle <svens@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Jan 2021 15:42:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.11-urgent-fixup

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/007ad27d7bafc6df36e1d6ad4a13f6d602376193

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
