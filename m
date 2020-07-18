Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6D3224D77
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 20:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgGRSPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 14:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRSPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 14:15:05 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.8-7 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595096105;
        bh=XG4682Kf92hRcqVJ6QE0BDW6IprtXNNfMdXlf1FHRv0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hlOXVle/xCjD7RSW9VKEExRYCrWP+5HkzxEAVExzX1PrCXFYCM6e7JvPVJinswO4X
         nGEyCBE1A+3C0P7NH5x/EoNzuDhJ8UbT1HjPmghgeQcwkqx7192MAV7rL2tUFbqrdJ
         9JAeN2If0UbOCEtp/I6d7OKVgtYoPy2DQWLWwhec=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87k0z1t1s0.fsf@mpe.ellerman.id.au>
References: <87k0z1t1s0.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87k0z1t1s0.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.8-7
X-PR-Tracked-Commit-Id: f0479c4bcbd92d1a457d4a43bcab79f29d11334a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 721db9dfb106f042294f40d2dbbd6c3613c3cd61
Message-Id: <159509610495.11665.8963528587638944537.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jul 2020 18:15:04 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, haren@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sathnaga@linux.vnet.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Jul 2020 23:01:51 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.8-7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/721db9dfb106f042294f40d2dbbd6c3613c3cd61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
