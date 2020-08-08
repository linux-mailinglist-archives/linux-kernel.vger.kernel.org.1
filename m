Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC7B23F844
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Aug 2020 18:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgHHQzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Aug 2020 12:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgHHQzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 12:55:11 -0400
Subject: Re: [GIT PULL] IPMI bug fixes for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596905711;
        bh=qfR/wMHzJHrpcdc9ktvRtkXIn/K99xeYWnheflvyOrk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rrreSVf68vqj7yjrYP89VKvBbX/J0BFFIHowPYFXjJtzFWKbkFcfA+7FlYM6FD+U4
         jU2qUx4iuZ/b32m3P8bp5qYHgpSDa6aq0jXCwG7vcKQ7whnme5rbfTpLBrumlY0cXr
         rU2vSPdipxyuYHw9FQLv9/GZYzPZ8K1FpWWmatCs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200808123407.GP2842@minyard.net>
References: <20200808123407.GP2842@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200808123407.GP2842@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.9-1
X-PR-Tracked-Commit-Id: 634b06def11cf7ecf6282c79735f08004e323983
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11030fe96b57ad843518b0e9430f3cd4b3610ce2
Message-Id: <159690571140.17537.12446723619263173248.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Aug 2020 16:55:11 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Aug 2020 07:34:07 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11030fe96b57ad843518b0e9430f3cd4b3610ce2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
