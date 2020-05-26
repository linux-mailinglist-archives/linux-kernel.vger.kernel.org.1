Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DD61AE5A8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 21:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbgDQTPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 15:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728151AbgDQTPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:15:22 -0400
Subject: Re: [GIT PULL] Devicetree fixes for v5.7, take 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587150922;
        bh=MQM53BbVC2OrZUMe236AuRXoO62cVGl+vSGKNZfke6o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PrVnpEiRYoRbGJSQDzAfbqHAKabQn0JD9WUnZi3+yGw4E2K3ysmHg2kyc24uJuP8A
         yHJvxupNl80Qz9q9k3bn267tQVThkzlJhzWIq5eS0EUsTuYVBOD+PbJm/DqshMSMz0
         SYl9shtvH6MnAMQZUMEEr/hXbz231tKSwZB3fw7E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200417161010.GA14296@bogus>
References: <20200417161010.GA14296@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200417161010.GA14296@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.7
X-PR-Tracked-Commit-Id: 0903060fe590105b7d31901c1ed67614c08cee08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fce9058ca8b1c784515e7986385f2b33927a44b
Message-Id: <158715092222.7925.15410358690654400876.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Apr 2020 19:15:22 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Apr 2020 11:10:10 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fce9058ca8b1c784515e7986385f2b33927a44b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
