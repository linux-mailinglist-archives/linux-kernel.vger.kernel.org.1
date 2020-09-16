Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64BE26C8F5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgIPTBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbgIPTA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:00:28 -0400
Subject: Re: [GIT PULL] clk fixes for v5.9-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600282828;
        bh=A0COw23VAj/7TeyF+lOZCD1BRT1u+Crud34kvluH1WU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=I1d0oaNyD4CFcPMEMXptur7R5BzpzGighwtW0s0X+QT4Cr+v44r3B+VCi+pYkTGy/
         YxcAGATKqjk6SVYrIu3/uc66hfY9NMXhOUvT/C1nzJ+lwgXJ7X2Uw4GAkajT+dibjy
         S3binjYNf3qV0GRJb1wav/HQexikORGgylbg0sYM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200916015808.3287134-1-sboyd@kernel.org>
References: <20200916015808.3287134-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200916015808.3287134-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: d2249bf25c565b6e310453962fef63f8d38677a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05da40eb47cdbc9c18bc2d7256a760931914041e
Message-Id: <160028282804.10105.13430645486798839959.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Sep 2020 19:00:28 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Sep 2020 18:58:08 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05da40eb47cdbc9c18bc2d7256a760931914041e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
