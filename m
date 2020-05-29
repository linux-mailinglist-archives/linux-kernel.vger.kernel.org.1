Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC1F1E8992
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 23:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgE2VKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 17:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgE2VKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:10:05 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.7-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590786605;
        bh=wbDSQIu+fxpS+dXqUvdtTPyHNi2/iFqBv10jvDeqrcM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wy8FOvsGTe+cUL3u8oIJpR36vnafcWUIu6Gah+6pOR8PWr4M6xzMKpgpo7t71oBV+
         nqg1YZpZq6QhKyZ95afzKu+H3p3FQZsxeSxL8GXgoP96YBvncHjQMAC0e5H1VCD5lD
         DCMAAFoIiR3hggpPW0d/o7wrxD6+mDOpvBKfEFHc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200529103230.13171-1-ulf.hansson@linaro.org>
References: <20200529103230.13171-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200529103230.13171-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.7-rc6
X-PR-Tracked-Commit-Id: 202500d21654874aa03243e91f96de153ec61860
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 411ea6790e736da763d02da7e704107ce9365451
Message-Id: <159078660518.32003.11524358665584005860.pr-tracker-bot@kernel.org>
Date:   Fri, 29 May 2020 21:10:05 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 May 2020 12:32:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/411ea6790e736da763d02da7e704107ce9365451

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
