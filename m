Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEA91ED7C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 23:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgFCVFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 17:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbgFCVFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 17:05:09 -0400
Subject: Re: [PULL 0/5] xtensa updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591218309;
        bh=iC7xMIm/zmdOxk4WTfTegn/gUkuroR955zHSrymnLO0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vV1uhI4SgJ811h2Kkp+ysSeRlL/N4pK1GISb2nw4X/57WazKzchtgO7nEHB1CULp9
         3l2ErYERoc47gh8uv7GeMo8chbGiqfT/i0T7kreBbQyjFyChRtek019JBj2AsQHvWw
         qw7wsRPJcTeMrngxLNNE7NLde7/fFOSHNWS9CosQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200603092329.10427-1-jcmvbkbc@gmail.com>
References: <20200603092329.10427-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200603092329.10427-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20200603
X-PR-Tracked-Commit-Id: 3ead2f97bd44a9a106572d306cb04a878c569cb2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38696e33e2bdf91cbbc7a2291dc6db862d9dfd42
Message-Id: <159121830936.19900.9068582461894666271.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 21:05:09 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  3 Jun 2020 02:23:29 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20200603

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38696e33e2bdf91cbbc7a2291dc6db862d9dfd42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
