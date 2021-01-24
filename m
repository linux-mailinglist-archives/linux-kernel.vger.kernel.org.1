Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E28301E7C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 20:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbhAXTgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 14:36:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:41652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbhAXTeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 14:34:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A529022D73;
        Sun, 24 Jan 2021 19:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611516830;
        bh=goISL8kTcWDrJSkwaHP6cwWfvDy2tg9uyxZgegufS2Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e8u/ENnH0fKij/pHKs1mW93ZCerNSi3N0R/sYn/l2leUYa06UvblIfm7r4c6rTtTn
         2BblMxC2H8hEWNHemyIAfJOLEZGZKZxfoivdDTCyl9NkXUejqcSCGY2alQtPmr/JLf
         9O46icDbWb+IfSjOJ1Higg51iucUlcs5ztXhODTqer36XJ+zybpxMb5wmHfbYmFMax
         0vZnjNRKjcmRJPYFR62x31kxHCOWMYUgU19jWfzgHb74ue6/85/d3RKtpRdj/uT5YI
         83EeL3DjHrQsvQvI+ZsISjaFLjXKGCZ966fMlhkgMYKhpHArEbNhqBAr2BawaC6U4I
         lAEjoBn9q8C5g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A1D88652F1;
        Sun, 24 Jan 2021 19:33:50 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YA1u+IPixwAx6t7P@kroah.com>
References: <YA1u+IPixwAx6t7P@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YA1u+IPixwAx6t7P@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.11-rc5
X-PR-Tracked-Commit-Id: e020ff611ba9be54e959e6b548038f8a020da1c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 443d11297b5c00b9ce6ba6e67c766296c96f8945
Message-Id: <161151683065.23923.717747463985515300.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Jan 2021 19:33:50 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Jan 2021 13:58:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/443d11297b5c00b9ce6ba6e67c766296c96f8945

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
