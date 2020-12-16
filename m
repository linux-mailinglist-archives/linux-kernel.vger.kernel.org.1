Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439CA2DC971
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 00:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgLPXLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 18:11:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727512AbgLPXLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 18:11:33 -0500
Subject: Re: [GIT PULL] IPMI bug fixes for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608160252;
        bh=69VYoBgLvq+vxGM2wQyHL0DNdXSJRqMxZossjb5FAqw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=G0EIGZHV+9aUKlY0PybCOOH7MsNrVk0av6f3/QPqypGm/YmbMZic3iyy4kkcMUVSn
         O8WRdHA5M0IMjyLwXe6fi45XMZ+aIxU8p3CCg82KY8g79hwM5o7OFrh5svOCnJteoN
         ISW9q3cDd4N2aH4nRjIV8W3YFLK4WRAmEjF+QjqZ6p75w/ytGSowQ39P0i6K6pRZfk
         Rh6b0xUbFGHln0PvLkbe8ufM0pWj4t16C+W0qG5Y2Mj10MUMMk+vocwXPRJeSVC61W
         kPzmnTx6H70ow+RxmoLOdqjavQIS118FXBEJXPguGGNuz50a+8KoWELv3h2ShCopzR
         RKycWC4U0khKQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201216142959.GT11017@minyard.net>
References: <20201216142959.GT11017@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201216142959.GT11017@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.11-1
X-PR-Tracked-Commit-Id: fad0319cacdf02a8d4d31aa1d8dc18c5bd5e397e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f67d6620e413a167e861ce5733c1be5a2384e0c4
Message-Id: <160816025269.24445.10901831659003770309.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 23:10:52 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 16 Dec 2020 08:29:59 -0600:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f67d6620e413a167e861ce5733c1be5a2384e0c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
