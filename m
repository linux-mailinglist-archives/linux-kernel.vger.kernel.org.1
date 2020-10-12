Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CD728BF98
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391061AbgJLSVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390882AbgJLSVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:21:05 -0400
Subject: Re: [GIT PULL] x86/platform updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602526864;
        bh=qt/1ZPSjtZulif66HsMxityBYRAmrAbF30J3zkr92Bc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YNfFCUe7Y4F71Mbs4N/rxGEARYgk20d2dLQbt5YyJrVjZkOa0czaEx9eGwqoD73UU
         +HlPRoHTapBkOgXmWIhTMiB1am4aOvER2ILykkdikuCDZv+F686Yij1tQX53mkBjGm
         K9aimaYxs3zY6SL7PxX4UfgVsrC5rs/Ij2jz9dQ0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012101012.GD25311@zn.tnic>
References: <20201012101012.GD25311@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012101012.GD25311@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v5.10
X-PR-Tracked-Commit-Id: 7a6d94f0ed957fb667d4d74c5c6c640a26e87c8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b6591fd0ac8b7e8b2873703bc24b71a6f3d2d3e
Message-Id: <160252686465.3643.10110703613643770481.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 18:21:04 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 12:10:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b6591fd0ac8b7e8b2873703bc24b71a6f3d2d3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
