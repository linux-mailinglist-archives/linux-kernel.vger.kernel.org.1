Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6851D266854
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 20:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgIKSii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 14:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgIKShO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 14:37:14 -0400
Subject: Re: [GIT PULL] regulator fixes for v5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599849434;
        bh=Tf67Ub0CJNBqwUYWKE8SkeCCUWSpNHKCiNKi833HX/4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0IKi7M7wgHvCm2ngDb2RA1ojde+9evCULhWimTNaFWa9SN0Mc7oaol295eJhoRBH3
         XGKmBRRQHN23sUXPTMzTJaKFp/1+TTkLUWXwjx7xk6+SSzTiCGv9YBwh2QNaO06d+Z
         ub+PcyME7DmLE+/TGfwbR+TWvZOMHJnsiUqGPx/M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200911122317.2E34421D40@mail.kernel.org>
References: <20200911122317.2E34421D40@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200911122317.2E34421D40@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.9-rc4
X-PR-Tracked-Commit-Id: 59ae97a7a9e1499c2070e29841d1c4be4ae2994a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b6ce2517797efa216115630a12d7cb076bb936c
Message-Id: <159984943412.11596.6481222950601274014.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Sep 2020 18:37:14 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Sep 2020 13:22:23 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b6ce2517797efa216115630a12d7cb076bb936c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
