Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81FD2DA2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407745AbgLNWEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:04:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729628AbgLNWDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:03:24 -0500
Subject: Re: [GIT PULL] x86/SGX for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607983363;
        bh=/YOyFQ2LgZ8sMQmPJE0KWy34KqL4XyDvKfjv2jRoxOc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NiSTij/Exuoh2L6iFDTQo8j5t3aAkd0N7lOGDBxF1Hst1rf0n8nrCci5uW4lxBh++
         QZBQK15jq5TSahJUpct60HseEywxw/2fboYrmj/v/aViwxWBw4Z87+gfc1YwTReiAe
         1A66uxhzUsvKMzXkLhtUhZIlMmN8gwKqeJqWdE7Saii6LdQcHMWUth1uWSAylTrs1D
         d4JF+dREqHd04IVFORQSf/jkcY8JioYWhd8gMatnZM33JS1WJ5qB4nBLcZz4H+m+qU
         2aIpZpSG4/YMzaIjcmNEZTwN8yNf33raesoHg1vrkCUfpg8idaQI3I2GK92z8r1Bz3
         8ApC83xMR3kng==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214114200.GD26358@zn.tnic>
References: <20201214114200.GD26358@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214114200.GD26358@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.11
X-PR-Tracked-Commit-Id: a4b9c48b96517ff4780b22a784e7537eac5dc21b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5583ff677b3108cde989b6d4fd1958e091420c0c
Message-Id: <160798336378.30284.2509879876302159760.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Dec 2020 22:02:43 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 12:42:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5583ff677b3108cde989b6d4fd1958e091420c0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
