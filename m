Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335012B6B94
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgKQRTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:19:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgKQRTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:19:51 -0500
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C71A238E6;
        Tue, 17 Nov 2020 17:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605633590;
        bh=D3rUQgrB9CUpnuLawSq5Q64bmWGHbHkutgQ+4ybYmIM=;
        h=From:To:Subject:Date:From;
        b=03QPdgo3Fs9OtCR+ktyOvfhRjC/GJ9BpAXYmdl4JobXL82tZX64Gd4pGpLfRFWMVo
         da4L7v+hye71/SIiyA8dJbRRKEA/JAn5Wy8u+autTidFnHcaHar6a+s03JMASYjXcT
         rj25oMOR62bHcU0V126pwExy3gLPEzlqGn0Fo2Rs=
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
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 0/3] Linux v4.19.152-rt66-rc1
Date:   Tue, 17 Nov 2020 11:19:45 -0600
Message-Id: <cover.1605633581.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.152-rt66-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2020-11-20.

To build 4.19.152-rt66-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.152.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.152-rt66-rc1.patch.xz

You can also build from 4.19.152-rt65 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.152-rt65-rt66-rc1.patch.xz


Enjoy,

-- Tom


Oleg Nesterov (1):
  ptrace: fix ptrace_unfreeze_traced() race with rt-lock

Sebastian Andrzej Siewior (1):
  mm/memcontrol: Disable preemption in __mod_memcg_lruvec_state()

Tom Zanussi (1):
  Linux 4.19.152-rt66-rc1

 include/linux/memcontrol.h |  2 ++
 kernel/ptrace.c            | 23 +++++++++++++++--------
 localversion-rt            |  2 +-
 3 files changed, 18 insertions(+), 9 deletions(-)

-- 
2.17.1

