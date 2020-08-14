Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17857244F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 22:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgHNUmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 16:42:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgHNUma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 16:42:30 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.9-2 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597437750;
        bh=BiW+6DvQXlXTFzNmIqZcDPDLjIb0sENH4NewtIk3vMs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nxHp4O/rNBuCwEQpZIFTVCK33e7K1ya8THDYtAMvLlLt+A9FhZMYlVKjkpMMPWSpq
         Cd/3L2XZSlLcEbEQH9FfbhqKeeF1fwp6ioU1ihn+hAOktGLIZRARjC7Y8dErc8KkqC
         CjCEyixmsRx+iKp9rjVKKbOfWSg+JIm+heAUqPbI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ft8p9yjf.fsf@mpe.ellerman.id.au>
References: <87ft8p9yjf.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ft8p9yjf.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.9-2
X-PR-Tracked-Commit-Id: 6553fb799f601497ca0703682e2aff131197dc5c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fca4dee610dffbe119714231cac0d59496bc193
Message-Id: <159743775058.14792.13104351594451961274.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Aug 2020 20:42:30 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Aug 2020 22:56:04 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fca4dee610dffbe119714231cac0d59496bc193

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
