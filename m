Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F142DB823
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 02:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgLPBBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 20:01:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbgLPBBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 20:01:25 -0500
Subject: Re: [GIT PULL] regulator updates for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608080405;
        bh=GoyDXgOFrUOnWgGexIku5oQ+T9y280uvt8QC+eeFvPE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZgG189w6L0m3ZguXCdeWeX2BFq0SxOUdWVuTRvvN6IqtOTqZXwEiMkhxIIDZuwxdK
         yTKEo8mfwl0WJI1VOVZTqwxeliYWd9LErCO0Y2kNrCn1RvfbPHzCVd4Bqf3Sw2l2GF
         bqJJr/HhjyK1eZdwoH8H8mflqcVHV1/lJ5BOFE/uX0Df24tMNf24QOXcgwimBOtj8D
         Dqb4GFENgTiZ1iOBgAWBfU2eCzc5aSi8lT+P0vqz1TPvyXnCAW8HXMk2djYVOb2pnJ
         manHRuX/ikBJJDRsEyTCcMEmtuXOFT5o/EpaOFHSSMhBedh4JSU0R0jt+oFLoyIZcq
         b2JgywsbDLfDg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214144810.9BF8022C97@mail.kernel.org>
References: <20201214144810.9BF8022C97@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214144810.9BF8022C97@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.11
X-PR-Tracked-Commit-Id: 5e999f10a16b90fc1d5ded8aa365e9804e894aa9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2dda5700ef6af806e0358f63d81eb436a0d280fa
Message-Id: <160808040584.29502.12016516613730477077.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 01:00:05 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 14:47:51 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2dda5700ef6af806e0358f63d81eb436a0d280fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
