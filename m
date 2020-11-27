Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431632C6D8F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 00:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbgK0XPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 18:15:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731483AbgK0UF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 15:05:57 -0500
Subject: Re: [GIT PULL] mtd: Fixes for v5.10-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606507556;
        bh=bFteTb1DF2UZL9QmORZrOqJwlLF0qxVbEDwaLtyngfw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=l/iNAMhjs5iua2ISZhnrrmCeQGSG//zIF3Zcux/BdEcwUcl+I1vvNo0gm7dfHYwq7
         kW0XY/2PfC6h4GWOMk2RcV6Nr1DCLM5KiR5FB6oJ8kjjAH4ucbJlD5//7rxDuqcO3q
         YlY3B8hf56T/7Edu184Kcr0BhFV0/mYqZyCQ5SgU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201127193803.324e1f83@xps13>
References: <20201127193803.324e1f83@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201127193803.324e1f83@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.10-rc6
X-PR-Tracked-Commit-Id: b36bf0a0fe5d18561dd98eb774ef61dd396edc42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76dc2bfc2e1b40573cd33eb1c2027ef6cb7fed6c
Message-Id: <160650755678.29509.3445152395889388583.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Nov 2020 20:05:56 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Nov 2020 19:38:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76dc2bfc2e1b40573cd33eb1c2027ef6cb7fed6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
