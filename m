Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3A22A20B3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 19:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgKASI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 13:08:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgKASI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 13:08:57 -0500
Subject: Re: [GIT PULL] USB driver fixes for 5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604254136;
        bh=Z54W7Qk2H4q8Z+clGtBsDFWOZLrGOSTXS7liRGCZzjY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Q1DaugrfKseNRJRUlx2mzZ93TlU149joNwgWOvM1DAKCMkTbcTQHWxCtaZTRSu8dQ
         IVGH4jIkU2CHVnb577YdkXKN+RAuXM5CcnphaW1b7AkKyLPgs8sCrX7cRaPncUUF1D
         uCpMSHSQlQDonBA1tshdk2paODlP7TtVkdUZNuzU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201101130836.GA4065915@kroah.com>
References: <20201101130836.GA4065915@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201101130836.GA4065915@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.10-rc2
X-PR-Tracked-Commit-Id: 00c27a1df8ff5e99b383e2b4cbf947a4926fb534
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b5ff3c93cd323d26551a026c04929e1d2c1b68b
Message-Id: <160425413676.10555.7301854808368217096.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Nov 2020 18:08:56 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Nov 2020 14:08:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b5ff3c93cd323d26551a026c04929e1d2c1b68b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
