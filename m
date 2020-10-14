Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D5C28E914
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 01:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388567AbgJNXCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 19:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731030AbgJNXCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 19:02:15 -0400
Subject: Re: [GIT PULL] Backlight for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602716534;
        bh=/NQG61T71rzsKGDiVlGGgxCukWPXNS4UEQ61WrUshnE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OO3BrfVTv8kmx5NnWxGZLeksi6gF4sdU2ytLT84ChiRYiEPdbTz4eUANhw8qjUts9
         E2PCQFccgDnCqCXvHdxYfIdTVG8eMl+l3uWEivaN5Sf2R1/v+tr++Jwa2Ady7ShhUU
         dNGMuIMwgc/9qZHfAuxbzACR7IDh6mNB0m8w8BN0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201014161040.GB4545@dell>
References: <20201014161040.GB4545@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201014161040.GB4545@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.10
X-PR-Tracked-Commit-Id: 97ecfda1a8ffc5ffc9681d0dfa65fd5b39839dfe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6448cbf662c7858c0d9eb0b135962bedd6d0b9a0
Message-Id: <160271653401.18101.13588565543424592527.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 23:02:14 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Oct 2020 17:10:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6448cbf662c7858c0d9eb0b135962bedd6d0b9a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
