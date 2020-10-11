Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A80128A944
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 20:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgJKSX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 14:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbgJKSX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 14:23:57 -0400
Subject: Re: [GIT PULL] perf fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602440636;
        bh=tlSxKIOgUo09XkiVmYyNCtZZp3hglTruINymd9oE7xo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FQyVHlNdxULu68sO3YgDzTbaMZU61dFSTV4kTh2k5hMogmAs76N9jztbDgefEhtV3
         YzdIOtTWFJ4Ir5Rh/flhMghz+ZYnBgsTpSdFWrE45MdGVi7ygiWRE3UMdy1hUwK9Rw
         /wbsjUVLBWJbpEAwv9fjk/DE9pSMIEDE13ssE4/4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201011080015.GA3530982@gmail.com>
References: <20201011080015.GA3530982@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201011080015.GA3530982@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-10-11
X-PR-Tracked-Commit-Id: 6d6b8b9f4fceab7266ca03d194f60ec72bd4b654
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa5c3a2911e6d5feaf0c3c7af5bbc652f129d8b2
Message-Id: <160244063681.8522.14632771486578017221.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Oct 2020 18:23:56 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Oct 2020 10:00:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-10-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa5c3a2911e6d5feaf0c3c7af5bbc652f129d8b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
