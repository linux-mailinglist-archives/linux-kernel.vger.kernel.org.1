Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77ED12C7B13
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 21:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgK2UGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 15:06:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgK2UGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 15:06:48 -0500
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606680367;
        bh=5H0nzny5f+OL4CxGGa/QvIFJbYknriJbw31TSe3+Ru4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MDLMXXE/f3CBttmYOvEg5321mp8ZHMJ28pAtKaaPKFpv4M1vOPzG9wmvPNNXxh4Uc
         PMGHeR/1bdiXvhfwF1vf5fVdPkdoHngBiLTmGnxMpisW5vT22HERqGR6naKMhKctHx
         kS5021zfLGOawUB8dcf/5+IBJM9hGIwMMESrW3Dk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160665708065.2808.15317906761841446715.tglx@nanos>
References: <160665707945.2808.5384034634184489471.tglx@nanos> <160665708065.2808.15317906761841446715.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160665708065.2808.15317906761841446715.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-11-29
X-PR-Tracked-Commit-Id: 6e1d2bc675bd57640f5658a4a657ae488db4c204
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f91a3aa6bce480fe6e08df540129f4a923222419
Message-Id: <160668036793.1296.10070793222351061517.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Nov 2020 20:06:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Nov 2020 13:38:00 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-11-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f91a3aa6bce480fe6e08df540129f4a923222419

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
