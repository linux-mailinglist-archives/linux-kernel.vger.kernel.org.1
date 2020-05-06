Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AFB1C7E22
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 01:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgEFXuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 19:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgEFXuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 19:50:06 -0400
Subject: Re: [GIT PULL] chrome-platform fixes for v5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588809005;
        bh=3LkVkW8FFEro8XBmMgoTmhrvLLXaBTA0Q4LwBsyWelA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u5NBy9+VEJBfcTDCCQeGoDGZqEtgvIEW+Xi9PHSdRMXaj/wOtCl8Z6FoiRg2yjoYN
         G1mk17xyhza9KyKeZrLRW2PSwxCmzVaWgnhlpk4POQwSGGKlsjhUq6Hm0EKFZEjNZA
         1qHiWJt829IE7oeJkw7KI9a25wOSVyLtwAA4ZrLY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200506224737.GA159981@google.com>
References: <20200506224737.GA159981@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200506224737.GA159981@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 tags/tag-chrome-platform-fixes-for-v5.7-rc5
X-PR-Tracked-Commit-Id: b31d1d2b1c3a8452f425b09ebd374ecd3ddd5179
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9388959ba507c7a48ac18e4aa3b63b8a910ed99
Message-Id: <158880900584.4672.10849861127175850912.pr-tracker-bot@kernel.org>
Date:   Wed, 06 May 2020 23:50:05 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, bleung@kernel.org,
        bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 May 2020 15:47:37 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-fixes-for-v5.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9388959ba507c7a48ac18e4aa3b63b8a910ed99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
