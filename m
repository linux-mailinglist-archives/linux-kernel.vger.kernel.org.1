Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8717226F754
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgIRHse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:48:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57902 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726783AbgIRHse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:48:34 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A4E5BD61ED163A452908;
        Fri, 18 Sep 2020 15:48:32 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 15:48:22 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <nico@fluxnic.net>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH] vt: fix some doc warnings in vt.c
Date:   Fri, 18 Sep 2020 15:47:05 +0800
Message-ID: <1600415225-17736-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following warnings caused by mismatch bewteen function parameters
and comments.
drivers/tty/vt/vt.c:3994: warning: Function parameter or member 'vc' not described in 'con_debug_enter'
drivers/tty/vt/vt.c:3994: warning: Excess function parameter 'sw' description in 'con_debug_enter'
drivers/tty/vt/vt.c:4051: warning: Excess function parameter 'sw' description in 'con_debug_leave'

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/vt/vt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 19cd4a4..1e9a6b6 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1180,7 +1180,6 @@ static inline int resize_screen(struct vc_data *vc, int width, int height,
 /**
  *	vc_do_resize	-	resizing method for the tty
  *	@tty: tty being resized
- *	@real_tty: real tty (different to tty if a pty/tty pair)
  *	@vc: virtual console private data
  *	@cols: columns
  *	@lines: lines
@@ -3980,7 +3979,7 @@ EXPORT_SYMBOL(con_is_visible);
 
 /**
  * con_debug_enter - prepare the console for the kernel debugger
- * @sw: console driver
+ * @vc: virtual console
  *
  * Called when the console is taken over by the kernel debugger, this
  * function needs to save the current console state, then put the console
@@ -4038,7 +4037,6 @@ EXPORT_SYMBOL_GPL(con_debug_enter);
 
 /**
  * con_debug_leave - restore console state
- * @sw: console driver
  *
  * Restore the console state to what it was before the kernel debugger
  * was invoked.
-- 
2.8.1

