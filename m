Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586D226804E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 18:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgIMQeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 12:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgIMQdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 12:33:32 -0400
Subject: Re: [GIT PULL] Driver core fixes for 5.9-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600014812;
        bh=x6TMM79CY1HiHjOxr0MGFzc4urg7X/xYSCt7j1VXACo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BtANMxUzDsQVklybYm5angEporWsMuPTDe9l22hAIDHvawCX3AKBhlvevOGjqUGju
         /5X9nLAVv2EqLxY87YZXMZykJcCHw3x62N8SPeXXG8N1eMKRd47xDMo4sRCVxQ8Rna
         /Q6ajvjsORJTO8OrQVjaPAW1sWHEtgioHSkyZFaU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200913083853.GA906777@kroah.com>
References: <20200913083853.GA906777@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200913083853.GA906777@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.9-rc5
X-PR-Tracked-Commit-Id: baaabecfc80fad255f866563b53b8c7a3eec176e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20a7b6be0514334a30a4306331a4bcf6f78e451a
Message-Id: <160001481220.6953.14254878796667858308.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Sep 2020 16:33:32 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Sep 2020 10:38:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20a7b6be0514334a30a4306331a4bcf6f78e451a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
