Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4575C20C411
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jun 2020 22:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgF0UZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jun 2020 16:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgF0UZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 16:25:14 -0400
Subject: Re: [GIT PULL] Staging driver fixes for 5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593289514;
        bh=bF0MtdmpQF/t40sBWytv8dtkhLEA7AEsr1VpV701bD4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DNhMQGVpSymEh4Jqp7TChQjT5P8myU0egOknx3LITc4VfJPIdYmKQxyUAvjvhVvTS
         BM4Zn5GxBimhtOSDWNu1Q6cF1AIfrhA+VxYitHFKAmB1TxiMcFvP0DvAfOF5O/SutW
         aCiqe6vq3vD56eIIxEOMFiAXCLpAWkhYU5xJUQeU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200627114037.GA1637063@kroah.com>
References: <20200627114037.GA1637063@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200627114037.GA1637063@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.8-rc3
X-PR-Tracked-Commit-Id: b65a2d8c8614386f7e8d38ea150749f8a862f431
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42afe7d1c6ef77212250af3459e549d1a944cc8a
Message-Id: <159328951455.11719.6313373142847470095.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jun 2020 20:25:14 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Jun 2020 13:40:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42afe7d1c6ef77212250af3459e549d1a944cc8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
