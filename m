Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA8A1AE3F9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 19:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgDQRp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 13:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729969AbgDQRpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:45:24 -0400
Subject: Re: [GIT PULL] libata fixes for 5.7-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587145523;
        bh=Xh506Zyq34duiBjy5RIJXOsurvZFgmvBuURjJAGZS00=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0U5O93DbxvrUs1w7+zGhDrXf2wznHS6moNEGw5Z1xaSQns5gdqDBjYrhW7z0oGRyV
         hY171HO2Pfu35L1nNA4FU4Z+jP/nd9Wx89bnzGJ5FactJGnT1gyKczBtoXYuADtN+g
         QkqvBqKpnh6Op66xZ67/7ODbcuUymC/u34IkRv8I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <635fe4ef-c1e1-cba6-f4f6-a0c795b5fac8@kernel.dk>
References: <635fe4ef-c1e1-cba6-f4f6-a0c795b5fac8@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <635fe4ef-c1e1-cba6-f4f6-a0c795b5fac8@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/libata-5.7-2020-04-17
X-PR-Tracked-Commit-Id: 1f2ef049cb11c68134ce699f749f16ca8d34468e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2acbb9e670347879e4815b2010f46ee01f1caf30
Message-Id: <158714552379.1625.3683346720457595526.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Apr 2020 17:45:23 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Apr 2020 09:12:01 -0600:

> git://git.kernel.dk/linux-block.git tags/libata-5.7-2020-04-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2acbb9e670347879e4815b2010f46ee01f1caf30

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
