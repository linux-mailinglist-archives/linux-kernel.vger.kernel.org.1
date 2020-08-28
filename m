Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5358A2561B8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 21:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgH1T6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 15:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgH1T60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:58:26 -0400
Subject: Re: [GIT PULL] MFD fixes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598644706;
        bh=wFNo3ACxFGBabxEtMsfguCb1FbxBjNkpi/2nTOarmYk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZRoLSnK2IDJl18yGthN0pyvrjcPVsXXsv9dfdXve91Io/4bucGhsvEIfYn7nZDvMw
         9PFauFW1rX2jKAa863TMr++EtoTPqdj2Tc1Y7JFcqV3GuVRm1jzQfBQh2RZ5YkIllK
         hOvAjVqdYopxx2XFtQX5xjz2bZ0pcY3x9DUi2eBQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200828085815.GA1826686@dell>
References: <20200828085815.GA1826686@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200828085815.GA1826686@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-fixes-5.9
X-PR-Tracked-Commit-Id: 22380b65dc70f5b132c5afdf6b4011e2a84ec34a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a7c327767221660e9e9a62e5538173873193f0a
Message-Id: <159864470606.31636.2929275535172328354.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Aug 2020 19:58:26 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Aug 2020 09:58:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-fixes-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a7c327767221660e9e9a62e5538173873193f0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
