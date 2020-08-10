Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE022413EB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 01:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgHJXkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 19:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgHJXkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:40:15 -0400
Subject: Re: [GIT PULL] HID for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597102815;
        bh=JhRQkyKeYY+EkaiKheN2XZOSz1me3U+YhjvHo1fWxjQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PYXUocsynGytbNl9Of/ZG8vz+4CyDp9Ev+dIHft84S3Fhn6w53KPX0dpVDBaxprXX
         bYiY+bmk+RaGgmrBIdAu1zNds3VlP+R28ioPhjKi5acwnJmqtMXHH+vV/QMhKMpxjJ
         5VpbnmgBrnAZh4fO7SbehAR/SK6CiU85vSOnxZ60=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2008101127040.27422@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2008101127040.27422@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2008101127040.27422@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: e6b6e19a4be74fb3b96f66d478ed69a088e4d11c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7b8e3689aa0b2def48b8c6eb1df060902eb2c0a
Message-Id: <159710281522.26236.11691950383437631871.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Aug 2020 23:40:15 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Aug 2020 11:29:10 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7b8e3689aa0b2def48b8c6eb1df060902eb2c0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
