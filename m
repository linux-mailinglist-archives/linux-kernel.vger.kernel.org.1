Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420CF2DDCD8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 03:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbgLRCMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 21:12:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732286AbgLRCMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 21:12:35 -0500
Subject: Re: [GIT PULL] CIFS/SMB3 Fixes and Improvements for 5.11-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608257515;
        bh=VrHjuIVeO1xLgLicxFmb80QEHw9GQv7JvBFwFVL8pt0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lLZS8cUEy137FsrgqmXCO2yv1xL6BrAeCqdKO2HGC+MJ6s3nGr1pshiEV9+7cI1Zh
         YnRnAfqjxYhLRjJBv2NA1QmhUdO7XOL/7KzDHszz+X5sH6vAlxk1pGjbbw1wWEm5tZ
         uw6aNA7KBemoVQ6DErb+pp7yCCRDSlJvNmBJbLhep9cjWfQ4uVMUu5By76jot8lFFE
         wpf4PmXP7OICiFC/wYvPp/M32NUVuo1BNiFSMQcKZv76P20mjgoCZfb+BN5lniEteU
         q13XC0SjafQVyc8c+rhR+obVsHm5M4zysyqTC5D3Vw1TRkCVQu72J1tU3UMie3tTpn
         yJZ4ZeRkNWWQg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtnwFY4dYMzOij1ZhkQVaF+d9sGcwV3Vx2VywMsVaahQA@mail.gmail.com>
References: <CAH2r5mtnwFY4dYMzOij1ZhkQVaF+d9sGcwV3Vx2VywMsVaahQA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtnwFY4dYMzOij1ZhkQVaF+d9sGcwV3Vx2VywMsVaahQA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.11-rc-smb3
X-PR-Tracked-Commit-Id: afee4410bc6c50e1422c5a45d633ad0e478ea960
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e13300bdaa68f5487000e66baed1ff69bcb510bf
Message-Id: <160825751544.20122.125736420792536798.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Dec 2020 02:11:55 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Dec 2020 19:05:32 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.11-rc-smb3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e13300bdaa68f5487000e66baed1ff69bcb510bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
