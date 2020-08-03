Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B278723AFA3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 23:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgHCVZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 17:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbgHCVZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:25:04 -0400
Subject: Re: [GIT PULL] remove unicore32 support
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596489904;
        bh=Y/kU5G6GC8hZ7UbZFteO6xnI6EZqch48cxo86BjBqsc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Hbx28XB9ZvVVMThVqKmQO9yTNF7/U+6H2cNuMf3yB4zFPjc+lUk039cBe8OTYPKIz
         5rByEVA8B8JfLTvr2gO0gOWhR7+teLNLDgZ3/eQdFobmozy0r7m8e+X7TEl6GhHVqZ
         WJ2j0Q0N0tICTYhjy3xwjcNvqf/RuTFsoCNsvdas=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803093939.GA8243@kernel.org>
References: <20200803093939.GA8243@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803093939.GA8243@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/
 tags/rm-unicore32
X-PR-Tracked-Commit-Id: 3346dd99fb4cd174fdbfb68dc62cd109e4323f0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05119217a9bd199c4b8b12c01f86df09108b109b
Message-Id: <159648990386.7765.5540573768023159678.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 21:25:03 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Guan Xuetao <gxt@pku.edu.cn>,
        Guenter Roeck <linux@roeck-us.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 12:39:39 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/ tags/rm-unicore32

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05119217a9bd199c4b8b12c01f86df09108b109b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
