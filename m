Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826142F09A0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 21:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbhAJUIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 15:08:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbhAJUIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 15:08:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C214922A85;
        Sun, 10 Jan 2021 20:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610309243;
        bh=Yz4J6qjZ0UbLgJ+A8qAB+Xdu6r0lzsu+yKE/n0cULXY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vLeRzwgktZKwGnlvqFyjRgAL2XYVrvRy6iJq3tNqx2+/M8wzwJQS7elMynOvwQHtH
         c1UWtWkiu41KgjEXQMe65XfjZmcBUzgHPBRvPqChCgAo5ebRo7KHX+NORUJLY242CL
         ZlRBAMKewKkL3TxEx4iJk5pb+f5mKW5GNbx6oK0EfbrkVVuNsjsVjj1rzb5pxdjF+E
         911y8jj9zHoIokmoEl9XAi5oWzgqrX4uJXFj14oAiFtNJlN12gigU9DyYtJEJoTaP0
         qvGewgmN5qqfmGenOmkX2p792d52JOqcJJsoUv9ZOG0d7nXoNl+nfn2QuERRxkARsU
         b8cm1n+nN6LVQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id BD4ED60140;
        Sun, 10 Jan 2021 20:07:23 +0000 (UTC)
Subject: Re: [GIT PULL] ARC fixes for 5.11-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0d1b3ae6-2a67-9531-7a41-a4d5d00793ea@synopsys.com>
References: <0d1b3ae6-2a67-9531-7a41-a4d5d00793ea@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0d1b3ae6-2a67-9531-7a41-a4d5d00793ea@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.11-rc3-fixes
X-PR-Tracked-Commit-Id: e8deee4f1543eda9b75278f63322f412cad52f6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0653161f0faca68b77b3f36fb4b4b9b8b07050e5
Message-Id: <161030924376.466.10504053213740025438.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Jan 2021 20:07:23 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Jan 2021 18:49:21 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.11-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0653161f0faca68b77b3f36fb4b4b9b8b07050e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
