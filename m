Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6DA1EC3BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 22:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgFBUfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 16:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728500AbgFBUfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:35:08 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.8-1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591130108;
        bh=AtpKJAfOF062U5r0mQx7TXKIBRFWqfZa5a1IOiZ+Sl4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fjjG3RvrLzOPCa1tnSPmfoQ45xDvFUxVXV+5CaLIoukgekDrkoBdSNu2ZWeYN2FxJ
         BhTJTZtuFvWoIgHx2ifZMrKqVD5t0L54YPMlQavFwOxkyosh1Tna3QCRK8/fJjuXG3
         TqTk2ufcaEjiijaf5YBwZZZFmYutqDpJ1goSml/M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200602081615.GA2475822@smile.fi.intel.com>
References: <20200602081615.GA2475822@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200602081615.GA2475822@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.8-1
X-PR-Tracked-Commit-Id: 47a94c551a7401a196cba881470dc9cb92573e82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5a82e0a5918fb2ae27b80d3b9c954b16ae6a7b7
Message-Id: <159113010849.19446.14247480760469450711.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Jun 2020 20:35:08 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Jun 2020 11:16:15 +0300:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5a82e0a5918fb2ae27b80d3b9c954b16ae6a7b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
