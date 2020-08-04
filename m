Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7806523C1A0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 23:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgHDVkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 17:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgHDVkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:40:08 -0400
Subject: Re: [GIT PULL] pstore update for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596577208;
        bh=xsPQ7Qth5EFucpKcRnFqI5uQYpt+IrjVTwuaq7mYUiE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gKKl5ZROWaFRf9y1zZSGE6en3SkrHqqxLXxzixuy4rSyx2NQ8ZTJFRh7oinp6UI8h
         06sWY58zI/c/1KKMFwJVLyNz18eYetG8ItWYUns/1EtjYzw6VcaxdICi1qDdwadF0J
         qGpPhVSBoCnd7iRPNnnOanvlUIKPlfU/eHQFDoXI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202008031146.53572B446@keescook>
References: <202008031146.53572B446@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202008031146.53572B446@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/pstore-v5.9-rc1
X-PR-Tracked-Commit-Id: fd49e03280e596e54edb93a91bc96170f8e97e4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19a93823cf63d44d04c7571152087f12cb2199e6
Message-Id: <159657720848.17686.11807761859224601727.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 21:40:08 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Matteo Croce <mcroce@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 11:46:57 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19a93823cf63d44d04c7571152087f12cb2199e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
