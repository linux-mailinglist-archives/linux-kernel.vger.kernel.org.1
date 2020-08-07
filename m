Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CFD23F261
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 20:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHGSBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 14:01:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgHGSBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 14:01:12 -0400
Subject: Re: [GIT PULL] xen: branch for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596823272;
        bh=0ehE2VzF4nqUoT893BcZnKAU1i5Tq0u904T1d7kqRSU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=P6BaZgiTal2HNlPXJYTR/I4aNG23E6QrY1C3ZtZGtEpbXnGTFbDeMkxruyaWUx1sR
         O3eMd0E099Q9ila7AS8vihT8eyJronZoUpSYxz6vKEBKIwqF4B0w514j5BHV3nLTDF
         tf9t4fFY8IoGQpThjruhJxRdprODIUCv4sRbQfmg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200807050450.7517-1-jgross@suse.com>
References: <20200807050450.7517-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20200807050450.7517-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9-rc1-tag
X-PR-Tracked-Commit-Id: d7b461caa6cc64dd190577b46b0ec892a8d5e7c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e51418191f5a741b5f94764798c81bf69dec4806
Message-Id: <159682327228.30890.17036828138503121566.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 18:01:12 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  7 Aug 2020 07:04:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e51418191f5a741b5f94764798c81bf69dec4806

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
