Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4711C4BB4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 04:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgEECFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 22:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgEECFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 22:05:06 -0400
Subject: Re: [GIT PULL] HID subsystem fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588644305;
        bh=8ZmG8TIDTUSf2fKNd8BtZV7B44c64ahloQrSJrizYmk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Hlr0euRiVKDBq6wrxKvYqhxK8aMTYlCi4PlTJ6YSKItodE7ah3jg+0qO551AwgIrQ
         VFipohqjcdrntAhWMEYM/QNrWPg+r8cw2IvCXOLnNJamZ3s+AHiNFnNFX2npbyG0jH
         rxHjemj6ciq7uboHmwMfHgJMSYLP4jz7TQKbQ+aw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2005050016220.19713@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2005050016220.19713@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2005050016220.19713@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 1e189f267015a098bdcb82cc652d13fbf2203fa0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47cf1b422e6093aee2a3e55d5e162112a2c69870
Message-Id: <158864430581.23291.6038713442897358560.pr-tracker-bot@kernel.org>
Date:   Tue, 05 May 2020 02:05:05 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 May 2020 00:18:38 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47cf1b422e6093aee2a3e55d5e162112a2c69870

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
