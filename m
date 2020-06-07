Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4016A1F0D93
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jun 2020 20:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgFGSKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jun 2020 14:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbgFGSKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 14:10:19 -0400
Subject: Re: [GIT PULL] USB/PHY driver update for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591553418;
        bh=Rp3t/Pdj8TnycDaoG2l3HKJnueizd14qsxZOkP9W4mA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qgTZxt3+Xd2ObZhvUMtZAxdpYMAPU9GMC4v07JZGF1tRvLRCj9X/srN1FjGXO3bZx
         IZtKPkK9Cp9ON0ahdmQjZzK3XhCLShnesrGDYt7+7m+gil5HuCE0YaMp3f3+TMcbT9
         a39IDmNCifUdHMSpZtI1xad6Ppnblsqp306AbTMM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200607132701.GA168046@kroah.com>
References: <20200607132701.GA168046@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200607132701.GA168046@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.8-rc1
X-PR-Tracked-Commit-Id: 347052e3bf1b62a25c11f7a673acfbaf554d67a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e611c0fe318c6d6827ee2bba660fbc23cf73f7dc
Message-Id: <159155341887.28494.14195988327420438133.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Jun 2020 18:10:18 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Jun 2020 15:27:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e611c0fe318c6d6827ee2bba660fbc23cf73f7dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
