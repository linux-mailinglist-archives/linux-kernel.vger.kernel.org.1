Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6063228A946
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 20:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgJKSX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 14:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbgJKSX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 14:23:57 -0400
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602440637;
        bh=D2HL/T5GT7lO4h+h/nTx4VtdlA4OQezXxu4t/GvpSlY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nV4pDoT+E2rS5yMe28p5C1oBwncKf6C8QqNJjQ0D4DQ9KRdb7+7Xr4rFdkgjniJ6U
         f1c6hxCxdWszOxjiMpm2aFdigOM9EgskO6pn3esSOgyiftsusyWP265qRw9VQkGZyq
         SwxCYbP7lkEPrDpBYm4jTSoegNyQNTz+wz3roopY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201011080859.GA3598074@gmail.com>
References: <20201011080859.GA3598074@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201011080859.GA3598074@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-10-11
X-PR-Tracked-Commit-Id: 0c7689830e907668288a1a1da84dca66dbdb4728
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c120ec12e216225f7536cc1b924fe428ff64b5bd
Message-Id: <160244063702.8522.8900971040891011022.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Oct 2020 18:23:57 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Oct 2020 10:08:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-10-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c120ec12e216225f7536cc1b924fe428ff64b5bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
