Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAC32DA674
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 03:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgLOCsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 21:48:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgLOCsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 21:48:32 -0500
Subject: Re: [GIT pull] core/mm for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608000471;
        bh=WB5VARf9vWL1VNH/2pRozPjhsdUda/xUKk6NnlEDuqw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bcUhs+t6n0dr7lPLaYYxOVmF3RY/LXBpSP5iNwR8w1xoae9VAjZEtV338WsyhtDSV
         mHPWLmYqD03AegyHmDfULXSKjBF6CwRp9ytynRSZ2eDukmPgLft0BPHB1yn0y47RWw
         cs8MoDT6KwGqREftIkZgm4D/YyFWhUQ93Ur4ywD51XdXffJOtiWcmj+PzWzCh5O/cJ
         I45YaeY3/516dfBxcFfzCMHh3i0YoXDLq1kwzN3QdazjKxiVW8DfLgCfxlCAmyOEam
         UCKUSZ8Y0bQBEVoDqEv1FcEzA1YhBfmp8EpPlNmPu4zP/e6olaH7VMHDcueYa6D7Dx
         8XNygyhcwRqLA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160797734275.10793.2956447277890639251.tglx@nanos>
References: <160797732939.10793.9152151866806316627.tglx@nanos> <160797734275.10793.2956447277890639251.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160797734275.10793.2956447277890639251.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-mm-2020-12-14
X-PR-Tracked-Commit-Id: 68061c02bb295da4955f0d309b9459f0a7ba83dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: edd7ab76847442e299af64a761febd180d71f98d
Message-Id: <160800047154.6499.8908343742978577206.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 02:47:51 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 20:22:22 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-mm-2020-12-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/edd7ab76847442e299af64a761febd180d71f98d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
