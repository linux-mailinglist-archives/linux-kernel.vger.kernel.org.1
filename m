Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E4428E90C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 01:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387916AbgJNXC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 19:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731045AbgJNXCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 19:02:15 -0400
Subject: Re: [GIT PULL] MFD for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602716533;
        bh=1q5Ry2eVK4wL3CLJpUkc6KFFpDMkRfoA0uxe0+NRYPI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cu22ItVFpZyfeYUnwcItmpYPhlp6JBqWkI1U881n04HuRGPOfLeko0DESWHQQUer5
         8r/eBSg3YGaPqz6PdrXrqpGZkUsHqu08J58Ak08uhWkkHYY6HSjjZDAvAK/wD+7c2e
         kypzyDJM0h3hfcEJpvIxshrY7fVjQnSpSdvEhBYE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201014160907.GA4545@dell>
References: <20201014160907.GA4545@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201014160907.GA4545@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.10
X-PR-Tracked-Commit-Id: 6d81dc3c79d46b66b29712eb1ac5ad2cbe4231d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a31c12371556bfbe511edd268dab721b504d511
Message-Id: <160271653376.18101.6844159422664548877.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 23:02:13 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Oct 2020 17:09:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a31c12371556bfbe511edd268dab721b504d511

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
