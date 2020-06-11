Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7468D1F6D32
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 20:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgFKSKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 14:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgFKSKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:10:21 -0400
Received: from localhost.localdomain (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1BFE20829;
        Thu, 11 Jun 2020 18:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591899020;
        bh=Dh+733UgTZQWMmPABeVGV0I+axU11oOHDrHJ8cjyMVA=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=IqfQop9qaBUDuriz/T37R2jfOFXBexGDpxbbDKFv5OMAztIAKVqtPYblaljVFp+wb
         suX3ix4KiN0nvImzuDkvcdz+ngp7aT6F4/XDgTg5F3njY8wiOOF4SrLx+/Wb+4eH9p
         U3ejYWxvVGuGbODFiPg/tpr99lzz4/vRxGoi+Y74=
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
Subject: [PATCH RT 1/4] fs/dcache: Include swait.h header
Date:   Thu, 11 Jun 2020 13:10:14 -0500
Message-Id: <bf76614887ac1bad027fc517f50a463d4faf5a7a.1591898986.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1591898986.git.zanussi@kernel.org>
References: <cover.1591898986.git.zanussi@kernel.org>
In-Reply-To: <cover.1591898986.git.zanussi@kernel.org>
References: <cover.1591898986.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.19.127-rt55-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 279f90ddf53cd6bd3c203fbbf488d642ea2603de ]

Include the swait.h header so it compiles even if not all patches are
applied.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
	fs/proc/base.c
---
 fs/proc/base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index a45d4d640f01..56b1c4f1e8c0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -95,6 +95,7 @@
 #include <linux/flex_array.h>
 #include <linux/posix-timers.h>
 #include <trace/events/oom.h>
+#include <linux/swait.h>
 #include "internal.h"
 #include "fd.h"
 
-- 
2.17.1

