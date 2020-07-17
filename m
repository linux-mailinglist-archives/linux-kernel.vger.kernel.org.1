Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44F9224211
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 19:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgGQRkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 13:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgGQRkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:40:09 -0400
Subject: Re: [GIT PULL] regmap fixes for v5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595007608;
        bh=V0/w2APfIXmPFZspv+qqvRSV/kf8bPMzagD6Xb1UfnI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=v+Pgyae7Cu93uSRfAPWslEFh7aA2iLMh8wAxOEqjajI5aJzEzr28k8l12ShGVbXe0
         09XTYB/jn9t9NbrJezvkDChKnKlJRgK5SYIuuCgH8lZ/dMgY4oE3I83h+yDvOtJRhP
         9MCP4ImMKED6a4Bji3vuYrIiIgP068vyJW5ByF3c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200717154257.6F8E02076A@mail.kernel.org>
References: <20200717154257.6F8E02076A@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200717154257.6F8E02076A@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
 tags/regmap-fix-v5.8-rc5
X-PR-Tracked-Commit-Id: 299632e54b2e692d2830af84be51172480dc1e26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee43695571c258c0945d4c456ea85b2af9aafdf4
Message-Id: <159500760869.14528.167641260699265786.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jul 2020 17:40:08 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Jul 2020 16:42:44 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee43695571c258c0945d4c456ea85b2af9aafdf4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
