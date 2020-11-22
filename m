Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EC52BC97A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 22:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgKVVJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 16:09:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbgKVVJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:09:11 -0500
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606079351;
        bh=OF7ZouDk1bSs5tAWzTt0Usla9d9vx73DBL9Uh5dKhyA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Gjxr6kIl7C97M0J5SpATwiHFvDY3qmBfQH9h5U3uilkAvRs2Ql399zeQhyabJyr6e
         iOhveDzdv4YnD7la9HgvsZPNabJfQJ+TkTnrDitkZ5rfL1B/lsY/ZOp2NmwoOLee/w
         ihy91d9xPKFi8ctLXoUygYMSMMxqSEtsh8j+gzwM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X7pOurJAAFWxYMG/@kroah.com>
References: <X7pOurJAAFWxYMG/@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X7pOurJAAFWxYMG/@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.10-rc5
X-PR-Tracked-Commit-Id: 425af483523b76bc78e14674a430579d38b2a593
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de758035702576ac0e5ac0f93e3cce77144c3bd3
Message-Id: <160607935117.25428.12870910376406662950.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Nov 2020 21:09:11 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Nov 2020 12:42:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de758035702576ac0e5ac0f93e3cce77144c3bd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
