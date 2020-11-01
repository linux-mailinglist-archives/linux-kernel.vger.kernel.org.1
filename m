Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5A72A20BB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 19:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgKASJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 13:09:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbgKASJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 13:09:01 -0500
Subject: Re: [GIT PULL] Staging driver fixes for 5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604254140;
        bh=lkY3DCaNZbN3pSBsRWPg6dP7MwaEAA0OdS6R54o5+8E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aDx5E6Pk5+V4xREqZxSUVQ0tlrxY7eGATo1P6Vkl9ACByd7Re7Qw5LEK+7yShh3k1
         2TCmKSraQd4Q6X50jmh7SorvlW9BeJcuPYYnubh2NXyrwcv+9XZFMcTEWMVPEIgwbF
         qSzW2txgixZi4nbC1M2pqWUZ67MgCQpWXId/AxnI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201101130921.GA4115310@kroah.com>
References: <20201101130921.GA4115310@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201101130921.GA4115310@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.10-rc2
X-PR-Tracked-Commit-Id: 7e97e4cbf30026b49b0145c3bfe06087958382c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2376cca02d73a67ab28f03aa787777b74c3b0230
Message-Id: <160425414064.10555.3823876563045716017.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Nov 2020 18:09:00 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Nov 2020 14:09:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2376cca02d73a67ab28f03aa787777b74c3b0230

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
