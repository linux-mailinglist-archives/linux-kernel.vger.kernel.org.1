Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F08501A2E2A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 06:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgDIEF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 00:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbgDIEF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 00:05:27 -0400
Subject: Re: [git pull] IOMMU Updates for Linux v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586405127;
        bh=/iCiFLfNiF3lDS9yAdPdQdDcxKFBzlt/5vNI9IAYhjU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OaL50o8N/S53pWagcp6RAbqUFlYFfG+1qWIbyI5wkvAEyQyME5S8c1f214kKSmMC4
         nQbOG5HYbkW54Zn4+vndYAkj0ovdM+FXj1fSvLjSqSHSQAVdq2C8RYYGrhdbDdinrY
         /s4EF0cQfdYApC/krqOC26Hmjf9yu/s0+qH3Zdgs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200407152635.GA10588@8bytes.org>
References: <20200407152635.GA10588@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200407152635.GA10588@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v5.7
X-PR-Tracked-Commit-Id: ff68eb23308e6538ec7864c83d39540f423bbe90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0906d8b975ff713cfb55328e4f3bf6de5967415e
Message-Id: <158640512732.12302.9078407130199098833.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Apr 2020 04:05:27 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Apr 2020 17:26:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0906d8b975ff713cfb55328e4f3bf6de5967415e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
