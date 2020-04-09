Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFFE1A3994
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 20:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDISKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 14:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDISKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:10:25 -0400
Subject: Re: [GIT PULL] RISC-V Patches for the 5.7 Merge Window, Part 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586455825;
        bh=B7RUtCBPZKX84O+0Z5V9oHgttKAZYDn1KUEbea7jZrg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Rq6mSVEPHex22D244FDL6hv8aP2rgqtQ3VlRHD/Oy8ms5COxKjeSfSczUKB2l4SHg
         DoUtyu/V88s2WdDAXnMFkGD0yHSaVGgFYqOvbj7T5UkCA3AkJL9IiLSjyFkM6Gu183
         LBpBHsUzLa/mZtGQpCd3MhuEXLoyhwhdQJ8Cg6TI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-e58ec1f9-86f2-451e-ac9f-9add83693752@palmerdabbelt-glaptop1>
References: <mhng-e58ec1f9-86f2-451e-ac9f-9add83693752@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-e58ec1f9-86f2-451e-ac9f-9add83693752@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv-for-linus-5.7
X-PR-Tracked-Commit-Id: 37809df4b1c88927fe944eb766e0553811c51f64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eab40026605f4717a9749ffcaec8119d58494999
Message-Id: <158645582569.26793.3517177779619991218.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Apr 2020 18:10:25 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 08 Apr 2020 09:50:05 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eab40026605f4717a9749ffcaec8119d58494999

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
