Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7E919DFC5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 22:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgDCUuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 16:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbgDCUuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:50:17 -0400
Subject: Re: [GIT PULL] kgdb changes for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585947017;
        bh=DiRpGhTeU4wYy9UC5PPgXT5vDwBSjXcIqCW11YxuvZA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mZ1XDO4yubo9ndASldlFfHJyq4yaFs5mVBiXXmgly3SHr50j9yDdCs19OOC7Zgl7y
         yXhOHt4Cj2zcnnjopUD//i7KKRyY7bhTG5Ta6r9In+A7Lln2IjUEGpz1QGLtciIUAv
         y3LOSMNNHwGfIsfmIZCoLX7eSVFFVtfyocS0XAuY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200403090936.4xygjiuct5jtbulb@holly.lan>
References: <20200403090936.4xygjiuct5jtbulb@holly.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200403090936.4xygjiuct5jtbulb@holly.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/
 tags/kgdb-5.7-rc1
X-PR-Tracked-Commit-Id: ad99b5105c0823ff02126497f4366e6a8009453e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2c3bec3c90df7a68bc24924426ff59183e028a3
Message-Id: <158594701701.4594.5844651723386032372.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 20:50:17 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Apr 2020 10:09:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2c3bec3c90df7a68bc24924426ff59183e028a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
