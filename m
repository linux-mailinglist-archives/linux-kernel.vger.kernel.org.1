Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A915022D149
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 23:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgGXVkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 17:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbgGXVkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:40:07 -0400
Subject: Re: [git pull] IOMMU Fix for Linux v5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595626807;
        bh=aFh2n2ICLXzFVuSifsT3e6mvgGttbNwwFi/Gf32ItDM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EmyyZDKxGFwlmHArY3Fd5y3NHOkssxzevcWWEunVLFWh3PxGE6wshqzFKOlpXU2UE
         nFnKpnK7mnwZJIQMfYI1HKPGSdCdxbrO8gYZthFbSf3UAfjCytxgV+AZ03/Qsw5GJ6
         tvBPMOZZ/YlfBTdHtj+FzHccxmA6al15aBSB5M50=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200724182640.GA12653@8bytes.org>
References: <20200724182640.GA12653@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200724182640.GA12653@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fix-v5.8-rc6
X-PR-Tracked-Commit-Id: 1014a2f8d76b05e0f228dd097ac1a249c5934232
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a0b8af0719fd0710d9d1a9ad83b7fbdf4bfca66
Message-Id: <159562680727.3064.12015498537830730074.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jul 2020 21:40:07 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Jul 2020 20:26:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a0b8af0719fd0710d9d1a9ad83b7fbdf4bfca66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
