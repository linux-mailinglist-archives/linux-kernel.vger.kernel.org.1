Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF5D2D36B4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 00:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbgLHXI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 18:08:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbgLHXI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 18:08:28 -0500
Subject: Re: [git pull] [brown paperbag] regression in sparc64 this cycle
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607468868;
        bh=is8cdR0jhTGNNjRII4bzkqzk9cgZ3sPHPILPJ7m4Jog=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OEMs6LKrSZ++rkUF4dLD6mcn8ByGzZFWT8UF0eNF2PE5ZsqBTUyquJyid1h8TFbK8
         9znIEKzOLCgeZKGe0qGgx0SLkelPnWFhS8xFIqV0v0nHohqQ7z+HamK1tMU4Zzsr1N
         dsZfl5jhma9oz+BatF4D59vYJazQdUbLmbo8W2nc0xRFDl8CMBkhp+mh8Ip7xt0kuu
         fQVPP+oxMGcJR9VSCQ4xCbA/XIGRO5Zi/ARxGcx9xdjWzvh5qmygzozdDaEYRByESa
         4okB/ttZuGIwhe5jsDsk9GhLC9a6zhgD7wn2wtxVn+kf7OChp5SJECjXN+X82W0lhV
         PnlgC49O+m6xw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201208214823.GJ3579531@ZenIV.linux.org.uk>
References: <20201208214823.GJ3579531@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201208214823.GJ3579531@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 6220e48d9640538ff700f2e7d24c2f9277555fd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6f7e1510b872c281ff603a3108c084b6548d35c
Message-Id: <160746886787.32435.14588690235445646420.pr-tracker-bot@kernel.org>
Date:   Tue, 08 Dec 2020 23:07:47 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 8 Dec 2020 21:48:23 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6f7e1510b872c281ff603a3108c084b6548d35c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
