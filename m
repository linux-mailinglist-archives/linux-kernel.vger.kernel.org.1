Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFC72133EA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 08:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgGCGKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 02:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgGCGKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:10:08 -0400
Subject: Re: [GIT PULL] Devicetree fixes for 5.8, v2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593756608;
        bh=IgOm6mouFSgR99piDXnQhDddzJYnW4R+V63BCxmxNqU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pMXIgRC8bQtzDY5eVctjWyuLfE98upX/5tsXEheVAKzqgvhs9XKi9TlgpmaY1rC9K
         f8T7plPv0ngR+6uxfwV3kbPs9w/tzfCIee3q98lA3X/d4Z2hqEwjYko+2frhu01lhC
         f2i0WFlSV6S0NZEaOOrK8CWV6lVE87CUypJbfnvE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200702213924.GA1763915@bogus>
References: <20200702213924.GA1763915@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200702213924.GA1763915@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.8-2
X-PR-Tracked-Commit-Id: 0115e6c98c22f3fc7ff7da2a41480483abe95b37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 684c8ccc40d7e5408d597a43712bad3827d3fb94
Message-Id: <159375660808.4799.7782720631875361090.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jul 2020 06:10:08 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Jul 2020 15:39:24 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/684c8ccc40d7e5408d597a43712bad3827d3fb94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
