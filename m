Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575C31EAFB0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 21:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgFATfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 15:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729474AbgFATfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:35:11 -0400
Subject: Re: [GIT PULL] printk for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591040111;
        bh=rJ7eVYKvlkksQRrsecJxr7pwGhfj81Mj6zreXm80pRk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ans4VisrRpXE2N1Gy+sNak494z1tczM1rM62FwgpSv8q8QcydAHh4nsgp5H74cY69
         TEuuYG9Hf48k2611uH7vKheZ+CPK7FfuBM+OC2cRZO2uAaRokTNh+GzG1Ch8qJeFTa
         n8Sv+51oMnO/YPg2dQmcDPn2dXxGOGZ1sL3sjfVk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601114724.GE27273@linux-b0ei>
References: <20200601114724.GE27273@linux-b0ei>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601114724.GE27273@linux-b0ei>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux
 tags/printk-for-5.8
X-PR-Tracked-Commit-Id: 8b390ab725fddc443bb0082a6c67e82e25bfba7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca1f5df23f28228c46aa45d934abad38c6b6ff2e
Message-Id: <159104011104.18844.13431532108992345837.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 19:35:11 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 13:47:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux tags/printk-for-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca1f5df23f28228c46aa45d934abad38c6b6ff2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
