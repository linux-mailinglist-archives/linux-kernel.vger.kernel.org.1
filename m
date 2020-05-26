Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A24361A3995
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 20:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgDISK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 14:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDISK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:10:26 -0400
Subject: Re: [git pull] m68knommu changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586455826;
        bh=1dJJZJJ0gp3X2gtKKb8ovGaXFPD1aGuFpdqfFVI6GNk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Yf8l+zm17SlcIV0vTZr8SC4pS6rZy16n78exWP2AXCIPyZwCVwIt35v8SyED1UJv7
         kw4v7zmL9C54F7trw2NwNYYfFccxgfquJ0BljYY5UljGhb0bQ0BgvJyGnz5z8NC113
         eV1TuQ2JA+m0EfEkuCLcxdd1Vm/F5raDJ3Kcxj2E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ea2d2b5c-a164-7318-3dcf-3c30098364f2@linux-m68k.org>
References: <ea2d2b5c-a164-7318-3dcf-3c30098364f2@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ea2d2b5c-a164-7318-3dcf-3c30098364f2@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next
X-PR-Tracked-Commit-Id: ba000760eb0f182e6ef04faca70bb9737a9674b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cff4821c0856cbf310601c849047fbd666216ea
Message-Id: <158645582682.26793.2224835724753474663.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Apr 2020 18:10:26 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Apr 2020 13:14:08 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cff4821c0856cbf310601c849047fbd666216ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
