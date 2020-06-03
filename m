Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED70C1ED7C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 23:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgFCVFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 17:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgFCVFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 17:05:02 -0400
Subject: Re: [GIT PULL] parisc architecture updates for kernel v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591218302;
        bh=7WzSFXSTA6bOrlz815IS/UU6m5GnxdooouaCnGNoOEU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QF1BNlakyPRA82RtAnhZzYs3ah95tOcsRHYuT7wP4jAmAHLSQoCd992gZVLIZ9ANZ
         1RNDIBs+NJdUcnZeybSqSJoZPJwPcxjbmauMHtiCN0UWsyRsb1Psz4dQEAPRwzLDbo
         T0leiG6EweuxxOclZqk6jrJ5cSSxyZ1HbveKkxMk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <21135f7a-203c-3b7d-3dd3-88f8aaebdabf@gmx.de>
References: <21135f7a-203c-3b7d-3dd3-88f8aaebdabf@gmx.de>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <21135f7a-203c-3b7d-3dd3-88f8aaebdabf@gmx.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.8-1
X-PR-Tracked-Commit-Id: 775024cf49ff76c30757bac9a21f6e908b63f6b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44e40e96b5accb18a100fee1a67cde422d791c4c
Message-Id: <159121830214.19900.3477681291280302549.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 21:05:02 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        John David Anglin <dave.anglin@bell.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Jun 2020 22:19:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44e40e96b5accb18a100fee1a67cde422d791c4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
