Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEBA2DB819
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 02:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgLPBBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 20:01:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgLPBAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 20:00:45 -0500
Subject: Re: [GIT PULL] regmap updates for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608080405;
        bh=47WA2z1Pt6490H2mnfr4RGUa3aAosGoBFPeZALIXKLQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UbMPTdZIy77Bb6CJXe3slJ5pAfyK9Uv/YacyfKTfLo6cawn8I659UfpYhjj52ISHV
         WHu16u1nsR617t+0SjBQpn9KDbsOfnDr7f58qv+08aZYYcm3ml87QVm5cboo7AU659
         pBKiXJY51OI0224TdUx02Q9HQ+T/XY9dnGx2ZjsuozK+DwB3Cj6L8NHQ8ZXB68yr1S
         D5eWIATexaHP+Wz4eROQHyYvDX43dQzJgzLtcImjGszvK/XJXwxudSIFl5JQRx/tfF
         BfAGrliOpBCnxLYNfGERFxqcD2Snx1qHgOEfQT6AGIK9uecWyFoFx1u/Kn9/hkCb9+
         edqRtlnadxRrg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214144753.1DA3B22B4B@mail.kernel.org>
References: <20201214144753.1DA3B22B4B@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214144753.1DA3B22B4B@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.11
X-PR-Tracked-Commit-Id: 4616c509d187d2afda4a8f1121c2a3ef16bbcefe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a45f1d43311d3a4f6534e48a3655ba3247a59d48
Message-Id: <160808040517.29502.18276442409211028057.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 01:00:05 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 14:47:31 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a45f1d43311d3a4f6534e48a3655ba3247a59d48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
