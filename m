Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2C52A9EEA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgKFVNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:13:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbgKFVN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:13:26 -0500
Subject: Re: [GIT PULL] mtd: Fixes for v5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604697205;
        bh=6rTfXAWYJ/Hs2fMZx90YmU6JMdq+gtUrfFaoXv5b3t0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aNOQok4y+MCTcnAVGkaRYaOPWo2V0qispJoiG7bLIH8HPLdrU72bHvnPeIVIsnlT2
         cndmmY5yiIyfA8xbR5bhIX7uffj3RaZ0rdJpt/J5/v/VSF0u06xRobXBnQDsPEgQ2F
         p84c3G2tsj5fNz6pLTC2WnJWWZk83EIQx0Ja3Qfw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201106204311.795d6016@xps13>
References: <20201106204311.795d6016@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201106204311.795d6016@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes
X-PR-Tracked-Commit-Id: 9efac6ce7f621c405d49a091e3e367be4250a27a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf3e76289cd28b87f679cd53e26d67fd708d718a
Message-Id: <160469720569.14190.4096312430575254303.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Nov 2020 21:13:25 +0000
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

The pull request you sent on Fri, 6 Nov 2020 20:43:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf3e76289cd28b87f679cd53e26d67fd708d718a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
