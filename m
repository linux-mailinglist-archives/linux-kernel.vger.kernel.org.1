Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1607519DFCE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 22:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbgDCUud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 16:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729033AbgDCUuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:50:23 -0400
Subject: Re: [GIT PULL] SPDX patches for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585947022;
        bh=1a39j5CwE4WBzYVHFFHT/a0+C+PY3ftA3ZCn65KFtC8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u53o/nCPo2GHVqZjYRVssEpKaYfXBbFHBHzKAMwZnZmjNr8/ACfA15xuCUqpVj+Cs
         USfVmfVFaqSALnPkNYpEdeQqjEG0amcAKRW24pXHg7OQWcBovYg4odrTmRsDZYbepN
         xnBWoyI6kc3urzBqRzc+ZdK/8CTs6Gk6LCy4Niic=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200403161848.GA4105642@kroah.com>
References: <20200403161848.GA4105642@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200403161848.GA4105642@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git
 tags/spdx-5.7-rc1
X-PR-Tracked-Commit-Id: 71db3aa2816da62a2d150ad9fa81168537db4037
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff2ae607c6f329d11a3b0528801ea7474be8c3e9
Message-Id: <158594702271.4594.9789161568408438354.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 20:50:22 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Apr 2020 18:18:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff2ae607c6f329d11a3b0528801ea7474be8c3e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
