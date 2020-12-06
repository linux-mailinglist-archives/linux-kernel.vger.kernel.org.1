Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C7E2D0701
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 20:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgLFTxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 14:53:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgLFTxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 14:53:22 -0500
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.10-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607284362;
        bh=ZlfUnxbFI82g+TuP66uUc/HJpmt2j3zX1RaAUoF+h1o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=C5jWgQx34AJXTcturXhKHjlB+LPdSanhIvdb9OU1+HjtqSMqoPiRyaeKX/aFuimEu
         1gCoFQyN4s1j1xBIVbtj46SFvSnZH2XhwWu+lSe5jAYzlierucs27MwjMsTU5/gX6H
         0QsdUDw46rgVCYA8Hc0my2zyLtS2LmLbG7eANGV/5JfoExdvictLMZ3oBj8AONDRwU
         TxEefb838/vVfBRqPZYT1EyFGb9+TC2lm9ROXXKr3Bq5LnsebwJ1wemAwTKvGn6RER
         FMUjQE9MwxMvWPjNqcXHBnT5BGHOAnBXl/fjDhx8O+gTEWP4qVR06hZH7UU4b4BVWL
         eMnabi5CZLuYQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X8zsZCwxs6Oas7rJ@kroah.com>
References: <X8zsZCwxs6Oas7rJ@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X8zsZCwxs6Oas7rJ@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.10-rc7
X-PR-Tracked-Commit-Id: 264f53b41946dcabb2b3304190839ab5670c7825
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab91292cb3e9f43d9c6839d7572d17b35bc21710
Message-Id: <160728436226.18476.4209696553179684973.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Dec 2020 19:52:42 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 6 Dec 2020 15:36:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.10-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab91292cb3e9f43d9c6839d7572d17b35bc21710

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
