Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AAA203D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 18:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgFVQzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 12:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729493AbgFVQzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:55:23 -0400
Subject: Re: [GIT PULL] regmap fixes for v5.8-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592844923;
        bh=h5Lx1RGc3O21VaF7jG+L3xKJtezVSulbxP3amO0rHXM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Xqj6sk0PMPYKpV66v3yoSD0LbhFCufVX0cHugKDyZgJGkL7mcgwJPZzTAYsb7r9WA
         KGJexXb2LJGfzTJjfNAEM1CyQYrUYHtWSp7aoAG9zGmbsAoH2JCt5PDM0UYpriB5tf
         eaRMPu4qTSIvO79HVXErcp/QP6cWrErL1v41ypsM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200622114015.60DD1206BE@mail.kernel.org>
References: <20200622114015.60DD1206BE@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200622114015.60DD1206BE@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
 tags/regmap-fix-v5.8-rc2
X-PR-Tracked-Commit-Id: 95b2c3ec4cb1689db2389c251d39f64490ba641c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a00087068542b4324b54a14278acabc50f2a61b
Message-Id: <159284492338.20511.10320394214803864419.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Jun 2020 16:55:23 +0000
To:     broonie@kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 Jun 2020 12:39:14 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a00087068542b4324b54a14278acabc50f2a61b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
