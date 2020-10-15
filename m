Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B2528F77E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 19:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390129AbgJORM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 13:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389725AbgJORMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:12:21 -0400
Subject: Re: [GIT PULL] Staging/IIO driver update for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602781940;
        bh=f4gFtS/hg+fjIEa1gl55i+9wch5ncs1dyFgrX1syOrg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IKKaxf4xTmY7tCuy0wbd5kCZ2gUBjlrtQRiEAPOeKnFmZFDTbNk23ySo0+MZLBPfR
         WQWpmntYc1OVtn5jJqlyNZKs14jjyb5TiCiVZc0Ojysjf0UTjzOE0Uvd/i0j5zi4is
         +9sI5zRbt/9S9DrIGWHjRADRBKr234lILHNnoHxk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201015122713.GA4021230@kroah.com>
References: <20201015122713.GA4021230@kroah.com>
X-PR-Tracked-List-Id: Linux Driver Project Developer List
 <driverdev-devel.linuxdriverproject.org>
X-PR-Tracked-Message-Id: <20201015122713.GA4021230@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.10-rc1
X-PR-Tracked-Commit-Id: e1f13c879a7c21bd207dc6242455e8e3a1e88b40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ade7afe3e606f9f6ff0e6deefce140157f75540b
Message-Id: <160278194076.2218.9925296435436817818.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Oct 2020 17:12:20 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Oct 2020 14:27:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ade7afe3e606f9f6ff0e6deefce140157f75540b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
