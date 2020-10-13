Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED89928D4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 21:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbgJMTrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 15:47:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbgJMTrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 15:47:10 -0400
Subject: Re: [GIT PULL] x86/urgent for v5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602618430;
        bh=BrWxwAQ3UpsXIK1Qj+KcuBmrCv+VPA6IPBVm3f2FSrY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=g7Kx+7IBfpVb9z2ltADZrzAck4I55iw3mOoN5U3d4CkRnxCWEyHgxilJmoYzli+iF
         dBwZIEWQGGeb55tm4SjVN4cTUnfEFMKXaJGJ0Gv3RJvHH8LFag7FoWsGajJpbm9+rm
         9F5Miz2AtqwdQgD/wGxROeeio1WIIO7gd9aA6Ugk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201013173615.GI32151@zn.tnic>
References: <20201013173615.GI32151@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201013173615.GI32151@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.10-rc1
X-PR-Tracked-Commit-Id: 081dd68c89061077930ec7776d98837cb64b0405
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 857d64485e7c920364688a8a6dd0ffe5774327b6
Message-Id: <160261843025.30654.8440030195877157741.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 19:47:10 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Oct 2020 19:36:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/857d64485e7c920364688a8a6dd0ffe5774327b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
