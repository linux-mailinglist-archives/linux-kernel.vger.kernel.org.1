Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E585280534
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732885AbgJARaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732096AbgJARaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:30:17 -0400
Subject: Re: [GIT PULL] tracing: A couple of fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601573417;
        bh=nIioqwzksEgTtv6Ko1V6O4EdVV7ET9B4oXyyO0pKNto=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FsOFuIBy9wYjpCFbYtqJtwT4eRHrEQkTsFmhMCXyy8/14YZUutYY11t2cenkYaLPl
         z1yGPELIia3Wbmmam1kVJmE6fWus186zLLao6yXX2vzcsuyyIVwWKsDoeNxicwqKrT
         TT7ztYHI1NoYqN29pcvZFn1vJKINB8Wz6P4grfTU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200930195359.01d9f770@oasis.local.home>
References: <20200930195359.01d9f770@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200930195359.01d9f770@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.9-rc6
X-PR-Tracked-Commit-Id: b40341fad6cc2daa195f8090fd3348f18fff640a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa5ff93523ebc9f4cfd9fb37d021b5204ce14657
Message-Id: <160157341747.4684.1567178110767501573.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Oct 2020 17:30:17 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Sep 2020 19:53:59 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa5ff93523ebc9f4cfd9fb37d021b5204ce14657

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
