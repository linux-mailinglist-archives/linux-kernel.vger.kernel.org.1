Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813AC2421E3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 23:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgHKVX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 17:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgHKVX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:23:26 -0400
Subject: Re: [git pull] IOMMU Updates for Linux v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597181006;
        bh=mr6YJD1V4dkwy/Iwhe/jxgg4pJipy7PDAUDoeF1s8c8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fwTW2X2J+0qYpKurzFhAD2TPfZWDUy0AJTjxF1gT59wBB3aSP7wnR4dmYBxriOQdw
         xTtVPq9bzmNy6TCqdEB0cEOEMjHTUhAAlVBAluzQcykGACKfrlipurZjAFi6beSd0T
         2cpbZJQG8UkwmVNa6kLgNc0Kvpl9avhn3/pJFkYM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200811124747.GA13876@8bytes.org>
References: <20200811124747.GA13876@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200811124747.GA13876@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.9
X-PR-Tracked-Commit-Id: e46b3c0d011eab9933c183d5b47569db8e377281
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 952ace797c17d06e50ad2a738babd27159b8d7cc
Message-Id: <159718100611.533.7037020432422807245.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Aug 2020 21:23:26 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Aug 2020 14:47:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/952ace797c17d06e50ad2a738babd27159b8d7cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
