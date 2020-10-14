Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2CE28E909
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 01:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgJNXCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 19:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730949AbgJNXCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 19:02:13 -0400
Subject: Re: [GIT PULL] IPMI bug fixes for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602716532;
        bh=r66+gnK4K1JduHZ8qq9lsATuQvic+/G0xAakhAXKkBg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qjURLnce21EuLqvhjOVWOwQroMkg+fFAIdOV8G94tGxTgtHauY8bxPk/5rohP+jbM
         fX/Ee6suEt+wh6oglKGDoMKji9KK/gw+QZ61Gbo1i+kzm+Hu6rT5Sns5ED1agFMHF1
         YmDmOlAara4ubkllQSxr1nhkDzg74wpL0BjFDLTQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201013155649.GD66562@minyard.net>
References: <20201013155649.GD66562@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201013155649.GD66562@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.10-1
X-PR-Tracked-Commit-Id: 8fe7990ceda8597e407d06bffc4bdbe835a93ece
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e4dc3d59284ea3bc7c3e40694bce84d988b01af
Message-Id: <160271653272.18101.4301117588051458594.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 23:02:12 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Oct 2020 10:56:49 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e4dc3d59284ea3bc7c3e40694bce84d988b01af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
