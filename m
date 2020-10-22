Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8092965B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 22:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370698AbgJVUIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 16:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370521AbgJVUEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 16:04:15 -0400
Subject: Re: [GIT PULL] rpmsg updates for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603397055;
        bh=Jb5CKVlnSXC7zwtAUTqRET45wf1SbTnFMjdbHfSCLjE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TIPIeNQbLikDML5rYX1Xa2Aq/wYO8U5n3DqGAxjeaJm8ChS4Uu1wmSKB15DAI66Wg
         ws226AzCGzjAHdkzD9YZCmLQWmB5Z8FSH4BQyY4/gJ/ES8RrBKUvCxi0lWrNFkUZWc
         Py3kVo0yiiyedQQtaeSnuV8LUTuKSe9hxdSAXW7c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201022165424.23320-1-bjorn.andersson@linaro.org>
References: <20201022165424.23320-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-remoteproc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201022165424.23320-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rpmsg-v5.10
X-PR-Tracked-Commit-Id: 4e3dda0bc603c1ca84680a56bfc49e8fe2519c89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60573c2966a1b560fabdffe308d47b6ba5585b15
Message-Id: <160339705511.15216.15073258563162559041.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Oct 2020 20:04:15 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Lew <clew@codeaurora.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Deepak Kumar Singh <deesin@codeaurora.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Oct 2020 11:54:24 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rpmsg-v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60573c2966a1b560fabdffe308d47b6ba5585b15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
