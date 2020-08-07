Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3369523F3DA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 22:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHGUjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 16:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:32900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgHGUjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:39:11 -0400
Subject: Re: [GIT PULL] clk changes for the merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596832751;
        bh=dRwTYsV8FqBTnauHQ5CpovYc7nJ4nSfcDQKup6cFQsc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lUXn5NCNuAYHAbO7LeM0dKgwJTJDWo0BZrmsbNNaeL6ame3O+dooyW5LFroEKPHqm
         wilyOE91tzNVqn5qUesgA/wGMbLURRPojRTUvMyCjlphZXhyixApKkdAtU1/FANq8H
         YH7J4En6g41MecWdftqOdESrURTX01SHNUPTyANs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200807200219.463265-1-sboyd@kernel.org>
References: <20200807200219.463265-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200807200219.463265-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 63e95849a774140ea0825f99be35765758bb7341
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30185b69a2d533c4ba6ca926b8390ce7de495e29
Message-Id: <159683275097.2860.2934164192765950481.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 20:39:10 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  7 Aug 2020 13:02:19 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30185b69a2d533c4ba6ca926b8390ce7de495e29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
