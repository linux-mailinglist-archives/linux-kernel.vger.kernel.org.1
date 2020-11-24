Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E832C31D2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 21:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgKXURh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 15:17:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730599AbgKXURh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 15:17:37 -0500
Subject: Re: [GIT PULL] s390 updates for 5.10-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606249056;
        bh=UdVlJs9VST1015HgIMkB45SMHgs/C4WdTXYV06Fn3HM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dDGMNlLFR4f5gv1n6ZzH+NCRMf/Lnqav4AyycmwnaloGC5IkApKXolQrJf4p4fQde
         sPIrgp8rqAoIkB01jqtYrUygpoT1kfkCOvcpeKArXqxvmnCbWlMk7lPNY0w7NnMN03
         bPo904bencv4/BHvcdJTyP0XuKRF975LuATbDjNA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201124180455.GA4250@osiris>
References: <20201124180455.GA4250@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201124180455.GA4250@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-5
X-PR-Tracked-Commit-Id: 1179f170b6f0af7bb0b3b7628136eaac450ddf31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80145ac2f739558e66bd8789df3414bc0e111c58
Message-Id: <160624905663.27196.17489373137474822248.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Nov 2020 20:17:36 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 Nov 2020 19:04:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80145ac2f739558e66bd8789df3414bc0e111c58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
