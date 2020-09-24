Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70522776B5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgIXQ1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbgIXQ1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:27:32 -0400
Subject: Re: [GIT PULL] sound fixes for 5.9-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600964852;
        bh=qQbf3MEuW78AaNWJzv49iUVXvOuWVEgQUuShSmczf8Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=H2ryzgQbCVr0V3Ei763RV/zUJPIGqeQnkrqp6BBqhOYmZwv2XI039fYj/OmvYptzm
         4Wk1CplaYXqQpnw6+VlZoYQIMvgRT4X3i7BDWuRJiMKDoOChFPXs0kpAV3ESXkT6RG
         jvpqYDW0aNOeOZneC/C3EKMskWz6A2bFb7j2ZOOI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hd02bturv.wl-tiwai@suse.de>
References: <s5hd02bturv.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hd02bturv.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.9-rc7
X-PR-Tracked-Commit-Id: c413c3102703a453c1312ce2160c6b7ffd55403e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ef7dce564b41e012e1fb45484248a262cd69c10
Message-Id: <160096485231.7937.10923619946384402778.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Sep 2020 16:27:32 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Sep 2020 10:59:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.9-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ef7dce564b41e012e1fb45484248a262cd69c10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
