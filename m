Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBC8300F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbhAVWGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:06:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730882AbhAVWCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:02:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0CE8323B21;
        Fri, 22 Jan 2021 22:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611352840;
        bh=VGIntJZ0BX9Bo3nf7ziCLDnPBiwO+l0e9ytLB6Ug3C0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hOF2yHEPuHWuT6auVEhZNNfn6vFYw32LNBZ2N6LZJK29Q60GVYPJjIH+1nJFbbQcM
         pDEneMhb6jKKqa7EAP/wpmKu3q0o4pOTi4da3JrM/X8HC1cV5JHNHbOkhORnG9a6mx
         yEHo2i0yDcVxzRTy/GZkqLUegfg077pMnNmCCcZv46FNTBDpkk6JoTu70qM37nK1p7
         FA5pBDtMq0MHeFwbd32EVwaSGZZQpBK/S255YEySCqB9RfDdVjGnJjqxAjqatDdRsy
         867PYJ7ueWRG8mnZtG6Zv+Rz3nXtUEt7w7ZhMipOlwx2H3YpNfSvqBtMZhKrsgbHDk
         PfpwYoC9aMsyQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 08958652D0;
        Fri, 22 Jan 2021 22:00:40 +0000 (UTC)
Subject: Re: [GIT PULL] mm/memblock: typo fix in a comment
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210122165359.GC6332@kernel.org>
References: <20210122165359.GC6332@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210122165359.GC6332@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2021-01-22
X-PR-Tracked-Commit-Id: 17cbe03872be8878e2f84047424350d036915df1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df7da31d055f13b00f062422cbee0ea994730813
Message-Id: <161135284002.4174.11617631122721988854.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Jan 2021 22:00:40 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Levi Yun <ppbuk5246@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Jan 2021 18:53:59 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2021-01-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df7da31d055f13b00f062422cbee0ea994730813

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
