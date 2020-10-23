Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B2D297752
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755146AbgJWSxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:53:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755125AbgJWSxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:53:18 -0400
Subject: Re: [GIT PULL] chrome-platform changes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603479198;
        bh=N/rQ9d+kOzw+jjllVpaJiZVsrhHfZad0YutdCsSnf4I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oM9Nd9ATyfXuhJLMLsSGMSlvujZsw4PUZtx214uWi6DVGP+PkO6tEZvEJaX5qNVfS
         J9MNOk6a0dCvPXcF9MDXW1IB+Oivk8xhJqAUjyhNGIUbg0LplLc2eWw2Iq+E/DdoRD
         zl4nf1O0y07rFsTZLhTr1ySsIrrEgZo1sxuYmXqA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201022212420.GA3714143@google.com>
References: <20201022212420.GA3714143@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201022212420.GA3714143@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.10
X-PR-Tracked-Commit-Id: 3e98fd6d816cd82f529345870efd435f06e02803
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 090a7d046fedaaaf41fcdd84ca11764fa5d35233
Message-Id: <160347919831.2166.13057179011250675088.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Oct 2020 18:53:18 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, bleung@chromium.org,
        bleung@google.com, bleung@kernel.org, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Oct 2020 14:24:20 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/090a7d046fedaaaf41fcdd84ca11764fa5d35233

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
