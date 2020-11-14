Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213792B30BD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 21:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKNUvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 15:51:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgKNUvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 15:51:10 -0500
Subject: Re: [GIT PULL] um fixes for 5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605387070;
        bh=ny9al+eXJIKo9ouUcGssO4cAEeJpdHNGIUENKOa5hk8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RrHYCAouoAmmVmBLib6Ky1aN0Uk864uyfgbc1RTkYJ8S11Ry4iUdZOm15mg/agv6N
         63Vw67d8fpVVOnmDNPwBA6N+dOzWNDwIcaR7XLMyIrqhmtEf2lXR1MdUqXD/7szUhK
         O8OpQwI4Rv9UAFmZO6EB+1sLqizUxHR7R00bR/j4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <588878911.301948.1605306004530.JavaMail.zimbra@nod.at>
References: <588878911.301948.1605306004530.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <588878911.301948.1605306004530.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.10-rc4
X-PR-Tracked-Commit-Id: 9a5085b3fad5d5d6019a3d160cdd70357d35c8b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4aea779d35120d5062647d288817678decb28c10
Message-Id: <160538707005.24878.6761595780198110576.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Nov 2020 20:51:10 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Nov 2020 23:20:04 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4aea779d35120d5062647d288817678decb28c10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
