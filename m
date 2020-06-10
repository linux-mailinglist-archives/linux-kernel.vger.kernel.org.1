Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C8D1F5D38
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 22:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgFJUa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 16:30:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgFJUaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:30:24 -0400
Subject: Re: [GIT PULL] UML changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591821024;
        bh=j7JnUzzkBQUS8Cb4iN2Pzvp+rtD8G88Uz7rNrgd+Pb0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o6h0V6ggOWx3lPdY8BkpS1JisQxlSwRu0YOlhtpooecPVk5t0IR/fxp9U+bn+WUNZ
         V/2g453zvKF/SmsYT6vjv1aqkjBYB1kX1sXRMV6GIIHLuEt7PZtnti0FCskIR7pQGX
         mpkEaG1MYkOxCX1BJDs5WKE3SKJRGvWapzdoVsT8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1858220125.350.1591736510906.JavaMail.zimbra@nod.at>
References: <1858220125.350.1591736510906.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1858220125.350.1591736510906.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
 tags/for-linus-5.8-rc1
X-PR-Tracked-Commit-Id: f6e8c474390be2e6f5bd0b8966e19958214609ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84fc461db99b2dc19e019c0a97725a3653687981
Message-Id: <159182102423.16227.12145075205238240772.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Jun 2020 20:30:24 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Jun 2020 23:01:50 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84fc461db99b2dc19e019c0a97725a3653687981

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
