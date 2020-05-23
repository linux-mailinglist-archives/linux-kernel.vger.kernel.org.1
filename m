Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000C61DFA3E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 20:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbgEWSaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 14:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387969AbgEWSaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:30:03 -0400
Subject: Re: [GIT PULL] Driver core fixes for 5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590258603;
        bh=WAhRRebspSPdiarVc4RDRIPhUBJYs+zIrFZKaoJsJKA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UbgkWBU86oyimqFRGSmmJSs7LhPOcOUYdiSB9ab/KpTR/oe0ImN9TSX4u8X7rIhFW
         MNdDfFjTlk3mXx+TVWr0T1m7dz8Ybvznl6S21ShLt31jEGKIta37Prb5w52f3B5YhG
         RxXAm29CmhQFhlqDhtDOSLjHZ1xGYeB+ozqU0F7I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200523131759.GA55886@kroah.com>
References: <20200523131759.GA55886@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200523131759.GA55886@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.7-rc7
X-PR-Tracked-Commit-Id: 4ef12f7198023c09ad6d25b652bd8748c965c7fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6764aa0e5530066dd969eccea2a1a7d177859a8
Message-Id: <159025860354.7121.1225647998271124374.pr-tracker-bot@kernel.org>
Date:   Sat, 23 May 2020 18:30:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 May 2020 15:17:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6764aa0e5530066dd969eccea2a1a7d177859a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
