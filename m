Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C858F2B30C3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 21:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgKNUvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 15:51:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgKNUvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 15:51:11 -0500
Subject: Re: [GIT PULL] hwmon fixes for v5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605387070;
        bh=MTzezg9zHaeVKPsydu0C0nh1xlpa0wyc7i4iyJEOCPI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z8xbdFW56ogMv2rhzUa88cagCLtOm/kdcCbgPps6mectAjpfg8cLK2zFrtxHGqoCx
         4AacYemMNXprG2v2+QQizwhrBA4sMnzarXfY4gXltIqVo9zIYONLWxZ+dZHKziZFFi
         dnb5T8VxvbIokK7ba4yurpxsi04/unMK9zSKEJ6A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201114015111.55792-1-linux@roeck-us.net>
References: <20201114015111.55792-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201114015111.55792-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.10-rc4
X-PR-Tracked-Commit-Id: 60268b0e8258fdea9a3c9f4b51e161c123571db3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e908b7461ec395293335852485a183c16765303
Message-Id: <160538707091.24878.11851994254044229745.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Nov 2020 20:51:10 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Nov 2020 17:51:11 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e908b7461ec395293335852485a183c16765303

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
