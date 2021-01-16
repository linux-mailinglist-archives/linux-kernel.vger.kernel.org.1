Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4342F8F0D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 21:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbhAPUCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 15:02:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbhAPUCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 15:02:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5A8082078B;
        Sat, 16 Jan 2021 20:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610827324;
        bh=DVvIk3clVWF/bJYVAgfz9QQ1PSOinu69kDhJSJw9DvU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ut7psZGGjGVmw2oDixYJAODGT+rdQ0gKn+905SOqhNDZUOyU1ZsgGM0MSMFfpEkwD
         +tFIM9YryFXcY+mW5ejOD888PnsO2aLJNpfQRQ//Oa6eegQ0cLmMiV/vqzYnj4qDW8
         CcsDHTXXsbJOlbh13ZYuQfiW/8OQIZWWex0fx3W2zDR3Xd/b1+PM97WHTvJdqM93wT
         uloadiL95qJqacEIT/La/2zMwfaLA2wU3fl52Clye7NDjekSP41qtK3r4ksgUyXPWb
         YKKUtcurCMuXoDozfTAV4Zlobuo9DBgJCy8JHE0kukSXVBcfLaJaqmgvDVQnqtnI84
         udThQ3L2yp9xQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 435D860593;
        Sat, 16 Jan 2021 20:02:04 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.11-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-6a7bf03f-5e44-4fa0-a205-0fba77454f24@palmerdabbelt-glaptop>
References: <mhng-6a7bf03f-5e44-4fa0-a205-0fba77454f24@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-6a7bf03f-5e44-4fa0-a205-0fba77454f24@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.11-rc4
X-PR-Tracked-Commit-Id: e557793799c5a8406afb08aa170509619f7eac36
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: acda701bf1e8233f982164c8ddbedc055427212d
Message-Id: <161082732420.9271.13330129912342110700.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Jan 2021 20:02:04 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 Jan 2021 09:54:51 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/acda701bf1e8233f982164c8ddbedc055427212d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
