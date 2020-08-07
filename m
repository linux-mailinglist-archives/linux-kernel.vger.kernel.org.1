Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF6A23E5A7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 03:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHGB4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 21:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgHGB4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 21:56:08 -0400
Subject: Re: [GIT PULL] auxdisplay for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596765368;
        bh=s6MsJr//dYnGoBao7cSD8ADX9UKC2I4PuoQ7Ehbo2tI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YPporZ8CQNcdnvdnvAAubFMd0THz/JL+OBL/Fawbfd8XKDt3wSUMTkybzPWicQu8M
         1P6moAuAwGursvmnPU9fsQzWwuMhy+g/JeBWQMR38k1INAU04Js04LBzQhq+1zFtXW
         vlA5fl70iKoOQ0Kv+74daPC2LhWKYT9OG3bhbeZI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200806190421.GA4273@gmail.com>
References: <20200806190421.GA4273@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200806190421.GA4273@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.9-rc1
X-PR-Tracked-Commit-Id: 3f03b64981723b61048ea46642bcaa9b518f3ad3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed35832648b5c22ce39fe9c476065389c6f330ef
Message-Id: <159676536849.30846.13144645432553904215.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 01:56:08 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Aug 2020 21:04:21 +0200:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed35832648b5c22ce39fe9c476065389c6f330ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
