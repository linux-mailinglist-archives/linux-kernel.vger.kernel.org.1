Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF4829F60B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgJ2USv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgJ2USr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:18:47 -0400
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604002727;
        bh=TVCzasfRZeNNJbWfPn3YfwpQCvP6reV5wKxkBCIoUU8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2cFuUzMc8j/xifkn6+huOU3jRzM717OPqa8uootFTHj1HguF9Kre42QGCUtWua6y1
         zkwFu8Q1vkdv8mcuXEMoWQBAtMw5tuA5LcurmrQe0YLcLvMGs0X0jVRYq9IZJ2l0Cg
         wXr+NjVu40DCers2h28jkfHKura6nvEapJsgPmDs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201029184702.GA10611@embeddedor>
References: <20201029184702.GA10611@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201029184702.GA10611@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.10-rc2
X-PR-Tracked-Commit-Id: 4169e889e5889405d54cec27d6e9f7f0ce3c7096
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07e0887302450a62f51dba72df6afb5fabb23d1c
Message-Id: <160400272695.31914.12350336750543754774.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Oct 2020 20:18:46 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 29 Oct 2020 13:47:02 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07e0887302450a62f51dba72df6afb5fabb23d1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
