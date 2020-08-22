Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9186624E90F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 19:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgHVRcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 13:32:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbgHVRce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 13:32:34 -0400
Subject: Re: [GIT PULL] s390 updates for 5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598117552;
        bh=CzYNej7Bmko+kt1RfFOa/VGRN0A7q81Z62XQNDUiTjs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=m+/dnEugpRRhIQyloerdknHdnivaGWFT8X0x/aTbZvDMAG82Yrap5vG0T0KwfSzMm
         PMzXSgAiGiMb40E5VGypPJrtbyKilgWxXDRiW/oxyHRIkD3RmYbVFcBDBf49swgvtR
         A1LmV5AssEO4bZjAXCtHHuYffc2syeKSG7hZQLq4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01598099860-ext-4027@work.hours>
References: <your-ad-here.call-01598099860-ext-4027@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01598099860-ext-4027@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-3
X-PR-Tracked-Commit-Id: b97bf44f99155e57088e16974afb1f2d7b5287aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d57ce84004a0d13ada89fbceec21539559cb72f2
Message-Id: <159811755218.17427.17303690224388315333.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Aug 2020 17:32:32 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Aug 2020 14:37:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d57ce84004a0d13ada89fbceec21539559cb72f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
