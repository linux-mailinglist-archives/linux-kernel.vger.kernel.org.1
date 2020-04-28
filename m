Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C1A1BCCBF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 21:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgD1Tw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 15:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbgD1Tw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:52:58 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CC3220730;
        Tue, 28 Apr 2020 19:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588103578;
        bh=IpBlN6HeObjTA1Yvcaj1sRW4yDq8TR4oZlFFeD5QcHs=;
        h=From:To:Subject:Date:From;
        b=hFR+vSbRrWjoUOpDnqTbolnmEYxnQWk4d2o+j5YEOswNHPdPrUWLrFdYNctDZaIUq
         H45hAvhmcFxCzEyF7z/cakX9R9kGHyLSqIq/ExLgu7zB0TRSQ91sILEODhQss4a8N/
         mzmaanPfzc2aZEXGRhUHozT89qUNvT4Lq60L8DVM=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH RT 0/2] Linux v4.19.115-rt50-rc1
Date:   Tue, 28 Apr 2020 14:52:54 -0500
Message-Id: <cover.1588103561.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.115-rt50-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2020-05-01.

To build 4.19.115-rt50-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.115.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.115-rt50-rc1.patch.xz

You can also build from 4.19.115-rt49 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.115-rt49-rt50-rc1.patch.xz


Enjoy,

-- Tom


Rasmus Villemoes (1):
  hrtimer: fix logic for when grabbing softirq_expiry_lock can be elided

Tom Zanussi (1):
  Linux 4.19.115-rt50-rc1

 kernel/time/hrtimer.c | 2 +-
 localversion-rt       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

