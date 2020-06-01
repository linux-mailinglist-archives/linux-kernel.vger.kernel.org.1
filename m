Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA341EB156
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 23:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgFAVzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 17:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728941AbgFAVzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:55:14 -0400
Subject: Re: [GIT PULL] x86/vdso updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591048514;
        bh=rEf1VyO6kyKT8NiSbIPmfQgh86GWtO8mI6sskatWuQc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ggfoPl1TTr7kGzj1+Xjv5ZuE6hilp6oq0mXg1zXl3rCv3hNaGajS4WtaCqiBT30s6
         KpEMm5PVFA4Qq4sJpsPqGhKzu8uLSDln6yrQ8TnqbeX33scja51LUovb3+HMkUin3+
         OVTBvMP4hucwrG0bKNxgQgWqzXRGAhX2r5d0nfHc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601170704.GA1438757@gmail.com>
References: <20200601170704.GA1438757@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601170704.GA1438757@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-vdso-2020-06-01
X-PR-Tracked-Commit-Id: cd2f45b7514cdddabbf3f81a98a20ae02f99efa1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e909124f8ed54b13e07e42273c3452b7deb5a0b
Message-Id: <159104851444.21074.2067731077314563047.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 21:55:14 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 19:07:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-vdso-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e909124f8ed54b13e07e42273c3452b7deb5a0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
