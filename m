Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7987F28C3F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbgJLVZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732122AbgJLVZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:25:07 -0400
Subject: Re: [GIT PULL] locking changes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602537906;
        bh=InTIZGWyIKvjbkNf9j7fUIAFcvv5FmYX8kr9JeFPqro=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=n2lkvNSNSiBRhxPtmDaFsgFShN2ejbg1lWEcCFfzXs9i3NeX+LHsEtD3iQ34ba2qI
         MWeRomnF2v4AvpfWy9OH9ZcKNPGC9UmPtMlk87foR1egTxh5rCfU3BRe04OEP9OiHY
         zMIoX8FMxb1OHAuefX4Na4CXYxbaUZj9E3S+yBI8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012135800.GA3240531@gmail.com>
References: <20201012135800.GA3240531@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012135800.GA3240531@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2020-10-12
X-PR-Tracked-Commit-Id: 2116d708b0580c0048fc80b82ec4b53f4ddaa166
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed016af52ee3035b4799ebd7d53f9ae59d5782c4
Message-Id: <160253790671.926.5223300750246202124.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 21:25:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 15:58:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed016af52ee3035b4799ebd7d53f9ae59d5782c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
