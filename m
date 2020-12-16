Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5492DC974
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 00:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgLPXMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 18:12:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbgLPXMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 18:12:12 -0500
Subject: Re: [GIT PULL] mtd: Changes for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608160253;
        bh=YNbhYgWJ+qCcoPEcCGZrMOHTDaE7/UP4QbyuLS9mxdc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=P0MC31iWhl/L6bkwam9IBAKTJolFawwAc4oek8TePgJlupv+B70QpEDp0M0y9sA5f
         nOBjWqMqqJuQDBa8nPMFsIuxi7tTPOslBY1sQiVZL6rUi+/PMG+3bRb+4cS63aysK1
         8O6Dk63LBvzrXTll4uyBRSeCoz6Awt532kW8QqLf5d4SDj/cRXIfhTjbsb77ijUjZw
         +NEDkL8jCq11NEqYpfTYoGHPhv08wjK+rBDuIwvpVmVAVE3YQYXTjTD5s1YEES3Uib
         3OiCwpuqjCtvrMlPyt4cOUlF3olMmTt31UcNrUijRvTpCL9bIUvt4cRH2/u7xj9Ewl
         vGQjSh4Y9+cbA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201216190417.6b7dede2@xps13>
References: <20201216190417.6b7dede2@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201216190417.6b7dede2@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.11
X-PR-Tracked-Commit-Id: 4c9e94dff65ca75b917ff0b5de2e44881062a8e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a701262c02cec71dc29b10fe910ba3c2298f5ba3
Message-Id: <160816025367.24445.12709776192529643414.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 23:10:53 +0000
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

The pull request you sent on Wed, 16 Dec 2020 19:04:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a701262c02cec71dc29b10fe910ba3c2298f5ba3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
