Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96DB2B6EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbgKQTee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:34:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729962AbgKQTeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:34:31 -0500
Subject: Re: [GIT PULL] s390 updates for 5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605641671;
        bh=N7EnDLQFFaizo5Rqx0DTlHfJupqoVbKV2YZzPoXxg/0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=h7VNBpXzfh5eoYwjbG71SwnIM42QMixI6sHzifwhoZFZI+Fwf/H+kigxUqFUQB7V7
         PWIQoEf4fbojRb9D3Fnuz2h1nEM/Iyr3S0/BtEKfcJqk5W0LTh+Tt/OcUr75MgR1Vr
         h4jLVSHZIJQoy6HVkuPxaiz2vbFNHMhJm+v7VDiQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201117182158.GA4746@osiris>
References: <20201117182158.GA4746@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201117182158.GA4746@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-4
X-PR-Tracked-Commit-Id: 78d732e1f326f74f240d416af9484928303d9951
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 111e91a6df505e532a3809ead372787a01e23e0c
Message-Id: <160564167101.32053.7789059953619285240.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Nov 2020 19:34:31 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Nov 2020 19:21:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/111e91a6df505e532a3809ead372787a01e23e0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
