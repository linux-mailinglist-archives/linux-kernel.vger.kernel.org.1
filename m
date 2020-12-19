Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA0F2DF1BB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 22:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgLSVHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 16:07:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbgLSVHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 16:07:17 -0500
Subject: Re: [GIT PULL] i3c: Changes for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608411997;
        bh=Rp4INsEa+tD59YcZW7lCoK0qiFbUmetfZAEHqooOlsA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fKSGup2zkVjPXtRhrmvUbMNH8dWElZvK1icoskDzuzoU+k8kQB30LBVsrB9SZACAo
         ZDvvQG1ZWkG3XnRNmt2wMqbxaywVbA5UIgXNIm+GSD7kjjngEmFztFzBWrFfj2xF0M
         P8darrPMXkVTFDlnn/amvIU9ksIoym2j3QzIU8ePupZ1qTV1yJDWhPIUZFhNEn+tSb
         N6eXAfedvvScem/FzfGxT1/Y+IsW+tyvOC3OgztiJgIZth1Bj2wYInIPK+jD6R+1lz
         sibnNl+KwUWdy9pDPyqBOK3uji8e9MzQRAI/ptjn9eVRSRhyrGxq299nQtXIevy+2T
         hxcGuUVHARaxA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201219080632.686b92bc@collabora.com>
References: <20201219080632.686b92bc@collabora.com>
X-PR-Tracked-List-Id: <linux-i3c.lists.infradead.org>
X-PR-Tracked-Message-Id: <20201219080632.686b92bc@collabora.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.11
X-PR-Tracked-Commit-Id: 95393f3e07ab53855b91881692a4a5b52dcdc03c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 190daf19206783bb16655db14e604a0d724c4bbf
Message-Id: <160841199713.20285.16202306581510604938.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Dec 2020 21:06:37 +0000
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <abelloni@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Dec 2020 08:06:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/190daf19206783bb16655db14e604a0d724c4bbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
