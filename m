Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C34C266852
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 20:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgIKShf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 14:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbgIKShN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 14:37:13 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.9-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599849433;
        bh=kjfsdsop3DcCK/oCkVhxK2nbwoVQGUeRvFE8Y/EXgUw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FoM6SGjNWaQThAW7cQd5yNAD6qztD9fQFCzotQroX6eMc7o9F5r/+hRVTjCCW3CAO
         ATvauJd1O5NWdB/vnxQDi9/dAghVVXlJtFq9gFuB0Gdm+/m1kbGlyxK8sih1EFAj2v
         skuYe1xLamWR2/30v7TMQ3qi+YqqB7yYnxNsBPQQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200911100234.754555-1-ulf.hansson@linaro.org>
References: <20200911100234.754555-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200911100234.754555-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9-rc4
X-PR-Tracked-Commit-Id: f0c393e2104e48c8a881719a8bd37996f71b0aee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 063d6a4ce378ca248d48d700220e5f18d8969554
Message-Id: <159984943322.11596.13245984584505688773.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Sep 2020 18:37:13 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Sep 2020 12:02:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/063d6a4ce378ca248d48d700220e5f18d8969554

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
