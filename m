Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEEE1AE3F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 19:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgDQRpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 13:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbgDQRpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:45:22 -0400
Subject: Re: [GIT PULL] sound fixes for 5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587145522;
        bh=/dnkughh1n8P56Pxh4knn3Doyi8au2e05RCMTooUCKc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=L7NkxHUrLfFYZ6sq+/APTjzwdA1SEvTjw6oO2Ovm6iLZ/56KFmHbcr3C7wx9FN4F2
         0jv2a5qiAhGThjK8W8wQVhJj8FGOukcoJnQlMw4EiVdrCV+SYeqEG09lqddG/jyu0v
         LTuy1SWOu03lBRcy2hZWSSj8TcHqJOCrT6fmtOxw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hr1wm9ud9.wl-tiwai@suse.de>
References: <s5hr1wm9ud9.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hr1wm9ud9.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.7-rc2
X-PR-Tracked-Commit-Id: 9a6418487b566503c772cb6e7d3d44e652b019b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8a6552ff1155788b9a25ad376ab42e0742eef6b
Message-Id: <158714552198.1625.111665942813850504.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Apr 2020 17:45:21 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Apr 2020 14:20:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8a6552ff1155788b9a25ad376ab42e0742eef6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
