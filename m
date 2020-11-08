Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCE52AAD41
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 20:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgKHTik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 14:38:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728895AbgKHTih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 14:38:37 -0500
Subject: Re: [GIT PULL] Driver core documentation fixes for 5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604864317;
        bh=4xtGoazrh3BxCA4OvoGwaZRnRpIg/spvQ3CD4HUCxPQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1isb/7myPHzAmaT9MorWajsYdbxUHrvtMQ23fc/0RdQRs4IniaDy/Dwh9Gmar7tgh
         qDfHD4YVH36aeuM2MTvM6m76o5g6yZlQazGmKuRXEs9ksCwNi+w9vr9o8+sh6GZvDG
         +YBAkzyl/xhnuEDIgC8n5J6NHMv8dA8tHB5QPky4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201108184640.GA66927@kroah.com>
References: <20201108184640.GA66927@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201108184640.GA66927@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.10-rc3
X-PR-Tracked-Commit-Id: d181bfe36715a1834958cf2d62253b624adfae51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15f5d201c1773297b38a11a0064be76a224d073d
Message-Id: <160486431757.12026.8233171376577381846.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Nov 2020 19:38:37 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 8 Nov 2020 19:46:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15f5d201c1773297b38a11a0064be76a224d073d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
