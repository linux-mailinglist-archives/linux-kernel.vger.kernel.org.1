Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4E71ED7C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 23:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgFCVFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 17:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgFCVFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 17:05:08 -0400
Subject: Re: [GIT PULL] thread changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591218307;
        bh=UUyqpTGOmLfPVAo0T4LrhWDI8bh8yh3rrEE6CCyYcPY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=d/CC1cGdYW+PJOynxSx/bBLZogndhyeNad4qqa1iX4mTkr98EIln0X9O/bW610mGy
         oN2KvO0w9oHeBUk8vJab56DPTz3/UuU8HHVhiM28C4WFayo+54Y2t4mkGDCaGWTCF7
         KBpuHIFaEOnYweCMz+uTIJs6Wr7HdptZcU6c7mjI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200602121919.33831-1-christian.brauner@ubuntu.com>
References: <20200602121919.33831-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200602121919.33831-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/threads-v5.8
X-PR-Tracked-Commit-Id: 2b40c5db73e239531ea54991087f4edc07fbb08e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7c93cbfe9cb4b0a47633099e78c455b1f79bbac
Message-Id: <159121830781.19900.5667083201576760227.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 21:05:07 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  2 Jun 2020 14:19:21 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/threads-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7c93cbfe9cb4b0a47633099e78c455b1f79bbac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
