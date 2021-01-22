Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6D5300F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbhAVWCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:02:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbhAVWBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:01:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 58EEC23B08;
        Fri, 22 Jan 2021 22:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611352839;
        bh=56HnNKcrxaTHWZXlBFLfmhzbzB737NtG+EO1ntQr9E8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=m+Se4sd8GyxSr2cn4IOGxQ1SAuVCplJUvlUFCR90VVMGGt/vHGz0hWOCXtvB069Pz
         wkJ+JCLszKRKzo3ikMunBI7gxTNwz/uc3v39JFQGzjEsKwkvv0WLc0XIwKN1hkJwtr
         hBzXfjOq2RGzttOqnw5D4Tr0SKqjDN7Sy3vY8kxkxu0szFtCHoJUjn4UFBvYkoUxLQ
         JaiZuiczuaVi/w+VjEr1ZEwWgRtnvMPmFUFTv7f1tyurml/Cxd2WVscytB+qrFENfj
         mw5XVlwG6cH0A0g3HnwVP/p4eUA/vE7GJtUOY0VEYnAg/rj1mk7haFHhnLBcuekc8E
         07Rm6jC077Wmw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 54D3C652D1;
        Fri, 22 Jan 2021 22:00:39 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.11-2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ac7b0183-fda1-754f-f65c-e390ef147c89@redhat.com>
References: <ac7b0183-fda1-754f-f65c-e390ef147c89@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ac7b0183-fda1-754f-f65c-e390ef147c89@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.11-2
X-PR-Tracked-Commit-Id: 173aac2fef96972e42d33c0e1189e6f756a0d719
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9887e9af2d58e4021f1015bf804f5f226b3b2b1c
Message-Id: <161135283933.4174.8291269431667336021.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Jan 2021 22:00:39 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Jan 2021 10:02:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9887e9af2d58e4021f1015bf804f5f226b3b2b1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
