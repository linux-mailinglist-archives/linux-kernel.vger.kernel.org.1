Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203CC2DEA97
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 21:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgLRUz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 15:55:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgLRUzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 15:55:24 -0500
Subject: Re: [GIT PULL] ktest.pl: Updates for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608324884;
        bh=75+ZxWx6dAUcFMEIqY0KDfxc9srzjfru0PmJJh9hAz4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gsMo7AY+P8zwKHKj86gNKuIvpfTZlHBBqvIaRje2ANhUVcsoEisCMmfbkgqu9RstJ
         rnXOdcLRtS11aulLrbGq9J3lclnssEi7YdS+Cirrr4qwQ9xpoDI8do6Djwd4rfb3YW
         FQY/REg4k47QGlPNkPWY69cYBuTQZ2XgWMq2PIzWFsLS0z8gJNI2fEoZz8Kc9+zZOI
         wGeh+5FS4LlikDmnJqQSdRP/BMuReahs+P/DHZ8VYnr8tdsPP6JkRnoRHU7z07fzIe
         IGXk2Fjy5nDSHwZmWBWc2K/pQR3Z4WSIsLQmlhgqEgRfHN7nd18zDjNg9Lb7Fr/EOU
         mDm5DNDabjTmA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201218115532.35eca018@gandalf.local.home>
References: <20201218115532.35eca018@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201218115532.35eca018@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v5.11
X-PR-Tracked-Commit-Id: 170f4869e66275f498ae4736106fb54c0fdcd036
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4862c741bd440813cabc5e93351f0950c1cb19d9
Message-Id: <160832488404.19372.18117987493237439564.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Dec 2020 20:54:44 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Dec 2020 11:55:32 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4862c741bd440813cabc5e93351f0950c1cb19d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
