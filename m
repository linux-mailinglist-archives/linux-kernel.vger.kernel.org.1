Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17522E28F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 23:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgLXWAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 17:00:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbgLXWAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 17:00:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 315BA23129;
        Thu, 24 Dec 2020 21:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608847179;
        bh=XY8T+DLTkQTMe8DFYaGN2XiiCrdiPe5V/1k2r966BrQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OmdxpWqeyttoB1Oz2RNXy/edbIC1WL//T7sBY53s/TPd4YjkwV95ecCEYF6MsuKJb
         gpQmE4G9SARXNS/7JzHQ2N+xk1zU5qauQjlJPQbZnxsO9oDwhtGLR4uYkGnkSVu1Tt
         C4gsDobFhKYzzLSMhips5q6qMuEAGOoHwxK/XmGnItQftl+SgLyjb/j0Ayw/tk51Hy
         HvqM/mF+OXpWIB4SMcNaVxDCtZtEQpU+iWrRDfamei/WCmx/jLH66WNH6KR76VXRYN
         Y6yYdzQwG7l0QKhPCmOcmuQq2Fp4D8czsKhwWUH0bWkeiGvEtNJvVW4DIsWVQcN5gP
         ugrLT9VM2HE/Q==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 2C07D60159;
        Thu, 24 Dec 2020 21:59:39 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v5.11-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160868116773.15975.16926726831905097728.tglx@nanos>
References: <160868116773.15975.16926726831905097728.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160868116773.15975.16926726831905097728.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-12-23
X-PR-Tracked-Commit-Id: 64a1b95bb9fe3ec76e1a2cd803eff06389341ae4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3913d00ac51a9d93225eeea776026326ff8f717d
Message-Id: <160884717917.31605.17227160051428560014.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Dec 2020 21:59:39 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 22 Dec 2020 23:52:47 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-12-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3913d00ac51a9d93225eeea776026326ff8f717d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
