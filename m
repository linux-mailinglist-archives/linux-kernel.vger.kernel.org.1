Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436961B811B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 22:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDXUuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 16:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgDXUuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:50:18 -0400
Subject: Re: [GIT PULL] libata fixes for 5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587761418;
        bh=dBDW56QaC96bq2qKJgVjwJutpjTd4ij78wfj1ENrzsM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Y1oQ70PwcPcByY9LnBErFQ6Q3hHNu10KCHYFiRAYOhl0tTrI3VDChZBH7IzBI5ffB
         bLQaYsH6jlVRKiRTY3aX6jgQJ0XuhdUyKEwa8nUlKJrFtu+yn88V6jARFDanJaU3c7
         2lnpUW2wTVoXjzMiQHYOLZtnD3C/wGHSRYCdz2l4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0c2ac794-edf3-671a-7e6b-3b497e7c36ec@kernel.dk>
References: <0c2ac794-edf3-671a-7e6b-3b497e7c36ec@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0c2ac794-edf3-671a-7e6b-3b497e7c36ec@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/libata-5.7-2020-04-24
X-PR-Tracked-Commit-Id: 89e7c85026a0f8522e4017de70f4a87513874520
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81da3d3c1015e1db8b5fa121d4f6f9172d0299f3
Message-Id: <158776141849.11860.16327032479189777209.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Apr 2020 20:50:18 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Apr 2020 12:01:48 -0600:

> git://git.kernel.dk/linux-block.git tags/libata-5.7-2020-04-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81da3d3c1015e1db8b5fa121d4f6f9172d0299f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
