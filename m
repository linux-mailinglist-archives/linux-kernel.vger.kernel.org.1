Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BCD2DA515
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 01:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgLOAvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 19:51:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbgLOAua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 19:50:30 -0500
Subject: Re: [GIT PULL] Some fixes for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607993389;
        bh=FJnOCbPdVQmUvvAp3aPt4ACHaPShHAp4+9sSmLAL/uk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qzLwq4Hj05NScsJ2u8q4tNdJkhPNcpf3qcqcpfQu3lrhB8qzV3RT25CEuX5dG82Dq
         ABRgm1oOQBpAqKhtHxi9Jg4XfGG3yyRX/hzjEVb/pCWdIiIlyohpoi3evzs98Al3uJ
         9T4p8X9dU61kPravX3liTIfprv78rK89T6HBPtAzY1nj0bI9u7xqbviMz9oaHOWDIb
         Lq4WulRG7TOIXQP0lZLunXP/2lqMAu3/+8PNAan6vTn3nIjlndvR00HaJKz4+CKBCi
         SjytMQauESEXv9BmhBpRqd4kFrRAZfJAzXw9VFk974nXvOKJNFN69AV+zRwm4JpgcB
         mnTPA3RC+SNXw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214132745.3323776-1-christian.brauner@ubuntu.com>
References: <20201214132745.3323776-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214132745.3323776-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fixes-v5.11
X-PR-Tracked-Commit-Id: aabe19b8279340c43294688b4d9527a893c60463
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9b4240b074730f41c1ef8e0d695d10fb5bb1e27
Message-Id: <160799338973.8612.14914156563233758302.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 00:49:49 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 14:27:45 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fixes-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9b4240b074730f41c1ef8e0d695d10fb5bb1e27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
