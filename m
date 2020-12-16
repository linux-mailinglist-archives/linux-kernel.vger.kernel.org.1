Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B492DC96D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 00:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgLPXLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 18:11:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727512AbgLPXLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 18:11:32 -0500
Subject: Re: [GIT PULL] MFD for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608160252;
        bh=QI3tuDbOwBctAbTU058tSP05dcrLiMaxVHhf5v6SgdU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sR4cOZeUu914mvkRyw5TdogK/BiuTm0PPu2x1SrIcPF73AcMmdIMZg38j4Ui2X8p6
         BIhoj6BYWKV7CJkKHSXV4P9F9q3jHaAPVIbA23Fgofnlk653kIV4mu5TtxpQemVMIJ
         RpXy/hI0e+3ofvZDsmets0Subwr1b9by8NaZV+5b8e5VZm4MBvZ5jBJ3dxICXS6zJN
         /4/GqZCLlhxkf4/WofTJIo6NMd6/jLD6LeVIyMghDySobgp9wA8H8pzS/6zIRmjJGi
         jmDf0cOYfAOFchgC8sq5Ka+GMtoX0eyUqu42Nv/V+r+Uk2MN7VH1mLQDyLRTwwmtTZ
         EJ4EgmFseLj1g==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201216074534.GC4776@dell>
References: <20201216074534.GC4776@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201216074534.GC4776@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.11
X-PR-Tracked-Commit-Id: 0cd3aa995740eabf8af1c794ac1d9ae314c928c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 278f54c46164e9859090dde7e4ceede830c6beb6
Message-Id: <160816025192.24445.10695627888322975816.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 23:10:51 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 16 Dec 2020 07:45:34 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/278f54c46164e9859090dde7e4ceede830c6beb6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
