Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7DD2CE134
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbgLCVzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:55:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727274AbgLCVzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:55:09 -0500
Subject: Re: [GIT PULL] s390 updates for 5.10-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607032468;
        bh=6Qy+b3M9ViG0/Ldb1f4xnlS0TkI+fwD8geoO7WlUftw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=g+tYqx5NuVx38HE8V4AL5Bq33cI3320eNYzUTMPuMUiwAIs+FCk88m0pmfPx6lYiZ
         yGaXoDNyhkNpekcat2znJIP874wdO9apIszhLHAw8n28w9l6QkLcQMmiL4WQiFuYfv
         obWjRNDbKoToIyEo6TrHdbhVvAmQMWeAQq3fQ6wdR4LVqRqHSzov6Jaj/Tcovdt0Wj
         fqeVDi7sAxDOREc3IZzQcotdU2xITEiGkkorikI5n5jC1bDFB61FaSBK3FAegPoDyD
         2nFasinGigG6z53IjnOxyx694WZsC9z4Fe9PYXe+SeV8XVdfaBpwUNBaPD0m9CH1rp
         +nu0Mr6Rqb0lQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201203193052.GD9994@osiris>
References: <20201203193052.GD9994@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201203193052.GD9994@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-6
X-PR-Tracked-Commit-Id: b1cae1f84a0f609a34ebcaa087fbecef32f69882
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fee5be18524f961de653fe6103f927c84ebbfd38
Message-Id: <160703246826.16480.9164224896469159516.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Dec 2020 21:54:28 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Dec 2020 20:30:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fee5be18524f961de653fe6103f927c84ebbfd38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
