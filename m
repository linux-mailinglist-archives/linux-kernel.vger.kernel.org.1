Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D0F29187B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 19:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgJRRKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 13:10:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgJRRKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 13:10:49 -0400
Subject: Re: [GIT PULL] uml updates for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603041048;
        bh=cc3PX+EQQXH3hrldwgk6MDEU1VyZluYmgOUPRdld7XU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mHaGnxUxb3VfK0txK2PhEsRvdvwwXSs+nImiGURVdOZMp686cWWQINKXaYzEaXqA4
         wxyneMMLmwg7Jm2uxiXEthyoVlDC2ZzxtKpRx93Ahb3dUJDj0/F7yFknp9SGPDEh3O
         zyImGd+rtrWzjbPgwSIfv2ARjQPmTJyIFVwabW64=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1807778111.204345.1602968387192.JavaMail.zimbra@nod.at>
References: <1807778111.204345.1602968387192.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1807778111.204345.1602968387192.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.10-rc1
X-PR-Tracked-Commit-Id: f06885b3f3e3884f98351d7b72a4fc8400911cde
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9453b2d4694c2cb6c30d99e65d4a3deb09e94ac3
Message-Id: <160304104874.11245.6127789064612973776.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Oct 2020 17:10:48 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 17 Oct 2020 22:59:47 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9453b2d4694c2cb6c30d99e65d4a3deb09e94ac3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
