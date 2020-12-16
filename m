Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9552DB816
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 02:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgLPBAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 20:00:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:50604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgLPBAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 20:00:45 -0500
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608080404;
        bh=M5s9pmb6icGPfBMy2mjZO6llh2/6FTrkl/m6/D0gf2I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=k1pSljwg4ZxX3IDL7PJKY6jEsXdjI93C9QNK90aJj7ybBOWjdFGlMKXj5baKUA653
         RnuvKeqjgbb04qVrBZYYooovc/Ok+SuLYV4dzuK12Ns58owYxkG5VaES8Qh1wT0CoE
         l+6ViNml2K9ZgBdDVJi24xTJKgH0KmK/lXv+SL94VQ2LZ4PoDWPRcrB3dznKu32ASH
         818HvhZt9Ic8eHqaK6vRIwAAnS52opC6sxMljLP0ShdjzpRURFDI2I4CGeqzVHvKam
         dvEADl2y6g9i3J6wQSz3ElB7LQJrz1YE+v4jMNrIx8Pj2G3vVglssRiUM7mQ7bOxbF
         L0cFOEduxuX5g==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214132822.248987-1-ulf.hansson@linaro.org>
References: <20201214132822.248987-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214132822.248987-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.11
X-PR-Tracked-Commit-Id: 72b248cfbf3fd308807afe7cc30d05fefeff7fb1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce51c2b7ceb23a23eb0dc523c80879d8f35e4f38
Message-Id: <160808040473.29502.5339164487867468311.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 01:00:04 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 14:28:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce51c2b7ceb23a23eb0dc523c80879d8f35e4f38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
