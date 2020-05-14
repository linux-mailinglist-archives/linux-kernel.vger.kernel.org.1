Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22FD1D3EFB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 22:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgENUaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 16:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgENUaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:30:03 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.7-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589488203;
        bh=2fV6FXaih3d1LNH4bSHTlCs2BKGVobhSasfNvqF+6Tk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qPcA8Jh6iw1s44+sKTips4c4g3CpAd8xNV/SOli5+KiRJq5vn66PTu8HLH7qYW3aR
         jGozAnwWjr+H05gkItWCbBDxW0tkJAUj4+PU1E1R+6N8wOi4mZs7FaHxvLyjlSwd9P
         s8IxCTlwsi8YB8gD7VrWFUVtsCh7+4DeLjYKRFbY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200514193136.23283-1-ulf.hansson@linaro.org>
References: <20200514193136.23283-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200514193136.23283-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.7-rc4
X-PR-Tracked-Commit-Id: 45a3fe3bf93b7cfeddc28ef7386555e05dc57f06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ae7efb388540adc1653a51a3bc3b2c9cef5ec1a
Message-Id: <158948820347.8952.4690689675946895652.pr-tracker-bot@kernel.org>
Date:   Thu, 14 May 2020 20:30:03 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 May 2020 21:31:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ae7efb388540adc1653a51a3bc3b2c9cef5ec1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
