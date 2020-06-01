Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C991EB157
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 23:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgFAVzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 17:55:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728910AbgFAVzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:55:13 -0400
Subject: Re: [GIT PULL] x86/fpu changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591048513;
        bh=QRpNpng9IVYGc0wEb8Rrbye2X30uHMn3/QeYgkESjJE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hkn71psGvwMINNR2umj/NG6kk/rZErqBww5LU1BWj2fg7zBTOy1Uc2uqCN0L2k0YU
         ew/24FNZbqu+jqgoaIlljKppAbpeFGqvK0o6fYALrgiOEcAJjxnzOBBpMejlkfkvg2
         LlfVnoXa9IA/clDw5SZAmrIY8+Ut97L50/7YH/rU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601165425.GA1303742@gmail.com>
References: <20200601165425.GA1303742@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601165425.GA1303742@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2020-06-01
X-PR-Tracked-Commit-Id: 55e00fb66fd5048f4a3ee357018fd26fc527abca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a319ef75d931de0b21882ec17d8d70ece0aa871
Message-Id: <159104851298.21074.7267184058609079302.pr-tracker-bot@kernel.org>
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

The pull request you sent on Mon, 1 Jun 2020 18:54:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a319ef75d931de0b21882ec17d8d70ece0aa871

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
