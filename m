Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBF82F718C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 05:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732911AbhAOEPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 23:15:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731090AbhAOEPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 23:15:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id DA44523AC9;
        Fri, 15 Jan 2021 04:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610684096;
        bh=Ed/b70cXc1NRdBZ5GtRdxLlrKOLyNr0B4waWLRCF91I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PCvhzugkNaL2reXqQR1lRIvqkT1hpjAY548mQVca5H2WlGUuryjM2x8yGnOFujZwc
         2bQyIchDYIphzLx4d7OMPOkUYkHE7q0E62mvnYZq1pfsZmAIOLeAq6AxmBE9Ox+0A2
         PyEIzdhE3BTmQ62Zy9Bwqr4DoTRclNdJ+hXiv+wrpxkfR1P3vTD7IMNl22Wx8c4WAd
         uu5Ei06Aenk0e5H5cm1NVhmLWf0z+w3HUC7Y9IZ5jOZjQdnOJwidnzw1AQv5vAUMrT
         CMWEK2EHpY7wxYRAVxpsXJFgreJ+BYLYTAnyFiLW3zf3WdpjZ/RSXhdC3/BeKsUhEi
         1WmHNGBRbPnmw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id C9AB260156;
        Fri, 15 Jan 2021 04:14:56 +0000 (UTC)
Subject: Re: [GIT PULL] tools/bootconfig: Add tracing_on support to helper
 scripts
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210114215803.4f1eb972@oasis.local.home>
References: <20210114215803.4f1eb972@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210114215803.4f1eb972@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.11-rc3
X-PR-Tracked-Commit-Id: 55ed4560774d81d7343223b8fd2784c530a9c6c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cdaed110311d45cdbefbb9a23a2d1774717b7b71
Message-Id: <161068409675.21086.7703528238366358046.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Jan 2021 04:14:56 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 Jan 2021 21:58:03 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cdaed110311d45cdbefbb9a23a2d1774717b7b71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
