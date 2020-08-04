Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41F123C1AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgHDVlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 17:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728211AbgHDVkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:40:10 -0400
Subject: Re: [GIT PULL] var-init update for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596577209;
        bh=pwKIip4c9LuVRixnVv3NRlLtJVLF7H0I5M96mfX+zW8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TKWOMQg4wzJXWq0V+rzFmdLcvEQn7Fa1JL+QremvQD+2XsvONdKcCy59HRUyswgbW
         5Vv6qrIzXfuL0wfiESkxlfy0XDvWYFFTd1Y/8hvVKP0MX+5ANDAiGcVGS3Tlxa4QV+
         oNXIAM7M+6dOhYTrnVQsf/SoVaoXw/Q5a/q2kwrI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202008031155.E07E37D@keescook>
References: <202008031155.E07E37D@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202008031155.E07E37D@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/var-init-v5.9-rc1
X-PR-Tracked-Commit-Id: f0fe00d4972a8cd4b98cc2c29758615e4d51cdfe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b5d3be5d690a94be390ccf3e4db8dcb7409bf75
Message-Id: <159657720974.17686.16956000714119560329.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 21:40:09 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 11:57:08 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/var-init-v5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b5d3be5d690a94be390ccf3e4db8dcb7409bf75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
