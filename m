Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEBC2A9EEF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgKFVNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:13:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbgKFVNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:13:25 -0500
Subject: Re: [GIT PULL] s390 updates for 5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604697204;
        bh=yjZCcXU+gF3xZI2QXztx75k1wQMlSlbBuCY9IovNVeg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lfNJCBASrXWmtKGY7a3OZilCviYgW3MFjJaGCgZRhOuSdJB9Yk3Phj44khWdBnNOK
         MnwNMzv28UdFaSuO4nS/1GKr12RtLiyqkSTd50VmgZojLhv+qY0gM734UPE64Etnge
         Q1uLzJ41jR7LsFMLS0pgHyytx/HGuEDZkuAI4RJE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201105201202.GA7024@osiris>
References: <20201105201202.GA7024@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201105201202.GA7024@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-3
X-PR-Tracked-Commit-Id: 0b2ca2c7d0c9e2731d01b6c862375d44a7e13923
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee51814888278677cb4384814bbe3c95f6270b50
Message-Id: <160469720448.14190.17044617785049314310.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Nov 2020 21:13:24 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 5 Nov 2020 21:12:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee51814888278677cb4384814bbe3c95f6270b50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
