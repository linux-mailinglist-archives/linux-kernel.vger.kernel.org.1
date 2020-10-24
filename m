Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE60297E36
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 21:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764110AbgJXThX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 15:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764095AbgJXThW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 15:37:22 -0400
Subject: Re: [GIT PULL] x86/seves fixes for v5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603568242;
        bh=rss86u1NIcD3VynZsNFIkz0Dz3BQrqRkFl11N/hM2Tk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F3kxIyMEfrEIm0ZlPD0eo2yX81esYsU3hvv3mcHy7D0uz3EQSHvMLktELDpI8LOos
         xshICQwN/vdcBsE0vDjgB2WzvEGSuGa6k58lHaYrMAriOyhW8Apn0QRf08GA6NRR6L
         e/2nUEZVzYdNrRLjW0+DhbZQ3ciSYZbV9k9YvQWI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201024092323.GA15609@zn.tnic>
References: <20201024092323.GA15609@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201024092323.GA15609@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_seves_fixes_for_v5.10_rc1
X-PR-Tracked-Commit-Id: b17a45b6e53f6613118b2e5cfc4a992cc50deb2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c51ae1247262d4b19451ded1107d9b1b69c57541
Message-Id: <160356824214.4617.10689325527161580770.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Oct 2020 19:37:22 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 24 Oct 2020 11:23:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_seves_fixes_for_v5.10_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c51ae1247262d4b19451ded1107d9b1b69c57541

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
