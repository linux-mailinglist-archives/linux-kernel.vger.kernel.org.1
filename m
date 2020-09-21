Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EA2272AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgIUPtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbgIUPtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:49:19 -0400
Subject: Re: [GIT PULL] libnvdimm fix for v5.9-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600703358;
        bh=FVW2pjh7gDrjMnXGIR26gERgAX+e5lfOUkBMt5VBywM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DYcgT06YLvsM26NJXSaV2acuZ0akzLTFXQQPXLd2W+5eat0r0GMlwver0OTjN4x8/
         r6TQgaxHo0kXuvyGJUJNcUi0b1v1dgWchKNMhqLxqSaKiZgVt7R7gUhRZPB8iM1SI4
         J9BTrLEpxlzdSKuH9vRWORQzo65EdEzVbz7Y6lB8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4jCqzs7vjFCvLxHSL13OE0CX0Ptc75ApT-dyyGo_UZ1jw@mail.gmail.com>
References: <CAPcyv4jCqzs7vjFCvLxHSL13OE0CX0Ptc75ApT-dyyGo_UZ1jw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4jCqzs7vjFCvLxHSL13OE0CX0Ptc75ApT-dyyGo_UZ1jw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.9-rc7
X-PR-Tracked-Commit-Id: 88b67edd7247466bc47f01e1dc539b0d0d4b931e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a31128384dfd9ca11f15ef4ea73df25e394846d1
Message-Id: <160070335876.23869.6754079280762938592.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Sep 2020 15:49:18 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Sep 2020 07:37:33 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.9-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a31128384dfd9ca11f15ef4ea73df25e394846d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
