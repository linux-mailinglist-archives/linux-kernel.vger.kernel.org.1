Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763E9242143
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 22:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgHKU1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 16:27:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgHKU1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:27:20 -0400
Subject: Re: [GIT PULL] libnvdimm for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597177640;
        bh=qSJ2hmDn6wJ1ZrKTulfts5iP7n/kImdSr4MJJ3oLLMk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KgZ0PNH5FYPqQ4Dj5Nn9OOHe77bFZpCAMmiR3/dc9HPOU8Y8rOr33sYOxpDSF6Itf
         7PL1K8ff5WdIrNzQhoCQAntnVfkk+foJhL7g4AFTcE5pFabIrzVdCVFR/aiZCgpAZ7
         jtA3f4ihg/7u6qr7oJeOQEoseXj4VssoLbMdtwV4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f44b21c38313fa8e19a3e70eb285e0dd319eb421.camel@intel.com>
References: <f44b21c38313fa8e19a3e70eb285e0dd319eb421.camel@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f44b21c38313fa8e19a3e70eb285e0dd319eb421.camel@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/ tags/libnvdimm-for-5.9
X-PR-Tracked-Commit-Id: 7f674025d9f7321dea11b802cc0ab3f09cbe51c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4bf5e3611895ede257d736b7359db669879a109f
Message-Id: <159717764041.9233.3951429619218554065.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Aug 2020 20:27:20 +0000
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Aug 2020 01:20:48 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/ tags/libnvdimm-for-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4bf5e3611895ede257d736b7359db669879a109f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
