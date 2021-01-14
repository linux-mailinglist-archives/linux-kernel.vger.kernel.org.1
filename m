Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49522F6D96
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbhANVzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:55:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730523AbhANVzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:55:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 96B2723A5E;
        Thu, 14 Jan 2021 21:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610661301;
        bh=5e/hnQJ7lQg2OhqP4AWq9W8s64RHgFWUeRIW8dqlaew=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F9xQ0Uke1+h1+cKrKaZb/+urcqzuxrnQ145rFKKQ3uZq89zdrTgAzTGR9XVf8LUdB
         AKh2WLIt+xBrqeGBDp0e8KPQ8eN/6rH93S9HEtnzHoNEB99UelWMVQzBjmd8BGG0Zx
         4ZvrvogDZOCj3gL4WcKVSF0gKWwu5+PezQwbuHzagQ+6AtUpsZaybDTN8nXq8v5rjH
         rqBQObE2V190AZPHJEsrv9PNFWHl7pLtgpbRBUrocwKSTxlHuTx7ALgWQV0hiyun3/
         PbxmnxVfIlH5LkcxMVkb7fK8pOkI/q/xS7yJKDzQZZvXi7O9Ef6jmtCuWNMkJ82Dha
         HO5bwevp5rYng==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 8BF706018E;
        Thu, 14 Jan 2021 21:55:01 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2101141332140.13752@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2101141332140.13752@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2101141332140.13752@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 7de843dbaaa68aa514090e6226ed7c6374fd7e49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2bbe17ae87938ca44756741ec77e3be76a4a0ea0
Message-Id: <161066130156.27370.10777770722906733959.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Jan 2021 21:55:01 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 Jan 2021 13:33:57 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2bbe17ae87938ca44756741ec77e3be76a4a0ea0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
