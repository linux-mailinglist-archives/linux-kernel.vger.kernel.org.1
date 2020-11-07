Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D362AA3CD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 09:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgKGITt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 03:19:49 -0500
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:63626 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgKGITs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 03:19:48 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 5A03E66658A;
        Sat,  7 Nov 2020 16:19:46 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Wang Qing <wangqing@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: fix spelling typo of 'wtih'
Date:   Sat,  7 Nov 2020 16:19:39 +0800
Message-Id: <1604737181-14464-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQh1JShpDSx5CS0NOVkpNS09MSExKQ01MSUhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTY6CDo*Qj8sCRwiDyoWTwoD
        Nk0wCkxVSlVKTUtPTEhMSkNMS0JIVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTElKNwY+
X-HM-Tid: 0a75a1ca3b289373kuws5a03e66658a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wtih -> with

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/firmware/raspberrypi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 2371d08..30259dc
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Defines interfaces for interacting wtih the Raspberry Pi firmware's
+ * Defines interfaces for interacting with the Raspberry Pi firmware's
  * property channel.
  *
  * Copyright © 2015 Broadcom
-- 
2.7.4

