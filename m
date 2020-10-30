Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C039C2A10B2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 23:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgJ3WKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 18:10:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgJ3WKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 18:10:49 -0400
Subject: Re: [GIT PULL] libata fix for 5.10-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604095848;
        bh=Zd7EmpmoIoYY9PRJwpyfNIC9iL3YFo+aZsGnytipm7I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sZu+/ldH4iqRiHMgqbMKp61c+klw46Fs/GkhpgFK97uJJMmwGOdKdreFAzuMhbTpy
         4Lwt3+TJO4CWcXddYktxF4fpfj/BkJFptTCLMFPO6OMjmboaAULiGv1Qns5ZE0crD9
         /G1t+M54+IwejwBwOx3ydM9oAYhru3teX1dYKO8E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b88f599e-3e61-b904-4025-8c59cd985b69@kernel.dk>
References: <b88f599e-3e61-b904-4025-8c59cd985b69@kernel.dk>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <b88f599e-3e61-b904-4025-8c59cd985b69@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/libata-5.10-2020-10-30
X-PR-Tracked-Commit-Id: 8e4c309f9f33b76c09daa02b796ef87918eee494
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f9a2a196bc3f838996364f5b8f73b8a4ee5a552
Message-Id: <160409584869.7779.14512351052717475267.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Oct 2020 22:10:48 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Oct 2020 11:09:01 -0600:

> git://git.kernel.dk/linux-block.git tags/libata-5.10-2020-10-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f9a2a196bc3f838996364f5b8f73b8a4ee5a552

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
