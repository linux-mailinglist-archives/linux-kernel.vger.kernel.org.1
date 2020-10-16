Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591A1290C75
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 21:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411176AbgJPTyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 15:54:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411166AbgJPTyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 15:54:38 -0400
Subject: Re: [GIT PULL] s390 patches for the 5.10 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602878078;
        bh=/YVTyo8jlCAN+4kLgp4L4xneQuVjYKZTv72s3sYy36c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Y2D6ITgU39+gTXWG5XmI34u+VhoSgJHkOg7/QDPGHS20VsPoa2HggRnneGjYiCbqW
         epnR4qPe6KtPHezOMPKmaJVzV/KTWCn5UD044QDFYmWYJo+OC0cU74Iis/9N6ERki0
         cNgOvVc/NcONcVi3Hn885XwWaGpJ4hvcF1SUcE3Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01602846038-ext-6012@work.hours>
References: <your-ad-here.call-01602846038-ext-6012@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01602846038-ext-6012@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-1
X-PR-Tracked-Commit-Id: 10e5afb3d260f2d2521889d87ebdefb7fc3d4087
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 847d4287a0c6709fd1ce24002b96d404a6da8b5b
Message-Id: <160287807835.14002.3988687632583060058.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Oct 2020 19:54:38 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Oct 2020 13:00:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/847d4287a0c6709fd1ce24002b96d404a6da8b5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
