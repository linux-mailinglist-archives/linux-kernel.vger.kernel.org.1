Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4572C2818ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbgJBRPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbgJBRPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:15:16 -0400
Subject: Re: [GIT PULL] RISC-V Fixes for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601658915;
        bh=2gOw3rFZ0CEbfGZohi7BOoFCnK+ojgeKb24AibqNMbw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=D6lMdS7+DoASzODjoms90StZeNk5uGOiBZFDU/8C3MZJlPirVUh+J903Uo5HcTzTI
         s2pxZZJB9+cUnGLaT3VGrJWcnjNb++7iHyMCdKX+Liog4IMFsgq/vmVML6Kly1YKVy
         nheYTiSq8z3uF9m/spMRfLTwDlAGb8saRg5jNun8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-c32d6fbf-32dd-45ed-90f1-ffbb7e455aaa@palmerdabbelt-glaptop1>
References: <mhng-c32d6fbf-32dd-45ed-90f1-ffbb7e455aaa@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-c32d6fbf-32dd-45ed-90f1-ffbb7e455aaa@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.9-rc8
X-PR-Tracked-Commit-Id: aa9887608e77b835d51f05a54940380391cd4e21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db23baa28eb1f93df1fc175a419e7ffe5b6f1582
Message-Id: <160165891570.31225.15852894813234950380.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Oct 2020 17:15:15 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 02 Oct 2020 09:07:27 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.9-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db23baa28eb1f93df1fc175a419e7ffe5b6f1582

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
