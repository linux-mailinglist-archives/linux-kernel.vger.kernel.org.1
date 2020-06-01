Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A091F1EB14F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 23:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgFAVzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 17:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728888AbgFAVzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:55:12 -0400
Subject: Re: [GIT PULL] x86/cpu changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591048512;
        bh=OhUVbkfcB6YaNRT9UzZ39iI0AhLkNb+kECvrMW6rR+U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=e53gdMfe2Hh4UlZi0ZvwTcTXiRk4vHE9HqZNHOTwTqtlbG2S8Bus0B0bbzh05crni
         Bqzh48PgcSJnMdD68v3AZpx6+mQJrsWY8Acjapa8H/6+8iwmRMJGfvb4oENIEmTcwS
         9AZC6Sg45VgQmMnSgusOUE8MgbKkjbdnrwlGRm+g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601164326.GA1260535@gmail.com>
References: <20200601164326.GA1260535@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601164326.GA1260535@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-2020-06-01
X-PR-Tracked-Commit-Id: 3d81b3d1e55a518837c3d1f722c6d93abe34aa85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eff5ddadab04dc7ae8c4588dd3eef2ecad770fd7
Message-Id: <159104851231.21074.7119545738940446872.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 21:55:12 +0000
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

The pull request you sent on Mon, 1 Jun 2020 18:43:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eff5ddadab04dc7ae8c4588dd3eef2ecad770fd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
