Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256D128D22D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389794AbgJMQYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:24:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389679AbgJMQYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:24:13 -0400
Subject: Re: [GIT PULL] dlm updates for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602606253;
        bh=7GPBO1gJtFuWS0WigZgW97nYRxdD14BqQ0R/PmZFQZ8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LbS1y0E1zE97LZ3pAhV3CBWN0hDC6qn9s7u5L46GiiE3YNy1a+feCkJG4COfHVXcc
         yy6s2w9W2X0mpjjelMPSaJhex1fulq6DEU8KrAMQaH6yTd4LUSw1GXsvEh4mNRs7Ei
         0+mxZu/8ZXhfRkcj8AFYVO53QtyqLoiFokrD7U6k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012182053.GA16029@redhat.com>
References: <20201012182053.GA16029@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012182053.GA16029@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.10
X-PR-Tracked-Commit-Id: 4f2b30fd9b4bd6e3620fe55786df7fc5f89ad526
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c024a81125ca2999d563d40cf4cedba771c2dc77
Message-Id: <160260625349.24492.11548221282095624843.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 16:24:13 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 13:20:53 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c024a81125ca2999d563d40cf4cedba771c2dc77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
