Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3042BC97C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 22:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgKVVJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 16:09:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbgKVVJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:09:11 -0500
Subject: Re: [GIT PULL] efi/urgent for v5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606079350;
        bh=HKHleSx2sh5fiGF5Ffye5H43LgATVCWVk6J1iasu9+g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=njL4d4M0cQKlxmtAQlSXvgUynHOzMgeTt4TyYsNSksJC/pZLLKITS1oKKATWiE+bi
         2OOYm19nYpcRfQtDQsXVhABTVgQrHFUt1/vRjvdYQFaeoNin6EB6TuDcY+js2cOh7s
         1DNi0xo3X3dY8DFnKqAHLKiuKsKjLJyvIPKeDTgQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201122110155.GB20595@zn.tnic>
References: <20201122110155.GB20595@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201122110155.GB20595@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi-urgent-for-v5.10-rc3
X-PR-Tracked-Commit-Id: c2fe61d8be491ff8188edaf22e838f819999146b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68d3fa235fd83ab0fd36c367c0530d16c764051b
Message-Id: <160607935091.25428.2053976732865589718.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Nov 2020 21:09:10 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Nov 2020 12:01:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi-urgent-for-v5.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68d3fa235fd83ab0fd36c367c0530d16c764051b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
