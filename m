Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 629161A1648
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 21:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgDGTz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 15:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgDGTz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:55:26 -0400
Subject: Re: [GIT PULL] OpenRISC updates for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586289325;
        bh=X8SARuotaC6mxy/ctY3ZlwjUF2pQ/3bmecn8BGIhhAE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c/XBGjzE5XMyfx+zpkZdxkxk2QleADHbPwLivvocpZhjRLEXbSQnabVH6VB63HslF
         6GbMWvauRkva/MHK0CfCRIsgpsNrd2gk5QLJeK7pJT1F76VQ0QaFz0M/HUS0q3qKD6
         8m7Mv5z6QXQ+PSwdCebOhpeadntXhn7pSocbaYhA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200407121628.GP7926@lianli.shorne-pla.net>
References: <20200407121628.GP7926@lianli.shorne-pla.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200407121628.GP7926@lianli.shorne-pla.net>
X-PR-Tracked-Remote: git://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 9737e2c5f0bc768b58416ec070bd96c91c52a153
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5d247661e869b71e4db5ca69b08b9607895d496
Message-Id: <158628932584.3792.16656826106512591465.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Apr 2020 19:55:25 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Apr 2020 21:16:28 +0900:

> git://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5d247661e869b71e4db5ca69b08b9607895d496

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
