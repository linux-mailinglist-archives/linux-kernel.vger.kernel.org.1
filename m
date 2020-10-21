Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5A3295256
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 20:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504244AbgJUSfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 14:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392431AbgJUSfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 14:35:15 -0400
Subject: Re: [GIT PULL] dmi update for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603305314;
        bh=kG05pqs0XVSzyNZHRayzgPTQxR2ovqLnpoym+P0kBe4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VURZni65fb7F8VX+0GnrpEMrV6YQfQzscEgBlg7fvT2vBrkTblXDTKfOLF4+mkoeA
         faSsHxUgnA+Yg2O6/KPIvT2GP+5ABha4QVslS/uhh5k3fTAHRdYGQv8FA+fW6xY0Sb
         y3ZjzyetbmJTeNH5ZslfFOtbfB1NNK+2eVRcFXuc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201021101601.70393ac4@endymion>
References: <20201021101601.70393ac4@endymion>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201021101601.70393ac4@endymion>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus
X-PR-Tracked-Commit-Id: a3d13a0a23ea20a83d7148279a0ab68cc9a5962c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68a3633694ab37b368edc30d59235e8348e2d00e
Message-Id: <160330531463.16606.14046662211444611728.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Oct 2020 18:35:14 +0000
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 21 Oct 2020 10:16:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68a3633694ab37b368edc30d59235e8348e2d00e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
