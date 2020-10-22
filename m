Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1861C296463
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 20:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369508AbgJVSFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 14:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S369494AbgJVSFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 14:05:17 -0400
Subject: Re: [GIT PULL] exfat update for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603389916;
        bh=9jkZjyWReeky1FhzrduFNpUvUjxxcvRt/3EDwiSNBGE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RIFfvLZJVSE9ShwzHwE94Q2OSLHptXUz8KDXlXp1n2MN07AeV/Bo1BX7UanI5FMPQ
         s1bV3s9N/vEzo5Bt+usjxxbpCMSuYCOSY8RTlKM9IG2X9b3XKGm4IZ/5Q6/Z9Rn6pT
         sYpPimy4WokMnTeNe+BFNsm5ABg4oDmZj5asAlFs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <020201d6a84f$3d93fdc0$b8bbf940$@samsung.com>
References: <CGME20201022084214epcas1p3989473275756ebb83ad2b31dca545a51@epcas1p3.samsung.com> <020201d6a84f$3d93fdc0$b8bbf940$@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <020201d6a84f$3d93fdc0$b8bbf940$@samsung.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.10-rc1
X-PR-Tracked-Commit-Id: eae503f7eb0509594076a951e422e29082385c96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b06f57b9edb2d67471e626b3ebd247826729a7f
Message-Id: <160338991644.20886.2861269600433938040.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Oct 2020 18:05:16 +0000
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        'Sungjong Seo' <sj1557.seo@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Oct 2020 17:42:14 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b06f57b9edb2d67471e626b3ebd247826729a7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
