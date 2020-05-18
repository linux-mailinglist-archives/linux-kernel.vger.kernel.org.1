Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB7F1D8609
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 20:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbgERSWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 14:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730620AbgERRuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:50:03 -0400
Subject: Re: [GIT PULL] exfat fixes for 5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824203;
        bh=YEV2LJIFKWVadGYwv4YEJFb0BiSC1MSx9ZkxNpumhRw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wcAOyhXfK5z1G8Q4o32ke99rUpgZln8M6sc4oCX8Tu/hqb48tZ6NFBk8OAGViowff
         UoDXSSItnlKGYLKSupzs8eEWl8Aji+jlpcPrRTLQ7U0+T7HfEaz/Kh0rwtybPzbWFp
         eQ+CubgxrXUHiJyJWOIle16Fm1ixaSMvoec9kYLQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <000801d62cd0$ed42b540$c7c81fc0$@samsung.com>
References: <CGME20200518045810epcas1p1aa279ded0971de7d07e600a85f242459@epcas1p1.samsung.com>
 <000801d62cd0$ed42b540$c7c81fc0$@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <000801d62cd0$ed42b540$c7c81fc0$@samsung.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
 tags/for-5.7-rc7
X-PR-Tracked-Commit-Id: 94182167ec730dadcaea5fbc6bb8f1136966ef66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45088963ca9cdc3df50dd7b1b63e1dc9dcc6375e
Message-Id: <158982420302.13100.10457280292689963500.pr-tracker-bot@kernel.org>
Date:   Mon, 18 May 2020 17:50:03 +0000
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        'LKML' <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 18 May 2020 13:58:09 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/for-5.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45088963ca9cdc3df50dd7b1b63e1dc9dcc6375e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
