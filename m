Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FBD2F5423
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbhAMU3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 15:29:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:34826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbhAMU3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:29:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8716E22795;
        Wed, 13 Jan 2021 20:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610569738;
        bh=9QCztcLnLLWMRX4cxjXejBAMFmhqjbOpAc6w3zPseII=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=npSPWvuSEA/x64LxYnE3TbywHxW27oJdw+6qEFD27cjIEd83hETn+aX7fh527i9I4
         o4sKXMTBfjdzPQsjGIoOodiCbbiegFldjiMw/T9STkp1G43c791Ffm0VLAuIXfMPR+
         v65+6HpGDfcv5+rNtSeUWKfJ3o1luXz1qYkJknV1P/AdM/JtCmJxq7BgpQGEDkEtau
         s6AHFDFfRekZgFMPTVB3QE+DQy9kpok6dZvA4lhnDqz+DVPXr7n6V2YjDWR1jycmYT
         09+qwMA/bbX7sJaN5nhccA8fmfOLQ2Gl5uGXFNo7VWii00c57WLmR8yxdPGzWZa26k
         9icCuozb0uEGQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 7242E604E9;
        Wed, 13 Jan 2021 20:28:58 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.11-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h1reoopbh.wl-tiwai@suse.de>
References: <s5h1reoopbh.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h1reoopbh.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.11-rc4
X-PR-Tracked-Commit-Id: 20c7842ed8374e1c3ee750b2fe7ca8cdd071bda6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65f0d2414b7079556fbbcc070b3d1c9f9587606d
Message-Id: <161056973839.29351.551452150479023263.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Jan 2021 20:28:58 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 13 Jan 2021 15:59:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65f0d2414b7079556fbbcc070b3d1c9f9587606d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
