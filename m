Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E2527048A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgIRTEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgIRTEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:04:21 -0400
Subject: Re: [GIT PULL] mtd: Fixes for v5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600455860;
        bh=jQHn+v9RQ9uR56zwm2djy/2/gqWqBoZMQEO+bcakXHI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gA9DmMlGKJmnfwlV0im1v3Tmt/yLawB3lmoBYDnQyBNlwiZgU0vRRzOp4JaFgYv6+
         2tU/TllRJ6TrHkyq0nZRwpYk2uDQQrlwZ5leKaWG9cwIxikFnhUF1ElydMktX54iG8
         sTal++jcjLV+XArvsePixO9q+RxZHZociCBTgYG4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c6965ad6-7d32-7dd9-21f8-346cfa634147@ti.com>
References: <c6965ad6-7d32-7dd9-21f8-346cfa634147@ti.com>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <c6965ad6-7d32-7dd9-21f8-346cfa634147@ti.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.9-rc6
X-PR-Tracked-Commit-Id: 1afc0c89f6a155c54c76d65ffcf72cd1232daf3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92373933f7dc0b311804d7d45bdae2aced81da23
Message-Id: <160045586090.18461.9178547259626166748.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Sep 2020 19:04:20 +0000
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     torvalds <torvalds@linux-foundation.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Sep 2020 16:13:47 +0530:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92373933f7dc0b311804d7d45bdae2aced81da23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
