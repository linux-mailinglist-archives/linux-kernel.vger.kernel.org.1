Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D2A28FB1B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 00:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbgJOWTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 18:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731782AbgJOWT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 18:19:29 -0400
Subject: Re: [GIT PULL] HID for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602800369;
        bh=NwDQdSJHJcvmvlIvxX6nLETSnz/fsYBgI6sqM8UKz7A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=atAsFGrxdAr5OaV7NxgwmEYM7EIyLvWU+9T/Zrr84FyHH2qvZ2OHbszf2tQifiEZh
         iXCfOVnZcG+LU5C9lx8p8q1LCoDRMbdze4e0AyKvW5BYfbylNySAp66fodfjg7AqPv
         /Nv4ER/cku8VYuik+OC/H6+sE1xYV4wGxE3NHDTU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2010152048140.18859@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2010152048140.18859@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2010152048140.18859@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 3504e85cd8b1d18005f1867aa2a72bd48bd472fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf36c6b946c8895cf590f10dbd70b589b0dc101f
Message-Id: <160280036923.16623.14874967976119371758.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Oct 2020 22:19:29 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Oct 2020 20:52:36 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf36c6b946c8895cf590f10dbd70b589b0dc101f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
