Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05342E7A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 16:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgL3Pqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 10:46:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:46098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgL3Pqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 10:46:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEFAC20725;
        Wed, 30 Dec 2020 15:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609343163;
        bh=iU86KZtWe9c/XSBAjiylt0tQHEAv++h9tSjXqghxDjk=;
        h=From:To:Cc:Subject:Date:From;
        b=Akb7KZ0uPEuo8S66zBksOtQwDHA83N/8OyrWJa28zWP/bSDsQPyrpECLDQ0NHTH+F
         /0ZYt9zv8YXsC1NYGPlRrMYwnOlyGEfMaX1A4UMkUIxQR2h7LfMVuDQZiFwsBN0qa5
         k91gMaksQksFuwE2w0YxWsds0CLsI5ctKlgUdbOy9jeTA8B8l3GY1SRF7U6GOOOSMk
         /wsjas6eJ9dnnZNm2uer0LuZgXRGhss9VZUeI2hOyYwazt3iFs1X27DFz0nNLxfvOk
         0cBJyE+06Zq1NFbgo5if1S7D/AmxD46N1HSz3PzVl1B/2f7il+DtzUEGr06C3pJhHi
         q5HfC72/ypLyg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] genirq: Export irq_check_status_bit
Date:   Wed, 30 Dec 2020 16:45:40 +0100
Message-Id: <20201230154600.697832-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Changing some inline functions to use the new irq_check_status_bit
function out of line breaks calling them from loadable modules:

ERROR: modpost: "irq_check_status_bit" [drivers/perf/arm_spe_pmu.ko] undefined!

Export the function to make it work again. One can debate over
whether this should be EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL(),
as it could be called from any module before and making it GPL-only
changes behavior. However all other symbols in this file are
EXPORT_SYMBOL_GPL(), so I went with that for consistency.

Fixes: fdd029630434 ("genirq: Move status flag checks to core")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/irq/manage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ab8567f32501..dec3f73e8db9 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2859,3 +2859,4 @@ bool irq_check_status_bit(unsigned int irq, unsigned int bitmask)
 	rcu_read_unlock();
 	return res;
 }
+EXPORT_SYMBOL_GPL(irq_check_status_bit);
-- 
2.29.2

