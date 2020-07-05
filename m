Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD4B214E2F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 19:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgGERfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 13:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbgGERfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 13:35:05 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.8-5 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593970505;
        bh=l4Uwc5C+ZV9G2UyJh2f72xT//S7JYx/EuHA2BNaRNro=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jIVcwwXUsbrB0EC3mjtbtLzquj62e+OsgPCdncHJiq37bf1udF5/YhfpwyY1DBDjD
         ojzaGYEp8Hcxf17ojOwaeFdbSmltL6NPh63xApM70ersSLbkxBZdsIPZ8qMFnd7/N+
         ET3KpD7+jFWfNMKCWrQ78cQN1sP8I75gMmjh+EsI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87366776cu.fsf@mpe.ellerman.id.au>
References: <87366776cu.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87366776cu.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.8-5
X-PR-Tracked-Commit-Id: 19ab500edb5d6020010caba48ce3b4ce4182ab63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bc0b029a8889f2c67c988760aba66a8d7b22af5
Message-Id: <159397050561.12702.17175107324371828407.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jul 2020 17:35:05 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 04 Jul 2020 23:33:05 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.8-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bc0b029a8889f2c67c988760aba66a8d7b22af5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
