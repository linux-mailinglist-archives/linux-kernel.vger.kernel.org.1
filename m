Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9E228BF96
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390926AbgJLSVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390905AbgJLSVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:21:07 -0400
Subject: Re: [GIT PULL] x86/cache updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602526865;
        bh=8CgVaisrWCPZVx4q9k6hvkMsoEvL9Li39v7UB2PBr8s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JyhG1Y1u/eC6sSh7OR7hVekaSGsl6DVcQJB2zBkX/iSsmRLUskbtcOmFA1Lzq6Xtj
         o9Za5U7EpaEkSN5kJnVqqecyNbcQsCtsRaPhJor8Oz3UwRDh1sEmDU95umHe7lmQyZ
         lXXsh3WA6RKV7f1Qq/zYdambKSbCbBNN1BGwhJgM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012105918.GJ25311@zn.tnic>
References: <20201012105918.GJ25311@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012105918.GJ25311@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v5.10
X-PR-Tracked-Commit-Id: 29b6bd41ee24f69a85666b9f68d500b382d408fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64743e652cea9d6df4264caaa1d7f95273024afb
Message-Id: <160252686588.3643.14700690997930838414.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 18:21:05 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 12:59:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64743e652cea9d6df4264caaa1d7f95273024afb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
