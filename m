Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C8E28BF9C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391286AbgJLSWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390909AbgJLSVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:21:07 -0400
Subject: Re: [GIT PULL] m68k updates for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602526866;
        bh=sTIvbG+GQSByXrHkd112d+HmskalpXJt/t7TgzG1e0A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PTEbp9sB1WjIJMeB0HzI/taW+aF8ihSzV/xQTgDj9IWuA1GOToMH1926Lbt3+y0OM
         gPyVW7+jKSLpDTl2J0OXyJZUV3b4tru6acU+ABcEdAy668iTg0QL7GuiYIsRqeJTWv
         Va8cTyncypbiIo9NOyhyKLN0Wz+gozkxD+qKF6OY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012120904.12998-1-geert@linux-m68k.org>
References: <20201012120904.12998-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012120904.12998-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.10-tag1
X-PR-Tracked-Commit-Id: 50c5feeea0af99a4401fd54fd72bec1333a496ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af9db1d6632b726a2351426ab8f34374f6f38690
Message-Id: <160252686628.3643.10858367655936662834.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 18:21:06 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 14:09:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.10-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af9db1d6632b726a2351426ab8f34374f6f38690

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
