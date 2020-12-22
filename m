Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2212A2E102A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 23:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgLVWZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 17:25:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbgLVWZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 17:25:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9BFA523130;
        Tue, 22 Dec 2020 22:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608675865;
        bh=oolGpAUxz9OUv+nPj1sSNuAAT6lRoBcG7xNKhnAC1HU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G14HxV+WE96gc9uNt7ZPACbXnMkNvvN//tq6UtBWo2CVSaMZbOMamTue4R5lj2m3p
         jG+wFrPfm3ubZcE9F3pbjOIz5RNOVqqM/E2y2h75PaYQyu5HYvil902NM2nzICADMJ
         ufunuUud5PQyZY8sdGNspf/34+X5pF5Eoa+8/rBZ+xDwyE5L3i3mL+i46H49fvZz4L
         qNmwoRDFc5NQrwwlemX2ck6TVL11+Nfp4AlQr1gefLUrwmAUvA7XxwhVazbpmG32LK
         yYiYuavWwKvtbyQ6957FNMScJD+GlGZjti+8WsRG1JvGNeyLJpEyKZxdXp9/lCxAoN
         zBgoJdvCM55QQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 94FCF60113;
        Tue, 22 Dec 2020 22:24:25 +0000 (UTC)
Subject: Re: [GIT PULL] configfs updates for 5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201222160341.GA3019774@infradead.org>
References: <20201222160341.GA3019774@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201222160341.GA3019774@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/configfs.git tags/configfs-5.11
X-PR-Tracked-Commit-Id: 65cdb4a214c0015c19fc1876896746c05396f45d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f06f210673e6841439a0f91fcde64960cdbeb5c
Message-Id: <160867586560.8550.11240184533040418804.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Dec 2020 22:24:25 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 22 Dec 2020 17:03:41 +0100:

> git://git.infradead.org/users/hch/configfs.git tags/configfs-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f06f210673e6841439a0f91fcde64960cdbeb5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
