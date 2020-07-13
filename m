Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C0421CAC9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 19:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgGLRkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 13:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729303AbgGLRkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 13:40:03 -0400
Subject: Re: [GIT PULL] RISC-V Fixes for 5.8-rc5 (ideally)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594575603;
        bh=AtfBEdHa/4GZH8vVuyr0o+4ubDXXRcvdrZUNYTTNC70=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j4mgjY7Awa2G9onNZVMzHyVoLYQUgQVjBj8cX//OOTyUqUSRCatMTcLSOYOx+mJ1n
         6xK0H0pjLxOehSRwGoZsJ4W+NB+/qNlMfG6cW5QL0yJEcVCDD7poY6O98F3+nK3aSA
         b/RvblXl1+9OCME6bjvr8GQuvs4pJ5KKUfEdkQnU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-f8b65a3e-17ea-448d-be82-0d1c42c0bf37@palmerdabbelt-glaptop1>
References: <mhng-f8b65a3e-17ea-448d-be82-0d1c42c0bf37@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-f8b65a3e-17ea-448d-be82-0d1c42c0bf37@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv-for-linus-5.8-rc5
X-PR-Tracked-Commit-Id: 70ee5731a40b1f07f151e52c3c4ed27d70d4f9fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9901a6bd157719f9f93186868c527c5ba5edf8e5
Message-Id: <159457560337.22698.5375202992687678340.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Jul 2020 17:40:03 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Jul 2020 13:24:01 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9901a6bd157719f9f93186868c527c5ba5edf8e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
