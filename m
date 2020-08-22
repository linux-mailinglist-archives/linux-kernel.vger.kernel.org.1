Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A2F24E90E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 19:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgHVRck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 13:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728503AbgHVRce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 13:32:34 -0400
Subject: Re: [GIT PULL] Devicetree fixes for v5.9, take 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598117551;
        bh=FLzSlgFVBkF5QZVZMU+BHTmjffHTpS912NtlkIN1fXU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=r4Q2kFDl6GTpSNrtrhoHxYPJWuDCGq+Uuk+fP2Xf53Amt9MHTJy7/vPQ6j3o6ghCF
         Z5ZT4UsUtXhn5i7cffMn40dxDkOjQvY1ixDkSaNZliPXoMQQHyExn/cWFXEUPGvzbL
         YlACbApmWOsePqUyOXCNoIccAlsN09VEjEfYVl6w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200822032540.GA2215775@bogus>
References: <20200822032540.GA2215775@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200822032540.GA2215775@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.9-2
X-PR-Tracked-Commit-Id: 5cd841d2676a702e5f79a8bacbfbae3bfc2411f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6af63305666f4e6fb211f3f12b802b3255f5194
Message-Id: <159811755175.17427.3895877017502808357.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Aug 2020 17:32:31 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Aug 2020 21:25:40 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6af63305666f4e6fb211f3f12b802b3255f5194

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
