Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCF22A0F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 21:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgJ3UFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 16:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgJ3UFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 16:05:49 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604088349;
        bh=iXQjdIh1MiPFSjG4/3gJq09dt6b9c+eC698b1mRyDok=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Luh3/T+FvCKnr3qwrfVwfyWOGlxfGnVaj25VBXwWTixcuD3t3S0xNVAcdfpz1jOam
         CqT6ZWcRPsS0aFJMCfhVo2TuxCSarTE88vxnvuxtOOnaHqJnUiDo7Hhx6qy44BijBw
         JQQnGgFSE/uMJyf9uQCPyAswlp7NhYX6U9SBtJHA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201030120752.100388-1-ulf.hansson@linaro.org>
References: <20201030120752.100388-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201030120752.100388-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-2
X-PR-Tracked-Commit-Id: 011fde48394b7dc8dfd6660d1013b26a00157b80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88098fd61b7e52e1f78668b6f1f07d39ca67301f
Message-Id: <160408834941.13990.11062361835301766189.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Oct 2020 20:05:49 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Oct 2020 13:07:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88098fd61b7e52e1f78668b6f1f07d39ca67301f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
