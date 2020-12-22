Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47CF2E101A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 23:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgLVWYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 17:24:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgLVWYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 17:24:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C1750207B1;
        Tue, 22 Dec 2020 22:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608675842;
        bh=0/qr0/SHKFayzMQdFTEFldJQ1CZ5J4cpywnn7hdQG2U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jE23D+H1qMXQlK9+19F5HMG2EBekkH1LUnAreDOfBXl9SVImT7/Yw14wodMTDDubl
         7H/UeQ9XqYbY1jZXC3E+ESj2AJikG+SA5wSuhLUZ57IbQLIfVNLex8B9Q5DH7v7Yj7
         PDXrLut76WDCYofMIk/7oRYEnIu2UjC/sKsUU4UeNHok61FCG7SpWiygDFtOsSJWkt
         vbQR8k+lx2VPS2vBFeEPvSEKVDkOWD2Y/hpfv99wNBU33bFD7fymIeLg7YuyoY2JDc
         uRSOCzv5EZjmXtyWDCqNtCFs9Xv6FDmtyGfVAXBSWFiQa/2kkegj0Wmcc3xVIepV2R
         NTAGE9xYXC7vQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id AC3176019C;
        Tue, 22 Dec 2020 22:24:02 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v5.11-take2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201222162244.181444-1-linux@roeck-us.net>
References: <20201222162244.181444-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201222162244.181444-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.11-take2
X-PR-Tracked-Commit-Id: 0a4e668b5d52eed8026f5d717196b02b55fb2dc6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e31dcc0a9231462f0e275544b5aebc668481a4e
Message-Id: <160867584263.8550.1876748907808389592.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Dec 2020 22:24:02 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 22 Dec 2020 08:22:44 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.11-take2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e31dcc0a9231462f0e275544b5aebc668481a4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
