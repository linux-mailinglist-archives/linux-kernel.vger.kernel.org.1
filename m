Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CD623F3E5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 22:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgHGUkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 16:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgHGUkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:40:23 -0400
Subject: Re: [GIT PULL] kallsyms_show_value-fix updates for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596832822;
        bh=GQRkXJQAkqfaBJU86+um8pwFGfM5sYCCvw7/BEAzpi0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=baTgB0U6M8tWS/jDhWSnJmI3d8rChRatmQg9leuK/8/ERZsmoDMTFmuGpUED11cOi
         KjC8J5FIurQpgCZmIDObqIXkkPT2FoBoZBAYAGv8ykylBaGBzB3AwfruRuy25/ys55
         QtLjvSIVXFrg5j7jTEjWOkhXcW0vTG7cvK39iBLs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202008071250.7DC8D5FF61@keescook>
References: <202008071250.7DC8D5FF61@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202008071250.7DC8D5FF61@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/kallsyms_show_value-fix-v5.9-rc1
X-PR-Tracked-Commit-Id: 9af47666cb0f331bfcd76799ee368cdfcb00882c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ba0d2e4fc2f3e8544f40fb1165c668f78fe951c
Message-Id: <159683282286.2860.7253925962077804147.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 20:40:22 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Shuah Khan <shuah@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Aug 2020 12:55:32 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/kallsyms_show_value-fix-v5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ba0d2e4fc2f3e8544f40fb1165c668f78fe951c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
