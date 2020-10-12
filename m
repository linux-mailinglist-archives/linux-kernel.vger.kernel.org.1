Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9215728C4CD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389938AbgJLWeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389711AbgJLWeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:34:04 -0400
Subject: Re: [GIT PULL] x86/hyperv change for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602542044;
        bh=Q4mtHWkPn5l3FFnjd4oAqMcHLq155+DegZoygjaJBl0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JPlcIItq2axGFaU3K8QdYQ7L1jEQt79bbp54iEsOQUJsEqNtEIJuN3W7WJWf6EkRU
         yjVCav6ly9tN+Y9Qk5SVLgYJR5BDKfSjx8lxgdgCNb7EebeJZfKTucnRJ8aK8pugTJ
         3U7ZYp5q8QRCU08bwjzHv3xEG5E3hbmDYh78XcKc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012174611.GA3060077@gmail.com>
References: <20201012174611.GA3060077@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012174611.GA3060077@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-hyperv-2020-10-12
X-PR-Tracked-Commit-Id: dfc53baae3c6a165a35735b789e3e083786271d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2646fb032f511862312ec8eb7f774aaededf310d
Message-Id: <160254204397.4463.14628249579388814222.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 22:34:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 19:46:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-hyperv-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2646fb032f511862312ec8eb7f774aaededf310d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
