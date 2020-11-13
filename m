Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CFA2B25D7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgKMUuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:50:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgKMUuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:50:11 -0500
Subject: Re: [GIT PULL] Devicetree fixes for v5.10, take 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605300610;
        bh=fdF2yG1ds9qe9i+luGPXKKO/VqEIjnhldEkMekEFvEI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CTQv1AXWYYrsLBWLVojqq2SnSkttl9y7K7Jhl528jR4ucJ/L6NxjwJKqnJHR9J98X
         ThaMrnR33P+P6TiNy3O7OmkQQfYc6lxV3BAV9SWsjmraD6ttO8N/WwosCQXQEqaKTj
         CAhEvqyrYd3Rx7ZvBA3MaSGET4r1yuunFi8++v3o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201113204429.GA1955280@bogus>
References: <20201113204429.GA1955280@bogus>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201113204429.GA1955280@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.10-2
X-PR-Tracked-Commit-Id: bdac39a3bd28891fb0ded91c9152459c57773462
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e6a39eae450b81c8b2c8cbbfbdf8218e9b40c81
Message-Id: <160530061039.27782.5555020989606855620.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Nov 2020 20:50:10 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Nov 2020 14:44:29 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e6a39eae450b81c8b2c8cbbfbdf8218e9b40c81

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
