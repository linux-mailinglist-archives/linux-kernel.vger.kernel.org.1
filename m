Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5F01AF51A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 23:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgDRVPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 17:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgDRVPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 17:15:21 -0400
Subject: Re: [GIT PULL] hwmon fixes for v5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587244521;
        bh=nqDi78DaRqqGf751NQR4MUHd/ujN2gn1CERnHWfp/zA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rSrn3e6B3M6wlZiza3cy+BdK+IV+xx2OxyXsDy7uMFCd8gsDyasBiCxHmgGOToWE2
         Rb+OLhjNN7+gAyinEywtV8R4l+/L873E3hnsi5Z+c91POyPJ7T7gmMM3SXOWDLyYl7
         BM0TA0W1RNcBku2C2zeRvPruobrSdHRcGxv4RxcU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200418194937.5589-1-linux@roeck-us.net>
References: <20200418194937.5589-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200418194937.5589-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.7-rc2
X-PR-Tracked-Commit-Id: c843b382e61b5f28a3d917712c69a344f632387c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eeaa762549f80ad1d69afbad50bf6d8629ad6649
Message-Id: <158724452108.32136.6002516637231338805.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Apr 2020 21:15:21 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Apr 2020 12:49:37 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eeaa762549f80ad1d69afbad50bf6d8629ad6649

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
