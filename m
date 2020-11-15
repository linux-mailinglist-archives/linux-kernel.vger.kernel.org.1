Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336172B3789
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 19:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbgKOSAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 13:00:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbgKOSAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 13:00:13 -0500
Subject: Re: [GIT pull] locking/urgent for v5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605463213;
        bh=xZTjfAZ1SFvte3wgZdZKMgMN6fh4Qxa6RkgItc56pb0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j70qBzkpVha762fRXWmRc1BN31E5pJlnGa9CJlljbGJd6RqklrESEWrJDy9KQXQo3
         FbQXAFVKVZP+Ybj/IbXhjMxuw9d7/sbRB8eJQG8oEzhbY8nVJib2J/Dt7N0/WjpDXU
         DsFQUttM5ie3a3ntOBLnp23AvEg/XHKXb2+NsR7M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160544524024.25051.12292089189937197323.tglx@nanos>
References: <160544524024.25051.12292089189937197323.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160544524024.25051.12292089189937197323.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-11-15
X-PR-Tracked-Commit-Id: d61fc96a37603384cd531622c1e89de1096b5123
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 259c2fbef8f09cec8ac3d67820ca6778242beeaa
Message-Id: <160546321305.32406.17499278114334899758.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Nov 2020 18:00:13 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Nov 2020 13:00:40 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-11-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/259c2fbef8f09cec8ac3d67820ca6778242beeaa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
