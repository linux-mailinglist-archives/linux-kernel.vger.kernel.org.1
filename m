Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D3523C1AA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgHDVk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 17:40:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728246AbgHDVkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:40:10 -0400
Subject: Re: [GIT PULL] tasklets updates for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596577210;
        bh=rdcX+HTezr2mAuwpZu/PAiz0YoQGp9DR/XFou84Pies=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YIqDqVSx3UTiFXbgmIIL7KQA+7dJnq7CBPQLDQ8TpUH+klBpNxVRxYXFYMmW4lB9Z
         vK+oyIjrMjvoDFBLhDdHutDeHsUb6cp0iT1B2/Z1muNp2CCuIMF30C5S+ur+dsxp+J
         qODqLzSL4BaP9KM2opRzyvTNrnyjV1rwPlYY95B4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202008031200.7A9BCE5C@keescook>
References: <202008031200.7A9BCE5C@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202008031200.7A9BCE5C@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/tasklets-v5.9-rc1
X-PR-Tracked-Commit-Id: 12cc923f1ccc1df467e046b02a72c2b3b321b6a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 427714f258a3783b15e33d6daa34d57824f28bab
Message-Id: <159657721024.17686.3648799854667739567.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 21:40:10 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Romain Perier <romain.perier@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 12:05:55 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/tasklets-v5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/427714f258a3783b15e33d6daa34d57824f28bab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
