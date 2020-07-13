Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDA521CC31
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 01:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgGLXpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 19:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbgGLXpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 19:45:03 -0400
Subject: Re: [PULL 0/3] xtensa fixes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594597503;
        bh=aYOvkV3FqzQPRgqjA1K8djXyZwXO1oYL79KDo3RuH4E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qqlmzppDrYMTI5Nq2Z2qGBJr+P/VGYq1LuCKL9dYma/mYJzPZms3LcZYcPQn3zClD
         0ZaNzjZfGCK5MvrjOf/ZaxosKFyWY2wej0C1AAsnyJyc75EScM5aCMvClRn0EPCbUP
         QpnifQ+C2NDO53kWjG/lHaW4ejIVh6wnyXAcCdUY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200712195523.6411-1-jcmvbkbc@gmail.com>
References: <20200712195523.6411-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200712195523.6411-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20200712
X-PR-Tracked-Commit-Id: ee769ebbe9e5fc7219e979fb7c5ed5bb5722649e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c38b7d3c48bbbec043913354b5974f998373efa
Message-Id: <159459750360.6499.2063385470455622433.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Jul 2020 23:45:03 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Jul 2020 12:55:23 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20200712

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c38b7d3c48bbbec043913354b5974f998373efa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
