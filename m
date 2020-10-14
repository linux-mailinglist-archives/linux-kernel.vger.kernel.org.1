Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8ABF28E6C2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389690AbgJNSxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:53:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389559AbgJNSxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:53:14 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.10-1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602701593;
        bh=hgsAuFnV+XyYdrwUzhHQvyfgDZYdViBQxZqKIoEqCx0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pvKYByJSf01ZYUKnvjjiH0jgsacj4B/TKsYFxaucmSOt0Z5gQkGJDNv588JksPiEd
         5lfquNQh2eMC8Vz7Zntpo42iDurRDt6Hj6vtLU3++XXuJWmQLRkNeOTWopWXk16LJ9
         d3miZfT5MGvOS4hH1fHDw9ZAXFQLofO8/MDdhKFg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9335fbd5-81a2-59cb-d6ee-52e3b4de641f@redhat.com>
References: <9335fbd5-81a2-59cb-d6ee-52e3b4de641f@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9335fbd5-81a2-59cb-d6ee-52e3b4de641f@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.10-1
X-PR-Tracked-Commit-Id: 1a3f7813f38e400b0b63492b626b425f0a043d0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15cb5469fc5fff06969832028b743cb658d1a5b5
Message-Id: <160270159358.3085.9367896025733701108.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 18:53:13 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Oct 2020 14:26:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15cb5469fc5fff06969832028b743cb658d1a5b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
