Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C7428C569
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 01:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390871AbgJLXuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 19:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390620AbgJLXuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 19:50:06 -0400
Subject: Re: [PLEASE PULL] ia64 for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602546605;
        bh=9KhWfuNK1aaM05OJ1FJzEik+1j7q4P7FRVda7XP9IaM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Qkybk/2WXOUg6VhZKbNWo5wuq9gdTVV7Zl77yyZKMRZT8lHuT1aMRvOVG/xT9AQQm
         6AS2Bh1od+/cZR1swbQPS/GRMFfDttjHPxCTeXr0jkZlz54LjJK3oD2+qs/SOjufBt
         RCXnBMl9/qYUG7gf1ifexJQRpORLwHKhx7GgRcII=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012200149.GA27228@agluck-desk2.amr.corp.intel.com>
References: <20201012200149.GA27228@agluck-desk2.amr.corp.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012200149.GA27228@agluck-desk2.amr.corp.intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git tags/ia64_for_5.10
X-PR-Tracked-Commit-Id: c331649e637152788b0ca1c857d0c2eaf34fcbc3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ced3a9eb3cd0d07462cdbaa8a0f3d46e5aaeadec
Message-Id: <160254660571.9131.4901465264885178680.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 23:50:05 +0000
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 13:01:49 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git tags/ia64_for_5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ced3a9eb3cd0d07462cdbaa8a0f3d46e5aaeadec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
