Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40E3300A26
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbhAVR1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:27:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:34450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729363AbhAVRLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:11:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 033B1ACE1;
        Fri, 22 Jan 2021 17:11:10 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] MAINTAINERS: Add myself as futex reviewer
Date:   Fri, 22 Jan 2021 09:11:01 -0800
Message-Id: <20210122171101.15991-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm volunteering to help review some of the pain.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3978e8b21fc4..6f204358908b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7333,6 +7333,7 @@ M:	Thomas Gleixner <tglx@linutronix.de>
 M:	Ingo Molnar <mingo@redhat.com>
 R:	Peter Zijlstra <peterz@infradead.org>
 R:	Darren Hart <dvhart@infradead.org>
+R:	Davidlohr Bueso <dave@stgolabs.net>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
-- 
2.26.2

