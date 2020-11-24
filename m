Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED772C31D1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 21:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbgKXURe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 15:17:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730599AbgKXURd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 15:17:33 -0500
Subject: Re: [GIT PULL] ARC fixes for 5.10-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606249052;
        bh=R4y7ZtZDec/miM/LfvHn1EHudG9V/DYbfjG69Dzof/U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RNhYnoJ9Fc6sN9dNN9j//sxUqn8eVcC4AZADBzITTzxzivoRaZaVxnVvLD2AXtt9U
         Oq23ZzkBmujNxV6eXa/PTdPvhXvTx+oyfJzXE/ONKPBh3TnvIpZyLON9x+95yyo/8f
         ZONB7aeu1Q1irSgqdkpBNfZmY7wBIx+cqKzeBSO0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e02b2e57-720a-758a-bea9-1d9c03fba539@synopsys.com>
References: <e02b2e57-720a-758a-bea9-1d9c03fba539@synopsys.com>
X-PR-Tracked-List-Id: Linux on Synopsys ARC Processors <linux-snps-arc.lists.infradead.org>
X-PR-Tracked-Message-Id: <e02b2e57-720a-758a-bea9-1d9c03fba539@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.10-rc6
X-PR-Tracked-Commit-Id: f737561c709667013d832316dd3198a7fe3d1260
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1489422041ba58f224270480d8241be24f0f8dd
Message-Id: <160624905269.27196.10280923899172312691.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Nov 2020 20:17:32 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 Nov 2020 00:52:20 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1489422041ba58f224270480d8241be24f0f8dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
