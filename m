Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A661E011C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 19:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387900AbgEXRaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 13:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387758AbgEXRaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 13:30:04 -0400
Subject: Re: [GIT pull] x86/urgent for v5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590341404;
        bh=5Mhi5k/odl8OntrVDLTuwkYGSOF5JgvTYlAJdACg34w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2T6Xr4sPANooKaDTVH9LUeM/vaafqaMGKaO1hFwCfjCjJypXAsboLpJ3ruq5h5qQN
         vUN5EE85L4jPPgAgdmI+iGWK/rVLh4IWmlY9YYlBImIdwZnkuWHZcjEIxYjS6DnGow
         /4GtrtsEESFe3toqSBdzbZOylOGPKxNmjefZMuP0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159033288358.21635.2357843074773527660.tglx@nanos.tec.linutronix.de>
References: <159033288117.21635.13199705716119914103.tglx@nanos.tec.linutronix.de>
 <159033288358.21635.2357843074773527660.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159033288358.21635.2357843074773527660.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-2020-05-24
X-PR-Tracked-Commit-Id: 187b96db5ca79423618dfa29a05c438c34f9e1f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 667b6249b71c30c20fcd2f312f1665d90348635a
Message-Id: <159034140397.27315.1188218724525921511.pr-tracker-bot@kernel.org>
Date:   Sun, 24 May 2020 17:30:03 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 May 2020 15:08:03 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-05-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/667b6249b71c30c20fcd2f312f1665d90348635a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
