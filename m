Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A958C2979F3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 02:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758987AbgJXA0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 20:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756264AbgJXA0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 20:26:12 -0400
Subject: Re: [GIT PULL] Documentation fixes for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603499172;
        bh=ypbHnHbh42Ur/eyu51lIq1rmFLIB+mCKnXHBFLWoOHA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZPgyVfGY/1EzQ3jEMr5EvqikC6vqkVvPJAXJq9Pfks+X0c9KS1Wf1O62QXL6Y9FiW
         3HoX1VN1TgIa5pvKxL0Y0ftiBQHFfW/JhMFzC19orfrYoKvh8U6AuTBq6iLSpwIJxH
         t5j3Mwl0lQcxTE1AWARqeCgD3Kw2xx8Dn2rGoNWE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201023131719.5fec285a@lwn.net>
References: <20201023131719.5fec285a@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201023131719.5fec285a@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.10-2
X-PR-Tracked-Commit-Id: 62af696471e58bdfcf416fd56f032a60853c2bae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c80e42a4963b3f593d53fb8f565e5bbca61a6531
Message-Id: <160349917230.12519.8167580190404175746.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Oct 2020 00:26:12 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Oct 2020 13:17:19 -0600:

> git://git.lwn.net/linux.git tags/docs-5.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c80e42a4963b3f593d53fb8f565e5bbca61a6531

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
