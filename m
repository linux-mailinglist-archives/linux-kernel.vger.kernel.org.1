Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776852EE6C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 21:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbhAGUYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 15:24:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbhAGUYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 15:24:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3503D23444;
        Thu,  7 Jan 2021 20:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610051041;
        bh=uTP89ZF0SZD6w/fxLXt5Mc8yX75DgnWvcUUzlYnpAIA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lJxgag66MXo5coX0KSxQMZbewBpbiAtcxA7opl9BsoHo7lj4LIcoPq3LdfPIORkFA
         Bik35NdMFYdD7NWHxwhsIe39dho6hotcimiWEYOhKSYftb0ftu15tV/EYGnyqFtm+9
         Lc/g3M4tzwPxjBHF7I1Skiox14wKEdr1cKI3MtNcb7I5ahZscEsgaQwv+laQpgmtwt
         We6nkShcX1Fw1Cun+3NeKUo7Lhq11hD9FBzeVfy7e03iXNdp9e8CKNvI4NgdgQHgIV
         djgR8Z49dHhhRp6lcj2IH0WfGN3+Ov+xjqeCK57K65C8K+3v7YJyxS4bX5VR5nr8Ei
         g6Yd0tDexPrrA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 2CB0C600DA;
        Thu,  7 Jan 2021 20:24:01 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.11-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210107171041.11778233FD@mail.kernel.org>
References: <20210107171041.11778233FD@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210107171041.11778233FD@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.11-rc2
X-PR-Tracked-Commit-Id: 36836f5b377b5a75c16f5bdc5c0f97f9f51212e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1a7b4f32433e91f0fff32cde534eadc67242298
Message-Id: <161005104117.19187.16828197418880498380.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Jan 2021 20:24:01 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 07 Jan 2021 17:09:55 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.11-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1a7b4f32433e91f0fff32cde534eadc67242298

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
