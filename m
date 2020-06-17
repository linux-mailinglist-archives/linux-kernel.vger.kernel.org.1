Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C881FC2EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 02:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgFQApZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 20:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgFQApY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 20:45:24 -0400
Subject: Re: [GIT PULL] MFD fixes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592354723;
        bh=xrW8XCYpgjdjK1CnaBJs07hA4u1EAqNRZXUlpFUONDU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DlKx04eEtz3TiEFb5WKELXcyzeW3YWdUQJlPeeRIOyDBfkfnYdAMKQ+6dRGJMyPyj
         PLHqg1Ml39vzy60WBWfM+VW0uYfgTMtVcx9/Wew/Pq4R9Lezk8bexMi2KNd4mMBjDq
         dNRWs33leFSv80IgJ8+wFeK61i+oCmSknr0pjdpo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200616083946.GN2608702@dell>
References: <20200616083946.GN2608702@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200616083946.GN2608702@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-fixes-5.8
X-PR-Tracked-Commit-Id: bf6b694a6a908a6fd8f23eada669d1e90b2772af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 651220e2aee3ccfd986a0436b8d6f5b3b5574d1f
Message-Id: <159235472368.15875.6611145891047111158.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Jun 2020 00:45:23 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Jun 2020 09:39:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-fixes-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/651220e2aee3ccfd986a0436b8d6f5b3b5574d1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
