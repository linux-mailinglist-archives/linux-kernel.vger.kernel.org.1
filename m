Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3031A2891BF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 21:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390696AbgJITby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 15:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390680AbgJITbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 15:31:51 -0400
Subject: Re: [GIT PULL] RISC-V Fixes for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602271910;
        bh=XjUqn/WLEETIlZm9GYVr8hFaVARPWtUKhWYC7ECP2xs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z7zt9DGCTzcNlE38lugQzlcDyKa0SXStTpUCrU/usHhDNMgEB9pYMm0VNhhcNjy9D
         r+B+BAtK+oFwq0/9CkmuUcphNy5FD4udO95Xx04TtCbUuhOINf/aQR/rOPmb7Rh3jT
         WVzOhskqoWaUup0G7kD5nwUa1zKawkm6maiPpWX8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-9c92c420-8192-474d-906c-3f43e1f4d7e0@palmerdabbelt-glaptop1>
References: <mhng-9c92c420-8192-474d-906c-3f43e1f4d7e0@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-9c92c420-8192-474d-906c-3f43e1f4d7e0@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.9
X-PR-Tracked-Commit-Id: 84814460eef9af0fb56a4698341c9cb7996a6312
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a5f78d98c26c8e2a79ea37224435d2b434453e1
Message-Id: <160227191066.24155.10357688116532044680.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Oct 2020 19:31:50 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 09 Oct 2020 10:52:09 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a5f78d98c26c8e2a79ea37224435d2b434453e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
