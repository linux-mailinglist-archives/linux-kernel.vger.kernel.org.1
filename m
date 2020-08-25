Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB354251FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 21:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgHYTQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 15:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgHYTQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:16:20 -0400
Subject: Re: [GIT PULL] libnvdimm fixes for v5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598382980;
        bh=69ccBDqMOEBQbGkKJqgfjlVZ2hQNRbSK31PGrxkE70g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=afwk3wvW9YCcctQCLVnXnPxFNZWxXCgAT0WXAFMsP1WnGtnZB5rKx5dpa+5d+gNn1
         SDxzKYau2ESpKDNn3iFgRa+sE0/+pBeGWSK/GjGHsd9G+r3HCrZ6cqiUU/DLjMtPke
         wYEqSPIkpVCxnm8A74ETKJqhX1SXSSqIvjj2VUvk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7d850f417b20bfa559e6ef3eb133d336fb2eda3f.camel@intel.com>
References: <7d850f417b20bfa559e6ef3eb133d336fb2eda3f.camel@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7d850f417b20bfa559e6ef3eb133d336fb2eda3f.camel@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-fix-v5.9-rc3
X-PR-Tracked-Commit-Id: c2affe920b0e0669650943ac086215cf6519be34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7d1f235aaffbac15a07455a774aca42d027638c
Message-Id: <159838298051.30843.9809048489467038231.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Aug 2020 19:16:20 +0000
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "qiang.zhang@windriver.com" <qiang.zhang@windriver.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ahuang12@lenovo.com" <ahuang12@lenovo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 25 Aug 2020 00:57:12 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-fix-v5.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7d1f235aaffbac15a07455a774aca42d027638c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
