Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1CA41A1A43
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 05:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgDHDUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 23:20:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgDHDU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 23:20:29 -0400
Subject: Re: [GIT PULL] Backlight for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586316028;
        bh=L+DIR3jC8US59W13pYHZK12GXHZNxn69pA7DhvFn20s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JO5Pr/hYLRczO39LoJKDNq/8QpZrZAdf6jVS50dEDa3PuCkYPT5oxT8pVOSAH/lgf
         yjib5J85AXiyrznAu2As8EoOUoLdYIRirUCL4kSvKRx7vdGIPm5It4DEVvZkhbke+L
         qYOVeYEvIh3zFAEuBAgqnKLyzunyPJpuMtm8/QL8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200407094021.GG30614@dell>
References: <20200407094021.GG30614@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200407094021.GG30614@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git
 backlight-next-5.7
X-PR-Tracked-Commit-Id: ee0c8e494cc3c135350cd5c4752e82af3feae1ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b574beb6257a21c231a6c2c272a0aeb84b655437
Message-Id: <158631602854.18814.11571076639940543407.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Apr 2020 03:20:28 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Apr 2020 10:40:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b574beb6257a21c231a6c2c272a0aeb84b655437

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
