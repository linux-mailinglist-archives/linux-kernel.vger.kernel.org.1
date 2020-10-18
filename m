Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11EDD29187A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 19:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbgJRRKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 13:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgJRRKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 13:10:48 -0400
Subject: Re: [GIT PULL] UBIFS updates for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603041048;
        bh=yRPZIdHPswrioBrLocqGoDeX5cdrcT1XUiz6sEsc/RU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Q4M8eCazVEb0Y6gPaz9DL0qA1IabKDvdW9R0oSXMLshIc/uRDGJ5DFNZcbSbhetmW
         GqWUuRk53KzBstJz6YAGZOqWzS8m8VWINjtTQ1vysfUDiu6y/cw0xJFlqQzvKc+Ru6
         cUVvTEcz51NgwYYeSFNyAvzUaXXniQciogsX6ops=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <725261806.204163.1602963460565.JavaMail.zimbra@nod.at>
References: <725261806.204163.1602963460565.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <725261806.204163.1602963460565.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.10-rc1
X-PR-Tracked-Commit-Id: e2a05cc7f8229e150243cdae40f2af9021d67a4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a96fd1cc3ff3f9dd6f06140fc0b8c91342859450
Message-Id: <160304104821.11245.7207058750403088041.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Oct 2020 17:10:48 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 17 Oct 2020 21:37:40 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a96fd1cc3ff3f9dd6f06140fc0b8c91342859450

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
