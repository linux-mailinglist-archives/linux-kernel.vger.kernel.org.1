Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E0430183E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 21:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbhAWUKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 15:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:44392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbhAWUGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 15:06:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id AC737230FC;
        Sat, 23 Jan 2021 20:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611432341;
        bh=QR8j3/Pz9sPmSr2bB5ttxkkk2G/AllB+gOLTaVma/CQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Gl+p+ufpIFZwqrA8wvc7AJpEdXA2ZA243m4tbBy/ezno5YA+py2aEYC11t21O+K9v
         Qro6VrzdH1/sf26BOOvZU2UIkHC1AUxb9tGvgHHYRVZrmMl/H/XNOTELXX/lUU/pBv
         jNEYi+E6VPPISgFesdACspazUujs/9JDQZmG/FdOhPSBCmB0tQk4AR9pHqVK2P5kyG
         +o9+nWY80jUGMZW/2MigV/LR3sbjtRhdfBX4uNi9M7pPRDff2k/KTT1J5GU3RogIuH
         eXiTQpmgiGPNyyicIlhmIGieDwhQIvpy4sA3EG3UkrgmYCrQJKLALQLZrDDalY7Cnq
         niK1S3tRma8lg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A84EE652E1;
        Sat, 23 Jan 2021 20:05:41 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Fixes for v5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210123195940.2c76e738@xps13>
References: <20210123195940.2c76e738@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210123195940.2c76e738@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes
X-PR-Tracked-Commit-Id: b135b3358d73aa2a8b2be35d08e422421d1c609e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1ae4b0be15891faf46d390e9f3dc9bd71a8cae1
Message-Id: <161143234168.8668.12529729154136210909.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Jan 2021 20:05:41 +0000
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

The pull request you sent on Sat, 23 Jan 2021 19:59:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1ae4b0be15891faf46d390e9f3dc9bd71a8cae1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
