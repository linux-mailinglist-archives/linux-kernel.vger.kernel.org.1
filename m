Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E622183F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 01:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgGOXKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 19:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgGOXKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:10:04 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.8-2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594854604;
        bh=A/1JlGGKSPmIYHTZNSGv2IKoJJf+O9ym0G+SRLpk3QY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nGBLLbSCG1DR9QKK/Ry+GPz61UDtK5EmnRdobAqHesjOvhdsQm42M+DksazDvQjGU
         j+JuMR56ao/nr85PRrhYDFRrFjR7mUaYwfbZliBltRp77RyzS9pduIFgd7MOtm6Gkb
         xUjCxRkqpjCmpAeYhQH5h9/vM6RgpmYOuqBv0XQg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200715095846.GA464373@smile.fi.intel.com>
References: <20200715095846.GA464373@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200715095846.GA464373@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.8-2
X-PR-Tracked-Commit-Id: 9a33e375d98ece5ea40c576eabd3257acb90c509
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 994e99a96c9b502b3f6ee411457007cd52051cf5
Message-Id: <159485460413.13658.7656761980338516510.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Jul 2020 23:10:04 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 Jul 2020 12:58:46 +0300:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/994e99a96c9b502b3f6ee411457007cd52051cf5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
