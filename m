Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81871F8484
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 20:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgFMSAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jun 2020 14:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgFMSAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 14:00:32 -0400
Subject: Re: [GIT pull resend] x86/entry for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592071231;
        bh=dO+F7nepls+vJ+qAfc3moKZJdLN/jbY4PnqkWBigsu8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OjRDrKoV6rNjVahKu+/98uwjiejlwCG4FR24m6qRt20neupybpLuZ1WbDAfm2UrsS
         kHOzFXWOdY/1MXvEdWjLFUXmTqUqR2XKOP4VPCAmKn+5NuPtHbYUOE5d6t/ljHOGWS
         m5AzC00g/CcBClrCqiygJJ3/prceXC+2MZD+PAdY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159199950554.21782.7550706843970155617.tglx@nanos.tec.linutronix.de>
References: <159199950433.21782.7922990856385499228.tglx@nanos.tec.linutronix.de>
 <159199950554.21782.7550706843970155617.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159199950554.21782.7550706843970155617.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-entry-2020-06-12
X-PR-Tracked-Commit-Id: 0bf3924bfabd13ba21aa702344fc00b3b3263e5a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 076f14be7fc942e112c94c841baec44124275cd0
Message-Id: <159207123181.28894.14767895975819219683.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jun 2020 18:00:31 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jun 2020 22:05:05 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2020-06-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/076f14be7fc942e112c94c841baec44124275cd0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
