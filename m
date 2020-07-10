Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC9E21BBAB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 18:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgGJQzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 12:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728449AbgGJQzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:55:07 -0400
Subject: Re: [GIT PULL] dma-mapping fixes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594400107;
        bh=mAA3/ZBpex/kNKkUh0yoZh5GkI0zJQevobe/c/a6Fa8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wS3tWl/JsQrt6FEbjdidM/c9it1ewDCY00nkXtZ9UlcaeJVkDN4iv3ODGxOCFPFbG
         bgmZpklFNhpvFfhoh6P8blC8dUV1Y3HdWUU3kEzYp7rtUcBki3dUMdII/O3USUWIFp
         Yvlf07hoH/x0nqcLJ5KLhlNicOnPjP7X95WDflnk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200710154506.GA540305@infradead.org>
References: <20200710154506.GA540305@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200710154506.GA540305@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.8-5
X-PR-Tracked-Commit-Id: 68d237056e007c88031d80900cdba0945121a287
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bfde037425d91d1d615d30ec362f5f5c1ca0dd2
Message-Id: <159440010718.18761.15336646128679822312.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jul 2020 16:55:07 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jul 2020 17:45:06 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bfde037425d91d1d615d30ec362f5f5c1ca0dd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
