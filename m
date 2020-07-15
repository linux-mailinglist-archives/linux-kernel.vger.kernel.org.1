Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB75220DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 15:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbgGONK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 09:10:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32942 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730868AbgGONK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:10:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id BE3C22A0290
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Cc:     mingo@redhat.com, dvhart@infradead.org, kernel@collabora.com,
        mchehab@kernel.org, corbet@lwn.net,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH] futex: MAINTAINERS: Re-add selftests directory
Date:   Wed, 15 Jul 2020 10:10:36 -0300
Message-Id: <20200715131036.9692-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 95ca6d73a8a97 ("docs: move locking-specific documents to
locking/") accidentally replaced the selftests line for a duplicated
documentation one. Revert this change.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b4a43a9e7fbc..d03d34c51737 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7107,7 +7107,7 @@ F:	include/linux/futex.h
 F:	include/uapi/linux/futex.h
 F:	kernel/futex.c
 F:	tools/perf/bench/futex*
-F:	Documentation/locking/*futex*
+F:	tools/testing/selftests/futex/
 
 GATEWORKS SYSTEM CONTROLLER (GSC) DRIVER
 M:	Tim Harvey <tharvey@gateworks.com>
-- 
2.27.0

