Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED1E1F0112
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 22:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgFEUkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 16:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728504AbgFEUkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:40:14 -0400
Subject: Re: [GIT PULL v3] x86/mm changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591389614;
        bh=ucel4PenEvLQxL2bGbuHZ9BLkWJA5zW0jC2BNWyK68o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TetfkgkvcVb/rX54Bt+xmXHS/dBl6vv8cvmgy6tEP3NzrHFWvBV1a3SBzFCn3dJ8H
         80BBofTG+ADP85CCPjvIEiF5jFVKDvblA4m7wYJE8IzB/KiSsBDrLsE6wgz0wi0DOj
         UK8ZoBGGEJhOf0HTfU2Nmm/mDfwprYAFPnW1wl7s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200605081137.GA2231266@gmail.com>
References: <20200601170102.GA1346815@gmail.com>
 <CAHk-=wgXf_wQ9zrJKv2Hy4EpEbLuqty-Cjbs2u00gm7XcYHBfw@mail.gmail.com>
 <20200602073350.GA481221@gmail.com>
 <b159ba4c53fcf04cc4eb747c45e1d4d2d83310a3.camel@kernel.crashing.org>
 <871rmxgw4d.fsf@nanos.tec.linutronix.de>
 <CAHk-=wgOFnMW-EgymmrTyqTPLrpGJrUJ_wBzehMpyT=SO4-JRQ@mail.gmail.com>
 <20200604172904.GA1751362@gmail.com>
 <CAHk-=whK846PwG_qNqyb-q-BSPALb=xZ9k6ThVjRm8u=vCpkqA@mail.gmail.com>
 <20200605081137.GA2231266@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200605081137.GA2231266@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2020-06-05
X-PR-Tracked-Commit-Id: bd1de2a7aace4d1d312fb1be264b8fafdb706208
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4dd60a3d4c7656dcaa0ba2afb503528c86f913f
Message-Id: <159138961428.17917.15924133388016868270.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Jun 2020 20:40:14 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Balbir Singh <sblbir@amazon.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Jun 2020 10:11:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2020-06-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4dd60a3d4c7656dcaa0ba2afb503528c86f913f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
