Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E7B23E3B0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 23:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgHFV7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 17:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgHFV7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 17:59:21 -0400
Subject: Re: [GIT PULL] sound updates for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596751161;
        bh=Hz+Yox0ismqLnQ/e2b1+3hESp7RwBYZDHNnxjFcwadk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LeN+xit+Dt6XZsVTl6pG25/95Lyb0Nvn+T0RFGYMfyQA/9IxYKSVUS2pqW5t8SNW0
         ZxFRd4Tk1920sS+OnAI0YxFCOv48GF4HZ+hPaWy1Op546753VYubpv7Uk9JLWgL6Kg
         1AGS9zTUqc12lHBJWbjUGC7Pp3tvd8SFvcuNI0O0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hbljocbxl.wl-tiwai@suse.de>
References: <s5hbljocbxl.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hbljocbxl.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.9-rc1
X-PR-Tracked-Commit-Id: c7fabbc51352f50cc58242a6dc3b9c1a3599849b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f9df56480fc8ce492fc9e988d67bdea884ed15c
Message-Id: <159675116119.18694.87801193329925317.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Aug 2020 21:59:21 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 06 Aug 2020 12:21:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f9df56480fc8ce492fc9e988d67bdea884ed15c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
