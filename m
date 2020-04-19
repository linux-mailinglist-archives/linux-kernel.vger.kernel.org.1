Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8693F1AFE47
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 23:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDSVFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 17:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgDSVFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 17:05:21 -0400
Subject: Re: [GIT PULL] clk fixes for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587330321;
        bh=JcNrvMY5g2ob6NVR42RKB2ZsGrfLZhyMwA3hGBXbKz4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KHhhEy2J8ZxO/Vv9hmD3JXiMEKiVkRDfW0pj+WLDYFyWLzLDuWT2eSGE1P0gZLoZD
         pJr2Ohb/tn2Mo6H1mp3MJvSxmtzF06MkEjg37v33cRYUjVUW2wFWvhjKb2eLQg7szV
         r5ar81k4tPF5lt/M7xnyz8IoK7xK45iwUb9JF9Kw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200419181210.204996-1-sboyd@kernel.org>
References: <20200419181210.204996-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200419181210.204996-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: ca6df49d62d7cc4c1653a4d9b1ecc61ecd530e02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86cc339856c5757fb4ed34637eb4cf60ab28eb79
Message-Id: <158733032103.8430.9996324040510322081.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Apr 2020 21:05:21 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Apr 2020 11:12:10 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86cc339856c5757fb4ed34637eb4cf60ab28eb79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
