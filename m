Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8F92BC184
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 19:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgKUSjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 13:39:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:48900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgKUSjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 13:39:06 -0500
Subject: Re: [GIT PULL] seccomp fixes for v5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605983945;
        bh=VRElEc6Rndhc7yPPS7t+aNwUUF48TJa4CfRZtVs3n1A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bmQ4Zh15MN15czuXlCnEraxOmCZjQEeD4PZSDnxXbJieU1JeTMBFx1vEox3CPv4Sd
         dnGNlhD26G2VrHZ3YEQyyk8VXO8QjK3caUzuFzWSzWPlG2ZAFyRFGJaHpBsQX7rt5d
         259oksUPPeVUEqLfEKBwltimgaxPFhuIZgrb8TEE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202011201112.C7CFF68B07@keescook>
References: <202011201112.C7CFF68B07@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202011201112.C7CFF68B07@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.10-rc5
X-PR-Tracked-Commit-Id: 4c222f31fb1db4d590503a181a6268ced9252379
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea0ab64306355432746bafda0364fb2d593bc9e3
Message-Id: <160598394585.7589.16724593839803194663.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Nov 2020 18:39:05 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Paris <eparis@redhat.com>, Jann Horn <jannh@google.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Will Drewry <wad@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Nov 2020 11:13:51 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea0ab64306355432746bafda0364fb2d593bc9e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
