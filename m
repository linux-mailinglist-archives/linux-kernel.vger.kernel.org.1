Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546D61EC7FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 05:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgFCDug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 23:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFCDuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:50:11 -0400
Subject: Re: [GIT PULL] erofs updates for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591156211;
        bh=E33tR9al6qvqyYF6H/XZmuh1Mvt6yfXhaaF9RZ+tvTQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bUMOnzZ1SfuyTvtopxATYXlE7D1L9hx6q/jC8ZykO7qala5HUIbodrYxFME8g0Ukc
         W2O7jAZXFYyeVn2SO2F/qkOTV5l4JnBYboxthC/94URVy108+fC0sXfEnpzErZW9FZ
         yJLm3dAtgaIuC6YkdBPGFn8BR8sL1vLjHNg8Icl8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200603012137.GA12304@xiangao.remote.csb>
References: <20200603012137.GA12304@xiangao.remote.csb>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200603012137.GA12304@xiangao.remote.csb>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.8-rc1
X-PR-Tracked-Commit-Id: 34f853b849eb6a509eb8f40f2f5946ebb1f62739
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6f9469a03d832dcd17041ed67774ffb5f3e73b3
Message-Id: <159115621140.30123.15533234528367920561.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 03:50:11 +0000
To:     Gao Xiang <hsiangkao@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Jun 2020 09:21:37 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6f9469a03d832dcd17041ed67774ffb5f3e73b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
