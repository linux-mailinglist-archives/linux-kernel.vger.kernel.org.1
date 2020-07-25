Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604F322DA3B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 00:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgGYWaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 18:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728064AbgGYWaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 18:30:05 -0400
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595716205;
        bh=LFOvGiJjz/Kyape8E60iNhD60q6fnSJQdDREInEYExM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CWimMZHS65Hr+AMXmp1OJmoNwPhdRJznNyTUsKw+tAlkoMBykVxZBz3eIlBil0lX0
         4rfKhqIoLBxFTKx8qioG0o4mCk6Fkm4b1diA9xKJtAt/FX3t+x7Jj4MJr70TpY2WQm
         QILR9KYRuxfZWRNebw6NzMfjPYbjPPtjpF0flaXY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200725114637.GA943758@gmail.com>
References: <20200725114637.GA943758@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200725114637.GA943758@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-2020-07-25
X-PR-Tracked-Commit-Id: d181d2da0141371bbc360eaea78719203e165e1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbe0d451bcea569fc0ed3455511a90646c8a9c81
Message-Id: <159571620551.7388.7515783635549986371.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Jul 2020 22:30:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Jul 2020 13:46:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-07-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbe0d451bcea569fc0ed3455511a90646c8a9c81

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
