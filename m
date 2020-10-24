Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAFC297E42
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764236AbgJXTzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 15:55:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764226AbgJXTzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 15:55:15 -0400
Subject: Re: [GIT PULL] libata fixes for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603569315;
        bh=8KcIQsNs0DKTdfnmQpKc4tqHQrmPrLm0EYLr2qPKJls=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oQWN936O9EKJebCLoAibO9ovHibIPDLEPQ7yTbXcWGtCZgt7eb/PsrWeSjy/LEPtA
         tfQmiPjYrVJykrQb++LzH8gY9nJmjJdsPyD6czXhb3UiMshvQGf4iA+o4ZA5ueUvWL
         dKhfyAM6Saxcn2vbrIcc0c8b+mp7a3lcstpcIlgo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <78f005fb-c35a-9120-5299-c8bd1efb1216@kernel.dk>
References: <78f005fb-c35a-9120-5299-c8bd1efb1216@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <78f005fb-c35a-9120-5299-c8bd1efb1216@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/libata-5.10-2020-10-24
X-PR-Tracked-Commit-Id: 94bd5719e491564c61ee9f121d544e23b4e51374
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb6b2897b9b425433ae31dc01f4e1d549f0028c8
Message-Id: <160356931524.14356.4528595097698117279.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Oct 2020 19:55:15 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 24 Oct 2020 09:13:29 -0600:

> git://git.kernel.dk/linux-block.git tags/libata-5.10-2020-10-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb6b2897b9b425433ae31dc01f4e1d549f0028c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
