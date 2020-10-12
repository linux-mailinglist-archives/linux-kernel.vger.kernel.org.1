Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F13028BFA0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390859AbgJLSW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390872AbgJLSVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:21:04 -0400
Subject: Re: [GIT PULL] arch/microblaze patches for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602526864;
        bh=Gu/v8wkHLoKTyU4rQxoIyL1in2ZJKef4tJonLOvE9Hc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pgFV+/W5OUQUp8bgFhVJUbtoc4Kii3R5OiSsUe8WGtwDk6nXa/oe124KsJLAtU0kc
         VqbQPSBsZOGA4OsCyZlqpihdueTHC6JlcgbrTO8kY8iOqAmcnR4WADYC1XKJZdVLgh
         oDj5GewcH/K/DOmrUDgfqgxvAQFRgoK5Jtcqkywc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bc40d653-7a72-973a-2b9e-8f3f6ca51fea@monstr.eu>
References: <bc40d653-7a72-973a-2b9e-8f3f6ca51fea@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bc40d653-7a72-973a-2b9e-8f3f6ca51fea@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.10
X-PR-Tracked-Commit-Id: 4a17e8513376bb23f814d3e340a5692a12c69369
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 024fb66772911a361279c03cd1f394b7a8fd3919
Message-Id: <160252686406.3643.5852027680568966470.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 18:21:04 +0000
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 11:11:15 +0200:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/024fb66772911a361279c03cd1f394b7a8fd3919

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
