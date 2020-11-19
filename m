Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9F22B989C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgKSQuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgKSQub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:50:31 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF55C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:50:31 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id s25so8870063ejy.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K5GZeuLu/jMeMq/qk59Ov5I88ZeG8YzR1lz+4Zy1qMM=;
        b=Xqqqbgk1TZPd5MGqx0hl0ufLtgdXiup0TuOS7Lk2DOV+Szs9R8YriQWLCBj2igBjB6
         kPH3Fa8tSgYHlbuwkX/1xEXwYsU0Rqw4NhuAg5aClOCPcGIVmxqwRdDZmiQakMv/qITt
         tQNzKpbOhS5pg5JdI/cdZSqfDIaP72sUDcXBlkDoHAxysbTxk77EBgwE258Krt2jvW6s
         a4dPYREeOuBYW9hk/mf0lYomk5/u+gijOrdy/ixPdzo+TAjhf64LddcbXbfNYthrdUUE
         8hePO5Y83FrwQbMzNGRlCuREfDjF1Du2GrlmEebNJgKn/wYC9JP15d7F6GwT7XJ6YMRD
         4byA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5GZeuLu/jMeMq/qk59Ov5I88ZeG8YzR1lz+4Zy1qMM=;
        b=YFfXvslcJRgw5MmzsD7lVeycqH/4YlHPs7n8Sx9uGajCrPEDd3weYZ/3CvHKU3AQrc
         JyAO8RHJUrJAwM3ondZ62u1qacThu6b1EG9AtqR6IG/tskWzmrczGQj3XJVtr/v56zgy
         Nu5KSoEHdhhyrxtKOeRIxnMlmvIVAe0acKpiGF2Km31iCiHRm10a5cf2m2tmEeOCGJWb
         UexYB5gYRxzJ/MeHFjTfnNPJiS2CL46T6U1KOeu5IHDp3+Yny/SA+CuVPmfEQnusKP1h
         ZPG3UHO0NUkRGJ5Zf9VjzQ8bqdg/3iu6iR460NPy8WIDhAyW01fXu3Kxabps3HVpOsyk
         4u5A==
X-Gm-Message-State: AOAM533Zz1pxa0g4L1Wl8JtG6XDQCwEze9VjVY8qqvPrBCMzWXDAmbPo
        lHhh7Q3qb0fdK1UstPmXGKY=
X-Google-Smtp-Source: ABdhPJxeVYuKYcjv/vaWyqwGqwrJHZR/GEudd/M6ZBAKhHtipmUv8edZVfXCMxR3EZGarxxFehQiWg==
X-Received: by 2002:a17:906:fcc2:: with SMTP id qx2mr30219645ejb.549.1605804629689;
        Thu, 19 Nov 2020 08:50:29 -0800 (PST)
Received: from yoga-910.localhost ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id s15sm2176edj.75.2020.11.19.08.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 08:50:29 -0800 (PST)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Ionut-robert Aron <ionut-robert.aron@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/3] staging: dpaa2-switch: export the 'no buffer' counter in ethtool
Date:   Thu, 19 Nov 2020 18:50:15 +0200
Message-Id: <20201119165017.806696-2-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119165017.806696-1-ciorneiioana@gmail.com>
References: <20201119165017.806696-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ionut-robert Aron <ionut-robert.aron@nxp.com>

Export the DPSW_CNT_ING_NO_BUFFER_DISCARD counter in ethtool for each
switch interface. This is useful for debugging purposes.

Signed-off-by: Ionut-robert Aron <ionut-robert.aron@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h      | 8 +++++---
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h          | 6 ++++--
 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c | 2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
index f100d503bd17..c9fb688f387c 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2014-2016 Freescale Semiconductor Inc.
- * Copyright 2017-2018 NXP
+ * Copyright 2017-2020 NXP
  *
  */
 
@@ -10,12 +10,14 @@
 
 /* DPSW Version */
 #define DPSW_VER_MAJOR		8
-#define DPSW_VER_MINOR		1
+#define DPSW_VER_MINOR		5
 
 #define DPSW_CMD_BASE_VERSION	1
+#define DPSW_CMD_VERSION_2	2
 #define DPSW_CMD_ID_OFFSET	4
 
 #define DPSW_CMD_ID(id)	(((id) << DPSW_CMD_ID_OFFSET) | DPSW_CMD_BASE_VERSION)
+#define DPSW_CMD_V2(id) (((id) << DPSW_CMD_ID_OFFSET) | DPSW_CMD_VERSION_2)
 
 /* Command IDs */
 #define DPSW_CMDID_CLOSE                    DPSW_CMD_ID(0x800)
@@ -38,7 +40,7 @@
 #define DPSW_CMDID_IF_SET_TCI               DPSW_CMD_ID(0x030)
 #define DPSW_CMDID_IF_SET_STP               DPSW_CMD_ID(0x031)
 
-#define DPSW_CMDID_IF_GET_COUNTER           DPSW_CMD_ID(0x034)
+#define DPSW_CMDID_IF_GET_COUNTER           DPSW_CMD_V2(0x034)
 
 #define DPSW_CMDID_IF_ENABLE                DPSW_CMD_ID(0x03D)
 #define DPSW_CMDID_IF_DISABLE               DPSW_CMD_ID(0x03E)
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
index ab63ee4f5cb7..9cfd8a8e0197 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
@@ -334,9 +334,10 @@ enum dpsw_accepted_frames {
  * @DPSW_CNT_ING_BCAST_FRAME: Counts ingress broadcast frames
  * @DPSW_CNT_ING_BCAST_BYTES: Counts ingress broadcast bytes
  * @DPSW_CNT_EGR_FRAME: Counts egress frames
- * @DPSW_CNT_EGR_BYTE: Counts eEgress bytes
+ * @DPSW_CNT_EGR_BYTE: Counts egress bytes
  * @DPSW_CNT_EGR_FRAME_DISCARD: Counts discarded egress frames
  * @DPSW_CNT_EGR_STP_FRAME_DISCARD: Counts egress STP discarded frames
+ * @DPSW_CNT_ING_NO_BUFF_DISCARD: Counts ingress no buffer discarded frames
  */
 enum dpsw_counter {
 	DPSW_CNT_ING_FRAME = 0x0,
@@ -350,7 +351,8 @@ enum dpsw_counter {
 	DPSW_CNT_EGR_FRAME = 0x8,
 	DPSW_CNT_EGR_BYTE = 0x9,
 	DPSW_CNT_EGR_FRAME_DISCARD = 0xa,
-	DPSW_CNT_EGR_STP_FRAME_DISCARD = 0xb
+	DPSW_CNT_EGR_STP_FRAME_DISCARD = 0xb,
+	DPSW_CNT_ING_NO_BUFF_DISCARD = 0xc,
 };
 
 int dpsw_if_get_counter(struct fsl_mc_io *mc_io,
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
index ace4a6d28562..fb5a14ac3e4a 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
@@ -24,7 +24,7 @@ static struct {
 	{DPSW_CNT_EGR_FRAME,		"tx frames"},
 	{DPSW_CNT_EGR_BYTE,		"tx bytes"},
 	{DPSW_CNT_EGR_FRAME_DISCARD,	"tx discarded frames"},
-
+	{DPSW_CNT_ING_NO_BUFF_DISCARD,	"rx discarded no buffer frames"},
 };
 
 #define DPAA2_SWITCH_NUM_COUNTERS	ARRAY_SIZE(dpaa2_switch_ethtool_counters)
-- 
2.28.0

