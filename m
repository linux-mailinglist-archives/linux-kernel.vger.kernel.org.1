Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7877F279431
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 00:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgIYW1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 18:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbgIYW1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:27:47 -0400
Subject: Re: [GIT PULL] regmap fixes for v5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601072867;
        bh=P07eItEtqd+L/udD10HQtbhvQei6+f+No7K1AxOS4SE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LWmpqmNeAXTKF3afeI3SXCKLWxB0qqtkSS/qVP8yMm6dif4QMFn4m0576EFnEChh+
         llTtD0c0YUXoHEea6PxFVNGbMsnsmGinEPSvfU16Rq9+/h5/xQ3TWJU3OnfqTPGlgz
         YtDNv7F/XW3yxzRkaXWDQEnZP6FrKIEP26BUk7Xk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200925201707.A2D8523888@mail.kernel.org>
References: <20200925201707.A2D8523888@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200925201707.A2D8523888@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.9-rc6
X-PR-Tracked-Commit-Id: 05669b63170771d554854c0e465b76dc98fc7c84
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a3a0876b9c40b1471329e484f503e6f8ca3e56f
Message-Id: <160107286703.23838.11606864178594714376.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Sep 2020 22:27:47 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Sep 2020 21:16:00 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a3a0876b9c40b1471329e484f503e6f8ca3e56f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
