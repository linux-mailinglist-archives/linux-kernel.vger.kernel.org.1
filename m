Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCC02BC979
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 22:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgKVVJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 16:09:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbgKVVJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:09:11 -0500
Subject: Re: [GIT PULL] x86/urgent for v5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606079350;
        bh=JsO013VDDrfx8XCA4FdAn46MsiUXE4KHmwSaLLWg7tY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BTV6I33lmeYS80NawcJd0ZzhPS1WgJNRBmI+QWPXX0F9hVAUeyKm3hOOwe0qaUDay
         BLKR4PRdVLhWyXPTDZR9tctDG4VCJ9Oec89hUCNbDSvyV58TujY2S5kSQZ/LDHZ7v/
         FM5+bB5pu692ozPQXxSLGvsjaPFQqOCmTgWGbqso=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201122105405.GA20595@zn.tnic>
References: <20201122105405.GA20595@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201122105405.GA20595@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.10-rc5
X-PR-Tracked-Commit-Id: 01cf158e48d2b5ce947430de5896c10f4f7c1822
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d53be55c9d78feb38b29fbcaf77af1343549cf1
Message-Id: <160607935064.25428.9774979445643487209.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Nov 2020 21:09:10 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Nov 2020 11:54:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d53be55c9d78feb38b29fbcaf77af1343549cf1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
