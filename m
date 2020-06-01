Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEE41EB155
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 23:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgFAVzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 17:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbgFAVzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:55:09 -0400
Subject: Re: [GIT PULL] perf updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591048508;
        bh=Lw0TXBYNtTiguOomWfukmb/u4Gu/6rcMub1L3ctcpCk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LX2B/8UEOekbVmwQMyncplMQmq4fBDaVNK3BwDzBLvpoqsTMOjq0zta3oFm0qJUzz
         qUaj/HhOIqpza0Y07OQRR7ATQlgGUB3CkuxbYQGTQ3wf/xIp9sLpJJ64zAOPmnOBAq
         7lB9OQ8a/HLXtQEGoPHmivj0Xkwwwn+x0/KK2Nh8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601155437.GA1042527@gmail.com>
References: <20200601155437.GA1042527@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601155437.GA1042527@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-core-2020-06-01
X-PR-Tracked-Commit-Id: 5cde265384cad739b162cf08afba6da8857778bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7092c82042b4ba3000cf7b369d1032161c5d4c9
Message-Id: <159104850880.21074.11282130961291819762.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 21:55:08 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 17:54:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7092c82042b4ba3000cf7b369d1032161c5d4c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
