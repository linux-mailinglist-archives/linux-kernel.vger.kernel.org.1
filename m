Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C124B270A51
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 05:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgISDFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 23:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgISDFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 23:05:11 -0400
Subject: Re: [GIT PULL] s390 updates for 5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600484711;
        bh=SUBkhfXZMpzX+rry+XroMylKtsM4FUX8y8UgQmTppto=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iLIhC+sasrHcBiAWSnVWQNjy1ibxPMvvKmDV2yMlWd1BJTC/49gay/naDSQC8nyJX
         mt7Mtp3Nq4DX5/a8Bq+k2RzZWBUUoEfudrAQ1dviuolbkiyZtUEa2UPeOKHEcBP/RP
         TLig95hDqo6zf6zVW30VQLrlqxW96lJ+y4Lid8Lk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01600471645-ext-5592@work.hours>
References: <your-ad-here.call-01600471645-ext-5592@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01600471645-ext-5592@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-6
X-PR-Tracked-Commit-Id: cd4d3d5f21ddbfae3f686ac0ff405f21f7847ad3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb5f95f1593f7c22dac681b19e815828e2af3efd
Message-Id: <160048471112.14036.8440624794112106039.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Sep 2020 03:05:11 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Sep 2020 01:27:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb5f95f1593f7c22dac681b19e815828e2af3efd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
