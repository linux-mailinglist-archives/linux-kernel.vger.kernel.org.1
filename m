Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2439624EF4B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 20:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgHWSjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 14:39:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgHWSjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 14:39:24 -0400
Subject: Re: [GIT pull] core/urgent for v5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598207963;
        bh=nW31LJUiQBpYV32e+bvFLVnpTxFhXwgvwwryQS9MImw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nb0ZuOSwfEbdC+p7H3WZpHxoCU5B7jMPbQD+wzWzwLJ6lHA3mjxEaEyh4yEHmt8+w
         3crxzZaILHHfoD3laNNI/mzp4tNYpdQYo7/F5o7WZeTAOnZXJqHPgZ7xmuf4lEpKrp
         HeEH6qmKoDMJXC96IGgQf84iNn3DP/tibsVoiBTY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159817113401.5783.14776307451257171431.tglx@nanos>
References: <159817113401.5783.14776307451257171431.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159817113401.5783.14776307451257171431.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2020-08-23
X-PR-Tracked-Commit-Id: d88d59b64ca35abae208e2781fdb45e69cbed56c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e99b2507baccca79394ec646e3d1a0884667ea98
Message-Id: <159820796355.12134.4421321352772303.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Aug 2020 18:39:23 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Aug 2020 08:25:34 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2020-08-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e99b2507baccca79394ec646e3d1a0884667ea98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
