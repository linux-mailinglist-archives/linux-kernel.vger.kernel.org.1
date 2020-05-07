Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D321C82AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 08:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgEGGm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 02:42:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbgEGGm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:42:56 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 42318413693EF0A90151;
        Thu,  7 May 2020 14:42:54 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 14:42:45 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Samuel Zou <zou_wei@huawei.com>
Subject: [PATCH -next] ALSA: portman2x4: Use bitwise instead of arithmetic operator for flags
Date:   Thu, 7 May 2020 14:48:55 +0800
Message-ID: <1588834135-14842-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccinelle warning:

sound/drivers/portman2x4.c:460:34-35: WARNING: sum of probable bitmasks, consider |

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 sound/drivers/portman2x4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index ecefa7c..38603cb 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -457,7 +457,7 @@ static int portman_probe(struct parport *p)
 
 	/* Set for RXDATA0 where no damage will be done. */
 	/* 5 */
-	parport_write_control(p, RXDATA0 + STROBE);	/* Write Strobe=1 to command reg. */
+	parport_write_control(p, RXDATA0 | STROBE);	/* Write Strobe=1 to command reg. */
 
 	/* 6 */
 	if ((parport_read_status(p) & ESTB) != ESTB)
-- 
2.6.2

