Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261CA2DA2F2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbgLNWDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:03:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729923AbgLNWDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:03:24 -0500
Subject: Re: [GIT PULL] x86/mm for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607983364;
        bh=9SOFQeIFnIbQREttyG1T4tBfxjAsAYLfj9OvcIjXRec=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bl0LEYwJYuYJhwIiXDDbzFsTikSyU+H/NmXsuNNBnzZo0KGay/s+oMKGDRLRkCdyD
         t/EQsZ2qZKpvhbSiw8ECkDET0icRNwIPFCsTq58qP/Qb1FAQ5Mx4dXRMqLZIRoBEQu
         ElxK6XDyYkpUHZHMmFG1uB59nUtnU46vd5UCN15Q9qDjxoeHKet87eykh/1zo1L0vV
         TcacwRPC4DKdHWYo3x1miuOVgBDCoJpBIWtHhzmhcqRJsub1rDxiuk77Fg2ySGkHPO
         nZzk/gkrZdTmfQEMqjWCqhgeS7k0jU2yDteUVUZnRirhYHTAnxCe83ANQ4BQtGgiFb
         0G2NC7UZqXsiQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214115047.GE26358@zn.tnic>
References: <20201214115047.GE26358@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214115047.GE26358@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_v5.11
X-PR-Tracked-Commit-Id: 1fcd009102ee02e217f2e7635ab65517d785da8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54d794830f4dd6caf688be3cc802e165952c4079
Message-Id: <160798336403.30284.10011472398711725683.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Dec 2020 22:02:44 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 12:50:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54d794830f4dd6caf688be3cc802e165952c4079

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
