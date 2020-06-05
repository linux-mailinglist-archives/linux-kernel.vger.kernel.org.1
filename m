Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD481EEFE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 05:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgFEDaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 23:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgFEDaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 23:30:13 -0400
Subject: Re: [GIT PULL] RISC-V Patches for the 5.8 Merge Window, Part 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591327813;
        bh=f24krO+POdhUZh2brHbNdL8tf07c24R7N/ltSJ4tjMk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qfMFzHAHLjdLAyfjm4FDB+S76L7A/E60nWOOgxWqV+XXz8ara1l2+5pxlZqfKBaPx
         Ma3YKnriM0FmMr2UfwIWoR0RTGnV1nnRwDmkSgOXkM3kEGm2ACpS2wwxwheDF3pAze
         HVtqm8dQjJBw4h2LQO5oxESzE/w+Tk5L2EpaTeng=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-8ec4417a-1930-4582-b309-e510ebbfb37c@palmerdabbelt-glaptop1>
References: <mhng-8ec4417a-1930-4582-b309-e510ebbfb37c@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-8ec4417a-1930-4582-b309-e510ebbfb37c@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv-for-linus-5.8-mw0
X-PR-Tracked-Commit-Id: 09c0533d129ce460e6214c14f744ddbac3733889
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 435faf5c218a47fd6258187f62d9bb1009717896
Message-Id: <159132781298.11934.17692023296743029875.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Jun 2020 03:30:12 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 04 Jun 2020 11:57:25 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.8-mw0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/435faf5c218a47fd6258187f62d9bb1009717896

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
