Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF8E2C7B12
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 21:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgK2UGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 15:06:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgK2UGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 15:06:47 -0500
Subject: Re: [GIT PULL] efi/urgent for v5.10-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606680367;
        bh=Q/CbMmALdHNv9LGunN/QNE28iWmwkSf4m4zPnyLsVPI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dE934MQxO7wfRcIVHKaSGFb8lknoN9DxHohFU3qNbJdfqd2wgOKNHY5hcUArLWspN
         9F4Tvw5RZxEvVPQMCh3pbOYDHioFkMr1L93fcBNS3sYvbxp3SXV6OvNTpJPwLEEC+w
         xfuC1qkvuF+5u1MjRQo9AwuO9wC+BkzKr+cQCF48=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201129104209.GB12056@zn.tnic>
References: <20201129104209.GB12056@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201129104209.GB12056@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi-urgent-for-v5.10-rc5
X-PR-Tracked-Commit-Id: 36a237526cd81ff4b6829e6ebd60921c6f976e3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1214917e008bb8989747b8bf9a721f7a6db8f8d7
Message-Id: <160668036730.1296.1400781858668141089.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Nov 2020 20:06:07 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Nov 2020 11:42:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi-urgent-for-v5.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1214917e008bb8989747b8bf9a721f7a6db8f8d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
