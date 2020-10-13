Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C91628D393
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 20:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgJMSYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 14:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbgJMSYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 14:24:06 -0400
Subject: Re: [GIT PULL] regmap updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602613446;
        bh=r3+sBDHYp2nR4HFQHa4eCzYXyL0O7cptu4PizP4Fi5o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=G/gR4lBKP7GveJ/x/n4Viytz2VulyxUN8nO/fzTqX9NdGf0werRDwy/U7nCnhzORJ
         6isWMBMoqCTHcMQgv2NoWE/75WZm9eukjExIUbpW0x8ToGWeKfCozk/FpCL9L+DYA0
         h3w2GnSMjZVIHp//ivSmydeLfDulyfH/1vbU/FaE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012130904.B63C32076C@mail.kernel.org>
References: <20201012130904.B63C32076C@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012130904.B63C32076C@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.10
X-PR-Tracked-Commit-Id: 6e0545c4f08368e67496111778a726f9a2031f26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57218d7f2e87069f73c7a841b6ed6c1cc7acf616
Message-Id: <160261344639.11865.15142292929674904197.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 18:24:06 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 14:08:49 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57218d7f2e87069f73c7a841b6ed6c1cc7acf616

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
