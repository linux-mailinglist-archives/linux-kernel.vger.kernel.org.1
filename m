Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB2023B1E3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 02:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgHDAuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 20:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729234AbgHDAuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:50:07 -0400
Subject: Re: [GIT PULL] x86/core changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596502206;
        bh=UsyXw+8gtKaCWnVXXkXnBammt/UWFYTvhDyun539ThE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PdlAYTgUNSOhxJQTdbGsfGZ26/ulyGWmYcfD4SB+DCda+QE0kxE1+P9qJgHr2S8hd
         fWASi4jMsILn0Xgg/aJS654jgnLDuehLPefA63ZcOijS9m11++G3UnSxmdJ3ehvAC0
         vUQRpXgC84t6sxejQeMWfI1N4BnGilM872K53SOQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803174848.GA1041119@gmail.com>
References: <20200803174848.GA1041119@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803174848.GA1041119@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2020-08-03
X-PR-Tracked-Commit-Id: ef2ff0f5d6008d325c9a068e20981c0d0acc4d6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ee48103151bbce7ae319b477109eba4216b20d2
Message-Id: <159650220667.17631.2279388276050640000.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 00:50:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 19:48:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ee48103151bbce7ae319b477109eba4216b20d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
