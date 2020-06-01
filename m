Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CDD1EAFB9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 21:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbgFATft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 15:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729555AbgFATfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:35:06 -0400
Subject: Re: [GIT PULL] hwmon updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591040106;
        bh=DsLVCV1NuoHtjhufBUDWz8RY+x6etGTIlJU0gQLyjOs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AXpWJGX+ThGgNJpppfdrA0fvXxkyL0+oGQdv9sXkP0GbHp6T25XuL3IOqs8zqrxPV
         AEMaBLSTIyrmRBgsCe/nzkaGEd8vnPr3Imi7YKPl3DmOLCqWV6gUsqg5YJtGPMngAg
         yydlek79+Iql5BjhCrqi/QqF0ZfFsh6VWK+KGxbM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601020327.246402-1-linux@roeck-us.net>
References: <20200601020327.246402-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601020327.246402-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.8
X-PR-Tracked-Commit-Id: 87976ce2825d9f1ca2e70ee7d38dec490ad5a6e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 129b9a5c40582cb0dc00aa5b58d1d1bcc93d98a7
Message-Id: <159104010615.18844.4119278139693094724.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 19:35:06 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 May 2020 19:03:27 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/129b9a5c40582cb0dc00aa5b58d1d1bcc93d98a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
