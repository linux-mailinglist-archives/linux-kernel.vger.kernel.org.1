Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69171ACF24
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 19:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbgDPRzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 13:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbgDPRzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:55:21 -0400
Subject: Re: [GIT PULL] tracing: Fix the race between registering 'snapshot'
 event trigger and triggering 'snapshot' operation
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587059721;
        bh=7GK8uobXXOPhNGvusGTrb/EESaZzmCglhaeUF8w0J8s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QY3AfT6xFI8GsrSxFgkjRtvoZH7RfCQY3tPgzNa3Qlw9QqNC6sbxaygHBS88MGmgL
         zll23hZEVe+gN5fGOsKI262vEqzksNhJ4PB3UoxTtrenjH20nFT7Au77fH3cOrmhHY
         hiLQtYwcOIXS/JNyc5aDsokWOtWquAgf5tszuUKs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200415214033.47e3f95f@oasis.local.home>
References: <20200415214033.47e3f95f@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200415214033.47e3f95f@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.7-rc1
X-PR-Tracked-Commit-Id: 0bbe7f719985efd9adb3454679ecef0984cb6800
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ede125902386c6fa946852da81709fcf490ae4a
Message-Id: <158705972142.30027.15942264853873871126.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Apr 2020 17:55:21 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 Apr 2020 21:40:33 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ede125902386c6fa946852da81709fcf490ae4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
