Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD512BB415
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbgKTSkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:40:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731038AbgKTSkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:40:03 -0500
Subject: Re: [GIT PULL] xen: branch for v5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897603;
        bh=yrhE7j00Mtsf9/fQt335X97bxVz/PrGLW3m6roM1KR4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=08MvlJg85Q1TZ/e5dO04m95fWliauAvm09XpRu0pSGoM4dptkUo6grfMn3qH+fRyT
         gjmliPDEsW56C8VhyKaN5nYjN2yw8xPf3es1h55RtC/bjRJygNg4sjlUlEpbA1+j+I
         BR7aCx6LdR/L1cjax4HB6sE4jTUxu7OknBrzFDfo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201120055947.613-1-jgross@suse.com>
References: <20201120055947.613-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20201120055947.613-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.10b-rc5-tag
X-PR-Tracked-Commit-Id: 65cae18882f943215d0505ddc7e70495877308e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ccf7a01e805f04defd423fb410f47a13af76399
Message-Id: <160589760312.4306.8801434833258557230.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Nov 2020 18:40:03 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Nov 2020 06:59:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.10b-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ccf7a01e805f04defd423fb410f47a13af76399

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
