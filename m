Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C882D8233
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 23:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436700AbgLKWgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 17:36:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:55666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbgLKWfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 17:35:54 -0500
Subject: Re: [GIT PULL] mtd: Changes for 5.10 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607726114;
        bh=5mQx4kuCD393D6xaTGljqcDcepxu79OzrjUZlOH6PyQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SucQX2u+VNOwsj5lp04Kyoj/Tsay0WGE/rqDAxl24WVwfUo+CCMKSJdJtYFbiW8Dg
         e22V8VcU9ZswO/l6hcrvC1jL0QhFY+/ETs5E6lDJS4ETABt+XnhgFRPfKUcWI+hAoJ
         EjIZOqOV5III4XJ00cGLU9w+8f2XAPgJ/gmyxJX1pNxHfBdXsSmpeL+Tj4iJXQUYip
         yO/IAOVXogY6UNEjoo/DSs8onu7K+g0FyTbr0PpUTQENdoEx9JATUC8zfUWNSWLbyn
         2vRb8eHNNkuA2WiH42jUsqfzzKxyJh70MpHmc0TtAku36Eo6fuNbQbv2ddu3Ixj2Ds
         uxTGeu8QCiJLg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201211201356.62c54b3f@xps13>
References: <20201211201356.62c54b3f@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201211201356.62c54b3f@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.10-rc8
X-PR-Tracked-Commit-Id: 33d974e76e21e9da8a36b14d2dce6394c36c3e30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f376f1917d7461e05b648983e8d2aea9d0712b2
Message-Id: <160772611424.9549.3478486283482241544.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Dec 2020 22:35:14 +0000
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

The pull request you sent on Fri, 11 Dec 2020 20:13:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.10-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f376f1917d7461e05b648983e8d2aea9d0712b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
