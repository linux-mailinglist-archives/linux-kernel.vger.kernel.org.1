Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF9925EB80
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Sep 2020 00:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgIEWgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 18:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbgIEWgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 18:36:31 -0400
Subject: Re: [GIT PULL] Compiler Attributes for v5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599345390;
        bh=FErOH1Gwsxw35Ih0GVKEpAqX3OAWfJGddD/EPvRke60=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CAt5cukAef16dP7bFFH40wvdfXIp/Qbx+9tNMQ+g6/N4vbzdma/ITEo+o0JA6NWc4
         Uex3y2NrKkKVJSiHqcY8ZErDZIdyi6GPLi4skFZPsEfLzT+aRhpnnLAUwPb/78YB4Q
         C6BLc0bzTI+xfHskdGQQwU9jMp+/6JuQI+/7d2kA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200905120125.GA22011@gmail.com>
References: <20200905120125.GA22011@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200905120125.GA22011@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.9-rc4
X-PR-Tracked-Commit-Id: e5fc436f06eef54ef512ea55a9db8eb9f2e76959
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd9fb9bb3340c791a2be106fdc895db75f177343
Message-Id: <159934539083.12925.658622810362187924.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Sep 2020 22:36:30 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 5 Sep 2020 14:01:25 +0200:

> https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd9fb9bb3340c791a2be106fdc895db75f177343

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
