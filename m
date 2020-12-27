Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AAA2E3228
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 18:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgL0R1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 12:27:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgL0R1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 12:27:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1315422597;
        Sun, 27 Dec 2020 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609090026;
        bh=xQ/9bVeaJPbUnQKu0K00P2nJYj8GBmKISOlvgkf7Ezw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HVJjuUOFwhAGdof5u4eSE0n4x6AQjQ1qYDd8byADek9oyLir3YoXbn1w/8cE9+XYW
         63w6S6tU/akGLufAfTYHsCgFZHqKP97fznrNvJFznjHRagK84QkH46CNrY71z0fHyK
         4oVI47ljvUjVjXn9xPZYBbuIAJBXVGMPlNRwkOh5pmD8zukzXTyXzKuqcfrJzhuvvn
         73p7zDj9GvT9pxDjyjHO+Sr199kx9wmG3KwvjqTAJHQ727buGEZKps99+obyx0yX1p
         aqyexVm9TJSQG4/l3jya+8xZCihwnJQix7rA+fLDVCeY14mnZsk/ZjVekGVFa/kvZy
         0Ykgzmlz+x7zg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 0D57D600D9;
        Sun, 27 Dec 2020 17:27:06 +0000 (UTC)
Subject: Re: [GIT PULL] objtool fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201227093105.GA1806713@gmail.com>
References: <20201227093105.GA1806713@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201227093105.GA1806713@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2020-12-27
X-PR-Tracked-Commit-Id: 44f6a7c0755d8dd453c70557e11687bb080a6f21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cce622ab9284a27257dd75bb35eccdd619bf96d1
Message-Id: <160909002604.19416.1791371792616073528.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Dec 2020 17:27:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Dec 2020 10:31:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2020-12-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cce622ab9284a27257dd75bb35eccdd619bf96d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
