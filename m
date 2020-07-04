Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0C821446E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jul 2020 09:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgGDHAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jul 2020 03:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgGDHAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 03:00:05 -0400
Subject: Re: [GIT PULL] CIFS/SMB3 Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593846004;
        bh=JU6oMLsD4thV78kG8vdHo6EkLdJMAgd2zBvlSnSWlB4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=giGAaj02aooTPwzwwAmUFVRiH3F08zII6ZOSCZHV/8FgXFIlQLcrYuhZdKk4cZZbA
         Pb7MXwIpkQ4uOZmYtk7+RBl4mIMt0TXdYpS/yNNRjAVbkDngQTuv0LQcVvjRozorWo
         w0dHBtr3IoFhJsmyUQB7xTE0MN4G1KMtIU24yO4k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msVSYHHt5y9eCrXJCBiNJEmpkVEF+iHuqTfsM9vQxw+5Q@mail.gmail.com>
References: <CAH2r5msVSYHHt5y9eCrXJCBiNJEmpkVEF+iHuqTfsM9vQxw+5Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msVSYHHt5y9eCrXJCBiNJEmpkVEF+iHuqTfsM9vQxw+5Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.8-rc3-smb3-fixes
X-PR-Tracked-Commit-Id: 19e888678bac8c82206eb915eaf72741b2a2615c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8e516b36748fd87943e54596a8a6f04ec05f1a5
Message-Id: <159384600472.10337.14762338179794796167.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Jul 2020 07:00:04 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Jul 2020 22:44:08 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.8-rc3-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8e516b36748fd87943e54596a8a6f04ec05f1a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
