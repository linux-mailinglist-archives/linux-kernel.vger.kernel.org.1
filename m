Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C38F24500A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Aug 2020 01:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgHNXFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 19:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgHNXFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 19:05:31 -0400
Subject: Re: [GIT PULL] sound fixes for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597446330;
        bh=8+QFhUozxAR70X6uCOqVJsy6N76d6JZ+BWwJDPnUKK4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HNwoQy7lI3d24YL7N47iynsevf+NMna1cwcMwyZRP87M19rGeHYd7IyZ6qt46aSIM
         2VlwgXtB5oHREGD1QYjsBLFOjdxUUL7/XTniPK81ZFcxB4PpqglnXQJpbLyZJ/DxfT
         XZW4zECKGG82bCesAdWD3ISomQ4yXb1kNKq8gKMA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hk0y1slvx.wl-tiwai@suse.de>
References: <s5hk0y1slvx.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hk0y1slvx.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.9-rc1
X-PR-Tracked-Commit-Id: 5a25de6df789cc805a9b8ba7ab5deef5067af47e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87bd8c2b93ae899ecd90a5e0550cdae4260cc4ca
Message-Id: <159744633087.12327.12776591018307770444.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Aug 2020 23:05:30 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Aug 2020 09:54:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87bd8c2b93ae899ecd90a5e0550cdae4260cc4ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
