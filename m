Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2823B1D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 02:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgHDAuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 20:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbgHDAuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:50:05 -0400
Subject: Re: [GIT PULL] x86/alternatives change for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596502204;
        bh=MvTmqQMyw8oLvSFPAAqwEXO8HGAzY6GLT0cpZomfUwQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dn8Ku5Ywcgmpxm2Yy9A7/rywm3SB0JROwH10E8L0V/q5BhNIORtIk5a/L7UOpIVAx
         RxjQFBmtnEeNfcd7RirP+pSLL2EXynrO6eqeFATpAzyofM1rN9IFJpZiaxW1ypdlt+
         Q1oR3JPhethcKO+y7YVWnWtpaD0fFssmOrU6I0PE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803155344.GA696530@gmail.com>
References: <20200803155344.GA696530@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803155344.GA696530@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-alternatives-2020-08-03
X-PR-Tracked-Commit-Id: 1b2e335ebfa2243517e09f99653c78d1936cb6d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97c6f57dc9265a1587895a2d97ba1b1e612c750e
Message-Id: <159650220461.17631.13884630133605194999.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 00:50:04 +0000
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

The pull request you sent on Mon, 3 Aug 2020 17:53:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-alternatives-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97c6f57dc9265a1587895a2d97ba1b1e612c750e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
