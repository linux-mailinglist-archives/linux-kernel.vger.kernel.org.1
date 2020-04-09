Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8141A2E9D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 06:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgDIEz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 00:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgDIEz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 00:55:28 -0400
Subject: Re: [GIT PULL] libnvdimm for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586408129;
        bh=6mJu0lpATwQDPBEXpJ7mTTCHiScjfJP5BkbsCBkxF30=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nMkVIZbKdATk1otDcBPX6ZZ7LWRg6LAw4XuwOeGcDUkqhP8+2RELcN843OzdVLggH
         dZPy6gx4RUjOO9CpyNSlLdfWZBp5RcD4xeYMszU2PdGHn3JOfFdxM+9kLD639zATZ5
         I79G+kbLvX5OWK1UPeo3XzS4rUCTUoqIixu1znwA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4gKr57qNnMEupjcjQmH9Vy_iZuLPE1VA36QAkKhzEbzSA@mail.gmail.com>
References: <CAPcyv4gKr57qNnMEupjcjQmH9Vy_iZuLPE1VA36QAkKhzEbzSA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4gKr57qNnMEupjcjQmH9Vy_iZuLPE1VA36QAkKhzEbzSA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-for-5.7
X-PR-Tracked-Commit-Id: f6d2b802f80d0ca89ee1f51c1781b3f79cdb25d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b06860d7c1f1f4cb7d70f92e47dfa4a91bd5007
Message-Id: <158640812899.3202.9422311262435999632.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Apr 2020 04:55:28 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Apr 2020 13:12:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b06860d7c1f1f4cb7d70f92e47dfa4a91bd5007

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
