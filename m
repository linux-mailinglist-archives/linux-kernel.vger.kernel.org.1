Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492C6249031
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 23:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHRVeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 17:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgHRVer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 17:34:47 -0400
Subject: Re: [GIT PULL] Fix regression in IA-64 caused by page table allocation
 refactoring
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597786486;
        bh=MNq7AuZvcokP1xsstxmaDjgBwecj/YAFGNVeyLdWBow=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gOKaAUdShubgLIoZUowrItOdHUlUxtuVy+dwRzMtk7qK+LWyuLsslrXYUJ/zfNPCw
         jYarZgTvCqDY0ubfdQPk71soX/nXNt/AIbI4oFBtmkQYrPYGXYt+5E2UWqbqPMUvZv
         rxO4H2F2q2Ita/ZfwtUXs95ThY+58Ae/HWUTenN0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200818101549.GN752365@kernel.org>
References: <20200818101549.GN752365@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200818101549.GN752365@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git tags/fixes-2020-08-18
X-PR-Tracked-Commit-Id: bd05220c7be3356046861c317d9c287ca50445ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9899b587588fb6ced0597e188e049f1ab92c7003
Message-Id: <159778648690.7307.14255426878917698709.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Aug 2020 21:34:46 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 18 Aug 2020 13:15:49 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git tags/fixes-2020-08-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9899b587588fb6ced0597e188e049f1ab92c7003

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
