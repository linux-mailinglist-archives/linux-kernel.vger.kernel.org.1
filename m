Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C0F24C719
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 23:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgHTVTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 17:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgHTVTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:19:45 -0400
Subject: Re: [GIT PULL] dma-mapping fixes for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597958384;
        bh=2hq6onQCdlA403xN+jtRAG5QjR2ibewvyvH6gGLQeH4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y82HTfhV8vskYpYEAgQFRWNVn5iAR4aqiJ21sUp3dzCVX2IydREZrrVG8KfcFxw9a
         X1l8w0kcTHCEH5Ku6muPA3TryhIWhty0wZ4x8O4WB/x7i23jYQTL8KwsyZ0khuJcwD
         NTDRBs6xeL8OJggOTgTTDJNnhL+Sq7CVDUXUrYwI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200820164158.GA2186695@infradead.org>
References: <20200820164158.GA2186695@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20200820164158.GA2186695@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.9-1
X-PR-Tracked-Commit-Id: d7e673ec2c8e0ea39c4c70fc490d67d7fbda869d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d271b51c60ebe71e0435a9059b315a3d8bb8a099
Message-Id: <159795838442.11229.2400574888982180858.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Aug 2020 21:19:44 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Aug 2020 18:41:58 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d271b51c60ebe71e0435a9059b315a3d8bb8a099

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
