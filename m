Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1540E1ED5F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 20:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgFCSPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 14:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgFCSPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:15:07 -0400
Subject: Re: [GIT pull] irq/core for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591208106;
        bh=N6lKc2UQsjy0TL1JIKnEJXXC99NIaNRCmFJS6Wjg93k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2alJMYJgR+m28k2b7NPYpE9b1ceA/ESh0PF21/tCpFU2bPe58u4wU27ZrU/qF7sSJ
         qsxULkL+WtGWXIrFcpZJld32hS9zvMraXSIY9KDOCHaoZK6PnjB0emt/XJ2sqbSBDu
         ZqjcUmGqY303GyQRCJU+CIP7rbHnBA4NHPiVGbMM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159109968973.14228.6780339995273133401.tglx@nanos.tec.linutronix.de>
References: <159109968973.14228.6780339995273133401.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159109968973.14228.6780339995273133401.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-06-02
X-PR-Tracked-Commit-Id: d77aeb5d403d379ff458e04fc07b5b86700270f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6606d0c0010953e4c28c8662623662b5108b4ce
Message-Id: <159120810668.18635.11991503790150406255.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 18:15:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 02 Jun 2020 12:08:09 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-06-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6606d0c0010953e4c28c8662623662b5108b4ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
