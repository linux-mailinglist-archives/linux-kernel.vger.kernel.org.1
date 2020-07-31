Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3185B234955
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 18:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbgGaQpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 12:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731303AbgGaQpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:45:06 -0400
Subject: Re: [GIT PULL] arm64 fixes for -rc8/final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596213906;
        bh=UMDKOQZ20eK6TGMQ+mpKdobgo/JPdU/VszLuX9TcTiI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qsos9JdvLjv2nn43zcGjojCJS1ALvM15ks0BDRsK7OaU9X46XXwfk1qaWU2cCaR6f
         vMxrqr50HzbNB/AfAp7IBWAsbprOCHRd/ckrTdG/0NEO9rO4rvuW0IojAs3bq7jBxQ
         HwijSjydo24rxU5FCYcOPg3I4CTt4/4ixpSqVSKY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200731123105.GB26817@willie-the-truck>
References: <20200731123105.GB26817@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200731123105.GB26817@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 6a7389f0312f01bb6641d37b395548a2922a057c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14aab7eeb9f0b9c424aab0f07eb82b1baf2e5bbd
Message-Id: <159621390613.29129.17122399995927321240.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Jul 2020 16:45:06 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Jul 2020 13:31:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14aab7eeb9f0b9c424aab0f07eb82b1baf2e5bbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
