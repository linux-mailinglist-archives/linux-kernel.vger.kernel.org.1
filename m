Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7380E1F6D31
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 20:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgFKSKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 14:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgFKSKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:10:19 -0400
Received: from localhost.localdomain (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DBA6206DC;
        Thu, 11 Jun 2020 18:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591899019;
        bh=F8cvwpDKGdmZc6IfUzyy1EM1Wo7LEgDRlgAJspxJMFY=;
        h=From:To:Subject:Date:From;
        b=NQdyfYQZ7W9RWfeWMm2Tkizju/XnR6uGDWY6pYxuXOk4weud/Sx0SYrJ2N/KgiMFb
         xqpMovaa/mlWyLQawFhdNgAEzv0bKDdWLur8CwO+XfdCpjHOEfTjYWFCqbF7F2LEiq
         ZU4PKNp8cGOQDbq3n8tA/5d6P91JPMKuCQv/cldI=
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
Subject: [PATCH RT 0/4] Linux v4.19.127-rt55-rc1
Date:   Thu, 11 Jun 2020 13:10:13 -0500
Message-Id: <cover.1591898986.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.127-rt55-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2020-06-18.

To build 4.19.127-rt55-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.127.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.127-rt55-rc1.patch.xz

You can also build from 4.19.127-rt54 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.127-rt54-rt55-rc1.patch.xz


Enjoy,

-- Tom


Kevin Hao (1):
  mm: slub: Always flush the delayed empty slubs in flush_all()

Sebastian Andrzej Siewior (1):
  fs/dcache: Include swait.h header

Tom Zanussi (2):
  tasklet: Fix UP case for tasklet CHAINED state
  Linux 4.19.127-rt55-rc1

 fs/proc/base.c   | 1 +
 kernel/softirq.c | 6 ++++++
 localversion-rt  | 2 +-
 mm/slub.c        | 3 ---
 4 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.17.1

