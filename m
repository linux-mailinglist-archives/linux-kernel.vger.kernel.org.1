Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6511B92B1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgDZSPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 14:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgDZSPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:15:17 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.7-3 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587924916;
        bh=N4sMstSWT1pnoIGbSoHzjmWbGKpjxPmNuYD+kkM+7n0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PZ/f65QqAgBzQAu6C3OFABx/60jxLHBW5aNQZBSeaG9+RuE/6EBw77Q+Fjcyjvd+a
         z8At0cb2+GNHTld2oLY4mwGQFknTcsNhPrWBA+ASYSvP03LsXqTSI6Ubi7+yXdmMtN
         ppSEneoKXVrjqzfqwwj2SPWK1HGBAzFlkz798+Mw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877dy3gm2c.fsf@mpe.ellerman.id.au>
References: <877dy3gm2c.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <877dy3gm2c.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.7-3
X-PR-Tracked-Commit-Id: 5990cdee689c6885b27c6d969a3d58b09002b0bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 670bcd79b5237deaf1518cfc90d5058b52ea5ac8
Message-Id: <158792491683.6795.13638212252713244023.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Apr 2020 18:15:16 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        chris.packham@alliedtelesis.co.nz, christophe.leroy@c-s.fr,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, natechancellor@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Apr 2020 09:52:43 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.7-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/670bcd79b5237deaf1518cfc90d5058b52ea5ac8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
