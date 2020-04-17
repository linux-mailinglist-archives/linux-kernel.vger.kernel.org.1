Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D072D1AE3FD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 19:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgDQRph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 13:45:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729982AbgDQRpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:45:25 -0400
Subject: Re: [GIT PULL] xen: branch for v5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587145525;
        bh=olLvWaB4ydIcFWkrvOI7Encucm4ZHe6kcAaiQlphu3M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jMYEzC0zUHELGIqLnf+KzQbReRKX7YDFJxwq0qDXzDszdDKlMEnawj1St9XntdvW6
         I4xZ9laJtGDl94PYdAdnR+RdwBBVcQNbohiDWNtTy9KgppnkWCjSqQnxGErsE1atS1
         xAEmhghYYOZPmrc8sAihs60svt2cyNif6LZ3HLVs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200417151735.30600-1-jgross@suse.com>
References: <20200417151735.30600-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200417151735.30600-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.7-rc2-tag
X-PR-Tracked-Commit-Id: 74f4c438f22ca3fff157fb45e694805931487c55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0a4ebe7d1c5970f00cca09cbdfcb8ae1658349d
Message-Id: <158714552532.1625.5085942411616750345.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Apr 2020 17:45:25 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Apr 2020 17:17:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.7-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0a4ebe7d1c5970f00cca09cbdfcb8ae1658349d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
