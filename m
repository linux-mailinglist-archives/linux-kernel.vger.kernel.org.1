Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC76C2B378C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 19:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgKOSAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 13:00:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbgKOSAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 13:00:13 -0500
Subject: Re: [GIT pull] sched/urgent for v5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605463213;
        bh=fjaKq8ethd+yAgr+1c1MXmnA8nI8e3cMt9hhKG1P9+U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eZvz0s+RPbyQG2UNkl4Hy3bwVcSDtjcZRredhUfSIDQEVavv1ZtiHIwylE0fpaJkJ
         aE0pPzaT+yWXcg4fV1Y3KoRnFloGT2g+i3X0xeM71VrvXj79JKJvmOT0dJGBOlrHBP
         yQGBAaCYtRa/zYPAmue8nx5j1h6dPkWdMMpohUAc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160544524266.25051.13876494098346280672.tglx@nanos>
References: <160544524024.25051.12292089189937197323.tglx@nanos> <160544524266.25051.13876494098346280672.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160544524266.25051.13876494098346280672.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-11-15
X-PR-Tracked-Commit-Id: 8d4d9c7b4333abccb3bf310d76ef7ea2edb9828f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0a37fd57fbae32adffb56ae9852d551376b7c9b
Message-Id: <160546321338.32406.11148892054663702049.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Nov 2020 18:00:13 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Nov 2020 13:00:42 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-11-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0a37fd57fbae32adffb56ae9852d551376b7c9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
