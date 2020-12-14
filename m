Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5232DA30F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407672AbgLNWEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:04:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728866AbgLNWDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:03:24 -0500
Subject: Re: [GIT PULL] x86/microcode update for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607983363;
        bh=InU3xNJFZ0wpz8vclK700CZmCQ2YWDw3txQ8NgnrxEA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=i4MwLrOAnob9+ObZ7PbPRgaE33T/Ef5qVbiwmtlGCizfLKcciNjWZ7/I1U4jUMOj8
         I9eo23m4uPFAyo6tGQJOY2vnIq9xqqjfZNTWY6cB0X/6nb9bv55D8yh9Ws9Tr3QKOi
         vgzhW5gv/hUf3El5vS9jDvCk6ZehzvfQwCFJoLU3HVxfwKrzEVMt67SgDl1yILQ5at
         Z6vh1hPWwdQs+bdj5yKb9LPZ4orhEN88z8IjMxzVlGAS4E6vZ/1v7sQBVckUOWPB6O
         3Lz4EW7D11UqpwSGuTz+zdL8I0BT+4OPlaQXJtd40ERU2KZQclGNqUtHIw1YFnTvc9
         NWqLj3d5IBOEw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214112229.GC26358@zn.tnic>
References: <20201214112229.GC26358@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214112229.GC26358@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_update_for_v5.11
X-PR-Tracked-Commit-Id: 880396c86a1f3663c22b74fef34353f05a1263ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85fe40cad2dae9e0439ea6f92fde9c5e9c58f09b
Message-Id: <160798336358.30284.1761044503340763011.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Dec 2020 22:02:43 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 12:22:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_update_for_v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85fe40cad2dae9e0439ea6f92fde9c5e9c58f09b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
