Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE51222B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 21:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgGPTFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 15:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729474AbgGPTFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:05:05 -0400
Subject: Re: [GIT PULL] Driver core fixes for 5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594926305;
        bh=M6EbtI3z95JzlvfJdZBbBeU/zNbw8iivay1Po8n/1Sg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Rn6bNVLCyMpnpwkt9A8NKx7Tz+YntHtl7bc01aC75L6fx8Pn/Kzkqo7JPNUAlycqE
         MWFXxNBcrCj0E341OLTDTCZa8uAXRkSL95cLpyjYOxVbsxG9N3lNqAAFn6UuYnCQX+
         HvRfQ6193ZW4k4q+QdeMsCwszudDIOH00RFP4T+0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200716153003.GA2379010@kroah.com>
References: <20200716153003.GA2379010@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200716153003.GA2379010@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.8-rc6
X-PR-Tracked-Commit-Id: 2451e746478a6a6e981cfa66b62b791ca93b90c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50ad1c2155a32dc68e0da8efcc6d95429869076e
Message-Id: <159492630499.21154.9449231205227262108.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Jul 2020 19:05:04 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Jul 2020 17:30:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50ad1c2155a32dc68e0da8efcc6d95429869076e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
