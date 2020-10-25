Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F6029831F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 19:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418162AbgJYSf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 14:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1418136AbgJYSfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 14:35:22 -0400
Subject: Re: [GIT PULL] prandom32 changes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603650922;
        bh=QZuYprvWMKvDaL9WaUVHvp2OapmaEW30gpxl+i0UEEc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EnhRXhs0tJH5KK5auUxIXRBHylkN6rEzUWaiCvcRzc+FZ2/flQqsGf7LB2nNG47um
         jbVMghtdmWA1e00H6gM3oPoVT3lUa51kSOA/34zRud+cFJKs4BBXPrZUzNtiJUQirT
         UfjvvZjKaCK5Nwo+iK6uW3Dx6AKxvmBD+NCMsN90=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201024193447.GA13462@1wt.eu>
References: <20201024193447.GA13462@1wt.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201024193447.GA13462@1wt.eu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/prandom.git tags/20201024-v4-5.10
X-PR-Tracked-Commit-Id: c6e169bc146a76d5ccbf4d3825f705414352bd03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91f28da8c9a054286d6917ce191349455c479478
Message-Id: <160365092255.20889.16183952900349594441.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Oct 2020 18:35:22 +0000
To:     Willy Tarreau <w@1wt.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        George Spelvin <lkml@sdf.org>,
        Amit Klein <aksecurity@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, tytso@mit.edu,
        Florian Westphal <fw@strlen.de>,
        Marc Plumb <lkml.mplumb@gmail.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 24 Oct 2020 21:34:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/prandom.git tags/20201024-v4-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91f28da8c9a054286d6917ce191349455c479478

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
