Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5141CB472
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 18:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgEHQPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 12:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbgEHQPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:15:06 -0400
Subject: Re: [GIT PULL] Driver core fixes for 5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588954505;
        bh=7pXAWlopoGBZ2mR1ijusar+7F+m5R0E3ucfu3hjB6+0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YlDanree8qaBx8ioqqi/XR9qfBw7Rt86uT7V0g6otrbe9gqreHjYCbyXRSeCCoVBA
         0z+dx08FdfCFinYc3qvpAYx/BVV6fuUqAKwE2TFMuIlFBQtKCtMm1apkGltPvp7y8z
         G0mnnUSxT/9p1Hn4qdzN1fmzWoY03Wn9YLijlDkw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200508141830.GA357188@kroah.com>
References: <20200508141830.GA357188@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200508141830.GA357188@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.7-rc5
X-PR-Tracked-Commit-Id: 2a15483b401c0b07e44b43b95414e36f32c02f32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c61529f6f59c9e136432cde96f9a053a51ad2a1e
Message-Id: <158895450577.20886.13343986250254697710.pr-tracker-bot@kernel.org>
Date:   Fri, 08 May 2020 16:15:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 May 2020 16:18:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c61529f6f59c9e136432cde96f9a053a51ad2a1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
