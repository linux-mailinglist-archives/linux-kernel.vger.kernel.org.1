Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930131ED8A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 00:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgFCWaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 18:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgFCWaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 18:30:07 -0400
Subject: Re: [GIT PULL] kgdb changes for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591223407;
        bh=0qa2pBlPxoiVxp9sdRfMlXLDNXZw0uc2e8zaIMknhXU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1vtd8I3NCxT1UuF5kbGOjAp6TDIHo+P3NgBi9lrCM2F/DknTjUsXgkeFdejjdx/kV
         yzy9R7iDCIm92f4kU6nlgMlb+wwMXGCYZ2um0cMu0XNgk9rrvQ9hLjrLJRIYPPP5XZ
         G5bExPUvg5fiNDI6aanjLh17Huw+xe0XXnhoEub4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200602162440.l235arjoue5zwzi2@holly.lan>
References: <20200602162440.l235arjoue5zwzi2@holly.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200602162440.l235arjoue5zwzi2@holly.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/
 tags/kgdb-5.8-rc1
X-PR-Tracked-Commit-Id: c893de12e1ef17b581eb2cf8fc9018ec0cbd07df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1e455352b6f503532eb3637d0a6d991895e7856
Message-Id: <159122340700.21404.7156028484519375266.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 22:30:07 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Wei Li <liwei391@huawei.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Yan <yanaijie@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Jun 2020 17:24:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1e455352b6f503532eb3637d0a6d991895e7856

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
