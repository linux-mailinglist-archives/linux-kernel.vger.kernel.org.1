Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E7C1D57E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 19:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgEORaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 13:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgEORaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:30:04 -0400
Subject: Re: [GIT PULL] sound fixes for 5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589563804;
        bh=sKBIIpmUArzEbXtx6N4yrREvSy9ewVLv83iA/yhW/NM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z5khTK+e9Xv0Rj5py1DcbRkp47vkF5CrzBkovdqfl0mweDo9oE9z/LLznuz9lVEJL
         Ej/02EVk2tMSvu/bUfdNyS7btFmDlzBDBg7HztAdUyFrsS0D+i4lWqYyQjpOhIy5o8
         R4P+aVu3kn/UuyP8u2LCxtCNQ1ArHlicIlBxPvIs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hblmpmol5.wl-tiwai@suse.de>
References: <s5hblmpmol5.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hblmpmol5.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.7-rc6
X-PR-Tracked-Commit-Id: b590b38ca305d6d7902ec7c4f7e273e0069f3bcc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1742bcd0cb3047d86e9d17d07fd46710c7ffad1e
Message-Id: <158956380440.31776.1970436753823558373.pr-tracker-bot@kernel.org>
Date:   Fri, 15 May 2020 17:30:04 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 May 2020 13:20:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1742bcd0cb3047d86e9d17d07fd46710c7ffad1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
