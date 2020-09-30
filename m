Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B4827DD8E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 02:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgI3A6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 20:58:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgI3A6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 20:58:05 -0400
Subject: Re: [GIT PULL] Devicetree fixes for v5.9, take 3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601427485;
        bh=k+X5C3ZynxpyeI7GLoW4JFgy9Gh0TTKBL5Z9PCD/W04=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=K0LKwCQhfLRtVMl7DszINpjLic+14L+VP2KDp8Uma1G1qY8eZcDzE83aRW36lfGle
         6MAFzURYfEPMqr7FGPeukfsvk7Po2kVcq9hxWDBO9Ma3MIE67xq1USrESj/VOhPqGf
         Oc4QyEHzsTWls5Dml485wrV+3izdTyY86iSL14/I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200929205431.GA1165869@bogus>
References: <20200929205431.GA1165869@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200929205431.GA1165869@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.9-3
X-PR-Tracked-Commit-Id: efe84d408bf41975db8506d3a1cc02e794e2309c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02de58b24d2e1b2cf947d57205bd2221d897193c
Message-Id: <160142748499.17708.931388762091163438.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Sep 2020 00:58:04 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Sep 2020 15:54:31 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.9-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02de58b24d2e1b2cf947d57205bd2221d897193c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
