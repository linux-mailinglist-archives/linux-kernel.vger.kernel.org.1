Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53022DA315
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440049AbgLNWOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:14:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387784AbgLNWEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:04:08 -0500
Subject: Re: [GIT PULL] x86/cleanups for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607983365;
        bh=nfl2+G1mq8obCzKkYVP82dKRaK6e9pKewFfvKdVOpz8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f+rhT7uRS6NzN7i0MOuH9i2u84PqhVZ+I/LBy3t862qqpXsVK9T+T+5aXglYuWvKC
         ez9FlQTTMjIT2j9RmFTc/1jcuORXRgYHJSP7Tf/6E6pqGxp5SisRUJmBdKNENN+Dmo
         jJX0FabkH76wWXwP/eS6sct2jpIK2Z69yDkjqc2pVhAcrvlyYHcoBjym+UMQLg94Pp
         aDMm7t3N8fTGeAyxVcq2P1L82IJuZFfRRKvNyn/8IUuzR2dBHMNGA9dfBluhfI0ZOQ
         4QZRdGuUr2FNxRQ5OX+qq5Uea4pFokMAWdMik9G2I8kUml+avYNpIHKP35tzlG3a1i
         0dg6qdvMDx7Vw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214152659.GI26358@zn.tnic>
References: <20201214152659.GI26358@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214152659.GI26358@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.11
X-PR-Tracked-Commit-Id: 9a02fd8b19247e80e2354a227b6e2392e8fae78a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 405f868f13daf7bae85e6fec143121c27d52cdb4
Message-Id: <160798336542.30284.6413972972575152704.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Dec 2020 22:02:45 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 16:26:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/405f868f13daf7bae85e6fec143121c27d52cdb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
