Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD72913A1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 20:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438873AbgJQSWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 14:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438843AbgJQSWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 14:22:42 -0400
Subject: Re: [GIT PULL] MTD updates for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602958962;
        bh=5mFCa+Q8SYjVtOELXdSY8lMak5iq0+C1sI2bfK+9Wzo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PO7DbMAmMEZDZuHxMUh0/ZDsf5rklm4hO5HLB6lka3t1HEeoby7gkY6OFCfRDlSpz
         f1p2rwFEPLH/4qIq83L7cORgZycVXrJge7FZXocIhCx96NwXK8Mx/wku6WJy3gJhUG
         RTw9R2Ag2Ph89r6k48ZVXNw1PNk7PqtVP+ZKPjeg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1673234208.201792.1602850459001.JavaMail.zimbra@nod.at>
References: <1673234208.201792.1602850459001.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1673234208.201792.1602850459001.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.10
X-PR-Tracked-Commit-Id: 6402f4ce95811db7df72244ca84860332e4c2518
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f78b9acf04fbf9ede7f4265e7282f9fb39d2c8c
Message-Id: <160295896254.15185.8153069505913079449.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Oct 2020 18:22:42 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Oct 2020 14:14:19 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f78b9acf04fbf9ede7f4265e7282f9fb39d2c8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
