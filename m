Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF772E9DD0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 20:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbhADTDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 14:03:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727760AbhADTDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:03:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E92492068D;
        Mon,  4 Jan 2021 19:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609786962;
        bh=7E2kWrtAeYtiIomRgyajziY7XpIVACd6SJ5yxDjYnpI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fZN/i+GhLVr4Xzgs57i+U29NSzYAMFsTMamqcbPkdw36V2xoZHRleSCaIBdmbwu95
         hhU3+SKGi3icFMka8gySUQcu2wbpZVBGvwSyFz1OuhncrATmyifaoNFCoPDlJ+j24+
         VSqcTrTo37B8mlG8H83CYoENXNGwAOl25jkq2JLWtvg+um2FtIpdAsMdQiVpNsra+i
         AJqQIUoEUAEmvWyGicIxKyf2+W6k3kH/3iIKjM99XVSiYfwFkQIuMwoNdRQd8XrRK4
         lr8h/Oz2ESePNB8h+r12RhEcKonyu6tJulo4S4jy0XgCfET2VpYasebVbhj/0uRM7j
         +lUMjP/pMXqfA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id D43666011A;
        Mon,  4 Jan 2021 19:02:41 +0000 (UTC)
Subject: Re: [GIT PULL] Fix kprobes issue by moving RCU-tasks initialization
 earlier
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210104181934.GA16612@paulmck-ThinkPad-P72>
References: <20210104181934.GA16612@paulmck-ThinkPad-P72>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <20210104181934.GA16612@paulmck-ThinkPad-P72>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/urgent
X-PR-Tracked-Commit-Id: 1b04fa9900263b4e217ca2509fd778b32c2b4eb2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36bbbd0e234d817938bdc52121a0f5473b3e58f5
Message-Id: <160978696179.11668.18092994360202511113.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Jan 2021 19:02:41 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, urezki@gmail.com, tglx@linutronix.de,
        linuxppc-dev@lists.ozlabs.org, mingo@kernel.org, dja@axtens.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Jan 2021 10:19:34 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/urgent

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36bbbd0e234d817938bdc52121a0f5473b3e58f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
