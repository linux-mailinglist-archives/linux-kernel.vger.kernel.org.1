Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D054D2DB813
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 02:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgLPBAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 20:00:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:50574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgLPBAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 20:00:44 -0500
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.11-1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608080404;
        bh=VWlTv+/6OB8uiQKTC/6bIuEldgrTyuAqor76tybRw4Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UM+fuDbCt/UFa3X0+lzzT+fbnug3RHHJAQc8Ac0yz+MyXeGHMqDCte3hCSL4KNj8P
         3zd6dytIFOGkNfpG7qBh8xOlsz/vOzin7pdS1FkAhmImDyq6ev8u6s4XB3dFVyt039
         6t4prTR9bnlAOPLdBKX6GWlL2EHY2VlPo2H8dr3MbdrLXaI2KRyGwLcY43AokolNO4
         13RE6dPr2DHnU1jtGSldRb9kowHrmm1EAOniq3LyFOQ8mjfruTZviUhlQZAsM2IgZ/
         k3eT+Ob8zfaFB9wMFvJc0ikn1e8k1ZSP2V3l/7+A5LrWdS9iUow016cWlYVb4mnV+c
         36B7GjQMuEvEQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f70a7a27-de9d-35aa-53d4-91da3677af6d@redhat.com>
References: <f70a7a27-de9d-35aa-53d4-91da3677af6d@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f70a7a27-de9d-35aa-53d4-91da3677af6d@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.11-1
X-PR-Tracked-Commit-Id: 0cd3f561efa9adce840140720e0581355db3e554
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61f914256c56a39a96dc14eae9f394d35b934812
Message-Id: <160808040412.29502.7032176367635458091.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 01:00:04 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 13:43:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61f914256c56a39a96dc14eae9f394d35b934812

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
