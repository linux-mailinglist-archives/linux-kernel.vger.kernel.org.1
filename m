Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790C4283885
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgJEOwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:52:30 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:41948 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725936AbgJEOwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:52:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UB2zXS9_1601909533;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UB2zXS9_1601909533)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 05 Oct 2020 22:52:13 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi_si: Fix wrong return value in try_smi_init()
Date:   Mon,  5 Oct 2020 22:52:12 +0800
Message-Id: <20201005145212.84435-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an error exit path, a negative error code should be returned
instead of a positive return value.

Fixes: 90b2d4f15ff7 ("ipmi_si: Remove hacks for adding a dummy platform devices")
Cc: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 drivers/char/ipmi/ipmi_si_intf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 77b8d551ae7f..dd559661c15b 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1963,7 +1963,7 @@ static int try_smi_init(struct smi_info *new_smi)
 	/* Do this early so it's available for logs. */
 	if (!new_smi->io.dev) {
 		pr_err("IPMI interface added with no device\n");
-		rv = EIO;
+		rv = -EIO;
 		goto out_err;
 	}
 
-- 
2.24.3 (Apple Git-128)

