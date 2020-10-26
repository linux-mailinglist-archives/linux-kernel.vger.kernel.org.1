Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE5729945B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788566AbgJZRwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1788547AbgJZRwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:52:32 -0400
Subject: Re: [GIT PULL] s390 compile fix for 5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603734752;
        bh=/71UilDrvmpgNjMzM2RBa3jBiyVqJBHvzIQMn8BVl7g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Prcqx4hR3kWH/0dyDmw9hWEtxAHclyWwwMrWCTBfYY3v9sd/hrFaO80rPmObBhrz9
         jJUtg2rFvv0ueL16GZNEgp7ED+DlVzM4zNIwohn7HYjrz4gJ8ogY2ouXB9Uby2ZKLR
         ihJnr2OypU8jOibzvJEQ564Af8mb+kC7B/FoyzS0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201026142956.GA9584@osiris>
References: <20201026142956.GA9584@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201026142956.GA9584@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-2
X-PR-Tracked-Commit-Id: 8e90b4b1305a80b1d7712370a163eff269ac1ba2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e2b2da60658ee6cf7a421596a3c9eb619c810f9
Message-Id: <160373475213.18562.4220019802574082477.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Oct 2020 17:52:32 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Joe Perches <joe@perches.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Oct 2020 15:29:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e2b2da60658ee6cf7a421596a3c9eb619c810f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
