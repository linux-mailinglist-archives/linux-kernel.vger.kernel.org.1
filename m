Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DDE2E231E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 02:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgLXBBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 20:01:16 -0500
Received: from ptr.189.cn ([183.61.185.101]:10943 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727621AbgLXBBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 20:01:16 -0500
HMM_SOURCE_IP: 172.27.8.53:57784.1743986218
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [172.27.8.53])
        by 189.cn (HERMES) with SMTP id 59009100785;
        Thu, 24 Dec 2020 08:58:21 +0800 (CST)
Received: from  ([123.150.8.42])
        by SZ-WEBMAIL05 with ESMTP id ba150fcc42f049f7a251a5e26f0c1c00 for greg@kroah.com;
        Thu Dec 24 08:58:22 2020
X-Transaction-ID: ba150fcc42f049f7a251a5e26f0c1c00
X-filter-score: 
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     greg@kroah.com, linux-kernel@vger.kernel.org
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        Song Chen <chensong_2000@189.cn>
Subject: [PATCH] staging: comedi: remove warnings of comedi_lrange
Date:   Thu, 24 Dec 2020 08:58:18 +0800
Message-Id: <1608771498-13335-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch.pl reports "warning: struct comedi_lrange should
normally be const" in some places, which are supposed to
be removed.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 drivers/staging/comedi/drivers/das16.c   | 4 ++--
 drivers/staging/comedi/drivers/jr3_pci.c | 4 ++--
 drivers/staging/comedi/drivers/ni_670x.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/comedi/drivers/das16.c b/drivers/staging/comedi/drivers/das16.c
index 4ac2622..40bfd84 100644
--- a/drivers/staging/comedi/drivers/das16.c
+++ b/drivers/staging/comedi/drivers/das16.c
@@ -958,7 +958,7 @@ static const struct comedi_lrange *das16_ai_range(struct comedi_device *dev,
 
 	/* get any user-defined input range */
 	if (pg_type == das16_pg_none && (min || max)) {
-		struct comedi_lrange *lrange;
+		const struct comedi_lrange *lrange;
 		struct comedi_krange *krange;
 
 		/* allocate single-range range table */
@@ -992,7 +992,7 @@ static const struct comedi_lrange *das16_ao_range(struct comedi_device *dev,
 
 	/* get any user-defined output range */
 	if (min || max) {
-		struct comedi_lrange *lrange;
+		const struct comedi_lrange *lrange;
 		struct comedi_krange *krange;
 
 		/* allocate single-range range table */
diff --git a/drivers/staging/comedi/drivers/jr3_pci.c b/drivers/staging/comedi/drivers/jr3_pci.c
index 7a02c4f..c35db0b 100644
--- a/drivers/staging/comedi/drivers/jr3_pci.c
+++ b/drivers/staging/comedi/drivers/jr3_pci.c
@@ -91,8 +91,8 @@ struct jr3_pci_dev_private {
 };
 
 union jr3_pci_single_range {
-	struct comedi_lrange l;
-	char _reserved[offsetof(struct comedi_lrange, range[1])];
+	const struct comedi_lrange l;
+	char _reserved[offsetof(const struct comedi_lrange, range[1])];
 };
 
 enum jr3_pci_poll_state {
diff --git a/drivers/staging/comedi/drivers/ni_670x.c b/drivers/staging/comedi/drivers/ni_670x.c
index c197e47..66485ec 100644
--- a/drivers/staging/comedi/drivers/ni_670x.c
+++ b/drivers/staging/comedi/drivers/ni_670x.c
@@ -200,7 +200,7 @@ static int ni_670x_auto_attach(struct comedi_device *dev,
 		const struct comedi_lrange **range_table_list;
 
 		range_table_list = kmalloc_array(32,
-						 sizeof(struct comedi_lrange *),
+						 sizeof(const struct comedi_lrange *),
 						 GFP_KERNEL);
 		if (!range_table_list)
 			return -ENOMEM;
-- 
2.7.4

