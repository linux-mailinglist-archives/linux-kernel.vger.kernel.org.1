Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6DB28E925
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 01:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbgJNXXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 19:23:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387516AbgJNXXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 19:23:19 -0400
Subject: Re: [GIT PULL] Driver core patches for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602717798;
        bh=j3yTQIPwDjnO6am/mMpxFljJn+x5C5MA/AysPZNsz00=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TaI3GlzwU++U7v5dR1rnh2XjJkLIeoI3a0gu7TJPur++OK75ALk/Ok03uNb6hpM7n
         wnS5xaSPiqISjkKC4DSqeG2WhBDVf7oQFxHiVMzCBePOntcodbK1+kYsoOBStC0gLM
         4kd1ZtA6VUV+aSsQ7kJl+C5u4sIETWMr9R+4LnLg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201014174851.GA3786562@kroah.com>
References: <20201014174851.GA3786562@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201014174851.GA3786562@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.10-rc1
X-PR-Tracked-Commit-Id: ee4906770ee931394179bcd42cabb196bc952276
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe151462bd0f7ad0e758f1cdcbeb6426e3d1ee8e
Message-Id: <160271779865.1444.1580024281186567027.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 23:23:18 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Oct 2020 19:48:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe151462bd0f7ad0e758f1cdcbeb6426e3d1ee8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
