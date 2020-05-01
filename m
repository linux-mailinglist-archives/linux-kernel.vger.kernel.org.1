Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B4B1C1D46
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 20:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgEASfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 14:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729671AbgEASfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:35:12 -0400
Subject: Re: [GIT PULL] sound fixes for 5.6-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588358112;
        bh=pERltmYddGZDMj3rxUUSoqUrQKxhaf6QoOIX49oYWB0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yk0UNv6TpbHMF7ENkJ+D4a5IxHaPlW994JtjQze2AW+1S4MXARgpoVEql4NYPQdpq
         VtPMMeBm4NsfKdjtnTJzquK+s3E2ej6Uv3Y7tUlhhxF28QK8cVsW6ro9nBRZU9R8EG
         wVt+/NrjgfdnS+yDu+AE6mTX7XJCibenz3QRkgig=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hk11whrzj.wl-tiwai@suse.de>
References: <s5hk11whrzj.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hk11whrzj.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.7-rc4
X-PR-Tracked-Commit-Id: 547d2c9cf4f1f72adfecacbd5b093681fb0e8b3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c536419022fe3f363ca0c84848dacb3ef3b1f031
Message-Id: <158835811215.18489.323410779999767042.pr-tracker-bot@kernel.org>
Date:   Fri, 01 May 2020 18:35:12 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 01 May 2020 12:25:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c536419022fe3f363ca0c84848dacb3ef3b1f031

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
