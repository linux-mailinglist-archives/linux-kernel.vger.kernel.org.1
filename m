Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF7C2DE99F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 20:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbgLRTL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 14:11:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbgLRTL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 14:11:27 -0500
Subject: Re: [GIT PULL] more s390 updates for 5.11 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608318647;
        bh=lcnpOXEv71koEbCDjN6b3afzbIXtrzPS1UHavDGKYOE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=D7NuqtoD9+TLMpsm0smox6X9rfVW5lzrDQK5tCv8FvcrbIuVB/3pb3/C8i9VhNv3A
         cyr+BCM9Lcyx+RIXxCkSTiZfDmNuCyQxJUaVQCNKP2uar4h3zUA/qZgOOqzQ9qZZIw
         G+RlwXO9lJlXxRP1lfYGcbaZ5Kzk66YNtaAY8Nxx+eC+tEAKa+1I/EFB56Wzw27gPe
         Mjs9eZbGM+/QccTTMh/LR3egMDoFaLV6cLjfZzRCHBGxai967n7AQ5e4JKupHZuN6m
         PrzET1ftzEkerTe9av9F7FA+0/lxuie+25MHwjPDHl4Tt3x7QLPHcDwWCAdi86pRNd
         /Fv6Ogv7EAjkQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201218185312.GA5261@osiris>
References: <20201218185312.GA5261@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201218185312.GA5261@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.11-2
X-PR-Tracked-Commit-Id: dfdc6e73cdcf011a04568231132916c6d06b861f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a087241716a6cea8518ca33839276a9648d91cef
Message-Id: <160831864695.5982.15231788755591792279.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Dec 2020 19:10:46 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Dec 2020 19:53:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a087241716a6cea8518ca33839276a9648d91cef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
