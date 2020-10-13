Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEDD28D397
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 20:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgJMSYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 14:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbgJMSYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 14:24:06 -0400
Subject: Re: [GIT PULL] MMC updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602613446;
        bh=bWcf1Ex7Zqbe/LbZ0KQ5/CR5WsiU01n5o3zMf1aTldY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YM1Avdrdwo2swe6RDyflauUaJTW/7HterBHW00azvqQI/SN+rgNcVSb8e0S7M7CN3
         GUEbAEq8VcCsZCZh/6vMRJ3gHOIzQfrbZ8TVcJ5CXKgOoFnDbBDxEDUoHQmtkO++oB
         Qk7fHd7dH/HF7gbvL7uJhxHA+pfR0zqeJvOShadg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012100127.339152-1-ulf.hansson@linaro.org>
References: <20201012100127.339152-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012100127.339152-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10
X-PR-Tracked-Commit-Id: 1e23400f1a7342a2805cc647e6314cd12bfb5526
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 647412daeb454b6dad12a6c6961ab90aac9e5d29
Message-Id: <160261344598.11865.16992348913192665565.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 18:24:05 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 12:01:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/647412daeb454b6dad12a6c6961ab90aac9e5d29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
