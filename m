Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6046123AE39
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 22:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgHCUfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 16:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbgHCUfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:35:04 -0400
Subject: Re: [GIT PULL] MTD fixes for 5.8 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596486904;
        bh=Qfk5WnYdFPtcHhc/68zv02GhRg6dbbSq2Q8+0Xv1INo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cYh861z2037shc6VRzyXDYXPRhNZDMS7rb6wLisvt0pMSZxDiTjVUfzjgGUR89p4c
         IoLMjPDtb68mzyXZ1nJSXLLyDL76KBgv5dSHNB8JFLaS9eqWVcFAHeBzrqRSNRT9ir
         CX03fq0S5wMLO6O849Dh2Q+uYLyFQBk9FyGtcEa0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1401520472.201470.1596395841386.JavaMail.zimbra@nod.at>
References: <1401520472.201470.1596395841386.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1401520472.201470.1596395841386.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes
X-PR-Tracked-Commit-Id: f7e6b19bc76471ba03725fe58e0c218a3d6266c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99f6cf61f175c1239ed8e86d4a1757c380da52d1
Message-Id: <159648690406.10543.6134196581055250233.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 20:35:04 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 2 Aug 2020 21:17:21 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99f6cf61f175c1239ed8e86d4a1757c380da52d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
