Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A282A87EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbgKEUVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:21:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732234AbgKEUV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:21:26 -0500
Subject: Re: [GIT PULL] tracing: Fixes for v5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604607685;
        bh=K0CRf6byo/mvZPq2rOGzKurwhqQ5gOTK2Z44v+xeSr0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LpgVB8Pxo6QG36NaVm1FEecboE/NM6e0fK4JlUrxFAlzGyOnjV7eU5qStullfdXqL
         z02IOVfmpFGt5zQxtvWklN+m6UHf3bnuQyuSq6V6Ch7uh+LOC8aFQ2IQF2cmhf44PW
         ExKDLgtjgMVmHXCE4ziCxHWCpyugP4idXAG0NNAE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201105114602.2f4c655e@gandalf.local.home>
References: <20201105114602.2f4c655e@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201105114602.2f4c655e@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.10-rc2
X-PR-Tracked-Commit-Id: 645f224e7ba2f4200bf163153d384ceb0de5462e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3249fe45639afb0a025847d611dac692010822a8
Message-Id: <160460768581.18865.13237515001638133048.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Nov 2020 20:21:25 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qiujun Huang <hqjagain@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 5 Nov 2020 11:46:02 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3249fe45639afb0a025847d611dac692010822a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
