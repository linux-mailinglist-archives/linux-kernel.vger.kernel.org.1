Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38791E8995
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 23:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgE2VKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 17:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbgE2VKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:10:06 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590786606;
        bh=C7jau0IuCea6Jhmahys1JOe9wMqgN9X0IW0uelXub2s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BajMhUzt+DWyBJTRzbJNuS+6Cc6mQ0POB5RIIz4hxa6CdVbas8N/jnfMBg7SxIzPR
         a/zPSwHdocuG8SoHiNGjKv3s46bpeUriTedArPOKM3MRGS6rAEDRWozJqMcQXEAPdi
         IgK3d0In3U59v4tRA2ilTGshf/k5B9ikJZ7VfIzE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200529185836.GA31964@8bytes.org>
References: <20200529185836.GA31964@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200529185836.GA31964@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.7-rc7
X-PR-Tracked-Commit-Id: 7cc31613734c4870ae32f5265d576ef296621343
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b58f2140ea8605ee6ea0530d9c0cb5d049f9c7ca
Message-Id: <159078660639.32003.3784639971506990928.pr-tracker-bot@kernel.org>
Date:   Fri, 29 May 2020 21:10:06 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 May 2020 20:58:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b58f2140ea8605ee6ea0530d9c0cb5d049f9c7ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
