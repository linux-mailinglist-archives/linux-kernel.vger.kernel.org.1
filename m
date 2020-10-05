Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AB228407A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 22:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgJEUPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 16:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729575AbgJEUPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:15:31 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.9-2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601928931;
        bh=pS9b1L7RWWIacyKd8Q+gd0osJfyUoQC/wpZ9rYTkXAY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0bpCfky020zRsqwArl8LmRPCLcSfdEDfezanPmx5a2dWZ38EZjcg+HLa7l+HceCw2
         mc1Bz505gInTntl5lI/9M5XtME49a3j0G7dYvok238BTEwq3vqtoyuHSp/JqbuGpiJ
         1Gi9g1N7zox9ldbTqheItkKisz0SDBxqi+2CHij4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201005135521.GA1116903@smile.fi.intel.com>
References: <20201005135521.GA1116903@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201005135521.GA1116903@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.9-2
X-PR-Tracked-Commit-Id: 720ef73d1a239e33c3ad8fac356b9b1348e68aaf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7575fdda569b2a2e8be32c1a64ecb05d6f96a500
Message-Id: <160192893129.5040.9376517897868696406.pr-tracker-bot@kernel.org>
Date:   Mon, 05 Oct 2020 20:15:31 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 5 Oct 2020 16:55:21 +0300:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7575fdda569b2a2e8be32c1a64ecb05d6f96a500

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
