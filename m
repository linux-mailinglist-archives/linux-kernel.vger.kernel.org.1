Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB0621BBA8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 18:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgGJQzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 12:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbgGJQzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:55:05 -0400
Subject: Re: [GIT PULL] more s390 updates for 5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594400105;
        bh=das7VozmdKMpxCnnu9V9d1M8qijYd1MvL60anUbk9KQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hPpIt0LBwoqPsDFTdu1fF2BnAZKbM2QMH+sOvY5pNw1vJhh7fJksxUIvZeR5twUP3
         U5F4cvkYrBc0KJby8o+BrmV+R3T974BW0u7dCUxHSBLVDjLsGa4aaymtxMa6sVYSkW
         wJNKI7Zdv0IpXQrVOwoXYwy6qYB6wb2LiLG13YT4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200710134740.GA14845@osiris>
References: <20200710134740.GA14845@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200710134740.GA14845@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-5
X-PR-Tracked-Commit-Id: dd9ce2d6eeaebbdd342cbe095b7a195d569f18d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8749d068855c2b075b3de1985e6af836a02b257
Message-Id: <159440010524.18761.7709098818759791442.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jul 2020 16:55:05 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jul 2020 15:47:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8749d068855c2b075b3de1985e6af836a02b257

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
