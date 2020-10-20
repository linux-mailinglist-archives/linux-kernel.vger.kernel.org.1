Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A390A2932A7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389939AbgJTBX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389930AbgJTBX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:23:57 -0400
Subject: Re: [GIT PULL] RISC-V Patches for the 5.10 Merge Window, Part 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603157037;
        bh=8YU5BxjIiCakWZtXMxohss3vO+KoC5NyEtvOpJBfeNs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZzxV2FWe79YpQe95xCDlAuATpZ/TU/90elY21zmczaQks8Oi3rVjeGEKmH89OlQYG
         ANwSwZA9SK5WQlZqwQTnhzT4zcnM8KI2iCQ7owtNhDeWUjf6UY3m3h67AWKGTibXCY
         Yc7lQVm5lrZR5KdzsnfTVw5Zq6EyeKhZfPW5ROBI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-a46615be-f4b5-4861-81b2-f370964a9583@palmerdabbelt-glaptop1>
References: <mhng-a46615be-f4b5-4861-81b2-f370964a9583@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-a46615be-f4b5-4861-81b2-f370964a9583@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.10-mw0
X-PR-Tracked-Commit-Id: de22d2107ced3cc5355cc9dbbd85e44183546bd5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 270315b8235e3d10c2e360cff56c2f9e0915a252
Message-Id: <160315703718.30490.7776981538558466127.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Oct 2020 01:23:57 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 19 Oct 2020 12:08:11 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.10-mw0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/270315b8235e3d10c2e360cff56c2f9e0915a252

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
