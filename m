Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD7A304F49
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 03:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbhA0Buu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:50:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395054AbhAZTHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:07:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id F218C2228A;
        Tue, 26 Jan 2021 19:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611688029;
        bh=ICnARCGTncjkL8EvChUA0fRDRF70y5wXTtPpiccZcWQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=c3VABU5p+p2brZcwkZkgGuXoN/pebX7KcGywmLK46aIxpk5Wr675E1MhQwsPG7f9j
         6pzemkhwruoD588HdfG5KF5P6Uu7MkOKPFXBG91Bn8JPFdN74H7hde1uamBqPI/kWl
         fY8RC0PiGmKu6iew3yTDz8RSVH5OxZh+mbX/rWmdoUNnER1p2wlqqIiZRmzNtgThUK
         /ExqIOUKdgYOtAw96K0u5ph3Rxkz9/Sw2CVGruOcPSXZNEL1qcPIcfmd+M8Js3bIH9
         wonFU1BIhvoKFFneiKZHaT9EsoAdHxtdc1G1EIdXwo2XBzgiHp1ILYuYimRJ44wExB
         gR/DM4GE/F4ig==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E4F1E61FC5;
        Tue, 26 Jan 2021 19:07:08 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210126124529.37C7123104@mail.kernel.org>
References: <20210126124529.37C7123104@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210126124529.37C7123104@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.11-rc5
X-PR-Tracked-Commit-Id: 14a71d509ac809dcf56d7e3ca376b15d17bd0ddd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bec2487ff3361d96a96b74fceaf39ca54866adb
Message-Id: <161168802893.27611.14066962138762591085.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Jan 2021 19:07:08 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Jan 2021 12:44:33 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bec2487ff3361d96a96b74fceaf39ca54866adb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
