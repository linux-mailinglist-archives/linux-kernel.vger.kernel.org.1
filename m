Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9273D28D22E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389826AbgJMQYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389755AbgJMQYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:24:06 -0400
Subject: Re: [GIT PULL] erofs update for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602606246;
        bh=E119DNK1X8tpoZOQlm5Bj2GU5Jd2BI/tK7K8HcqbuLc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cG2Df1wRSNDtkKyu2RdWRzsC021nD5L065ISaOfnUZtM3IMKWx3p3OQorQVbTabCE
         fORg/jnGVtV3xZl++HDjwR0hhH+IYZ//cYPb40yUrfGOwbUsuA16XucQsUOK6SSbrF
         CR2cpXVhukriRhz2XmnUYc2XaMT8rZ3cXAFBVw3M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201013122846.GA12025@xiangao.remote.csb>
References: <20201013122846.GA12025@xiangao.remote.csb>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <20201013122846.GA12025@xiangao.remote.csb>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.10-rc1
X-PR-Tracked-Commit-Id: 915f4c9358db6f96f08934dd683ae297aaa0fb91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dfef313e999058530396497fd41399c0a637c188
Message-Id: <160260624607.24492.5030532070752989179.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 16:24:06 +0000
To:     Gao Xiang <hsiangkao@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Oct 2020 20:28:46 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dfef313e999058530396497fd41399c0a637c188

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
